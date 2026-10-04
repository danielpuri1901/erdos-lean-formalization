# Own search for the txgraffiti3 certificate (independent domination number >= 16).
import sys
sys.setrecursionlimit(10000)
E = [tuple(map(int, l.split())) for l in open('data/txgraffiti3/counterexample.edgelist')]
N = 48
adj = [set() for _ in range(N)]
for a, b in E:
    adj[a].add(b); adj[b].add(a)
assert all(len(adj[v]) == 3 for v in range(N)) and len(E) == 72
cm = [(1 << v) | sum(1 << w for w in adj[v]) for v in range(N)]
FULL = (1 << N) - 1
def cnt(d): return bin(FULL & ~d).count('1')
def pick(d): return ((d ^ (d + 1))).bit_length() - 1
stats = {'nodes': 0, 'internal': 0}
def search(k, d):
    stats['nodes'] += 1
    c = cnt(d)
    if 4 * k < c: return True
    if k == 0: return False
    u = pick(d)
    if not (u < N and not (d >> u) & 1): return False
    stats['internal'] += 1
    cn = [u] + sorted(adj[u])
    return all(((d >> w) & 1) or search(k - 1, d | cm[w]) for w in cn)
K = int(sys.argv[1]) if len(sys.argv) > 1 else 15
print(K, search(K, 0), stats)
