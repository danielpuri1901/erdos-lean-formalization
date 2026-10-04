# Generates the certificate for "no independent dominating set with <= 15 vertices"
# and the Lean files Solution/TxDefs.lean (tables), Solution/TxChunk*.lean, Solution/TxTop.lean.
import sys, os
sys.setrecursionlimit(10000)
E = [tuple(map(int, l.split())) for l in open('data/txgraffiti3/counterexample.edgelist')]
N = 48
adj = [set() for _ in range(N)]
for a, b in E:
    adj[a].add(b); adj[b].add(a)
cm = [(1 << v) | sum(1 << w for w in adj[v]) for v in range(N)]
cn = [[v] + sorted(adj[v]) for v in range(N)]
FULL = (1 << N) - 1
def cnt(d): return bin(FULL & ~d).count('1')

# tree node: [kind, k, d, x, u, children, size]
def search(k, d, x):
    if 4 * k < cnt(d):
        return ['L', k, d, x, None, [], 1]
    assert k > 0
    best = None
    for u in range(N):
        if (d >> u) & 1: continue
        br = [w for w in cn[u] if not (d >> w) & 1 and not (x >> w) & 1]
        if best is None or len(br) < len(best[1]): best = (u, br)
    u, br = best
    x0 = x
    ch = []
    for w in cn[u]:
        if (d >> w) & 1 or (x >> w) & 1: continue
        ch.append(search(k - 1, d | cm[w], x))
        x |= 1 << w
    return ['B', k, d, x0, u, ch, 1 + sum(c[6] for c in ch)]

K = 15
root = search(K, 0, 0)
print('nodes', root[6], file=sys.stderr)
LIMIT = int(sys.argv[1]) if len(sys.argv) > 1 else 6000

frontier = []
def entries(node, top):
    # preorder entries; in the top tree, subtrees of size <= LIMIT become frontier entries (49)
    out = []
    def go(n, isroot):
        if top and not isroot and n[6] <= LIMIT:
            frontier.append(n); out.append(49); return
        if n[0] == 'L': out.append(48); return
        out.append(n[4])
        for c in n[5]: go(c, False)
    go(node, True)
    return out

def enc(es):
    v = 0
    for e in reversed(es):
        v = v * 64 + e
    return v

top = entries(root, True)
print('top entries', len(top), 'frontier', len(frontier), file=sys.stderr)
chunks = [(n[1], n[2], n[3], entries(n, False)) for n in frontier]
# sanity: re-run a python model of the Lean checker
def bit(d, v): return (d >> v) & 1 == 1
def chk(ok, k, d, x, c):
    e = c & 63; c2 = c >> 6
    if e == 48: return c2 if 4 * k < cnt(d) else None
    if e == 49: return c2 if (k, d, x) in ok else None
    if k == 0 or not (e < 48 and not bit(d, e)): return None
    for w in cn[e]:
        if bit(d, w) or bit(x, w): continue
        c2 = chk(ok, k - 1, d | cm[w], x, c2)
        if c2 is None: return None
        x |= 1 << w
    return c2
for (k, d, x, es) in chunks:
    assert chk(set(), k, d, x, enc(es)) == 0
okset = set((k, d, x) for (k, d, x, _) in chunks)
assert chk(okset, K, 0, 0, enc(top)) == 0
import json
json.dump({'top': top, 'chunks': [[k, d, x, es] for (k, d, x, es) in chunks], 'cm': cm, 'cn': cn}, open('sweep/txg3/cert.json', 'w'))
print('sizes', sorted(len(c[3]) for c in chunks), file=sys.stderr)
