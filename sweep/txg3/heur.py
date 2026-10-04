import sys
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
stats = {'nodes': 0}
def search(k, d, x=0, useX=False):
    stats['nodes'] += 1
    c = cnt(d)
    if 4 * k < c: return True
    if k == 0: return False
    best = None
    for u in range(N):
        if (d >> u) & 1: continue
        br = [w for w in cn[u] if not (d >> w) & 1 and not (x >> w) & 1]
        if best is None or len(br) < len(best[1]): best = (u, br)
    u, br = best
    if not br: return True
    ok = True
    for w in br:
        if not search(k - 1, d | cm[w], x, useX): ok = False; break
        if useX: x |= 1 << w
    return ok
for useX in (False, True):
    stats['nodes'] = 0
    print(useX, search(15, 0, 0, useX), stats)
