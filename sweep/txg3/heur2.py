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
from collections import Counter
st = Counter()
def search(k, d, x, mode):
    st['nodes'] += 1
    c = cnt(d)
    if 4 * k < c: st['bound'] += 1; return True
    if k == 0: return False
    if mode == 'low':
        u = ((d ^ (d + 1))).bit_length() - 1
        br = [w for w in cn[u] if not (d >> w) & 1 and not (x >> w) & 1]
    else:
        best = None
        for u in range(N):
            if (d >> u) & 1: continue
            br = [w for w in cn[u] if not (d >> w) & 1 and not (x >> w) & 1]
            if best is None or len(br) < len(best[1]): best = (u, br)
        u, br = best
    st['internal'] += 1
    if not br: st['empty'] += 1
    for w in br:
        if not search(k - 1, d | cm[w], x, mode): return False
        x |= 1 << w
    return True
for mode in ('low', 'min'):
    st.clear()
    print(mode, search(15, 0, 0, mode), dict(st))
