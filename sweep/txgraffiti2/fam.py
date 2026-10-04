# structured families of connected subcubic graphs, output graph6
import itertools, random, sys
from g6 import g6
def gp(m, k):
    E = [(i, (i+1) % m) for i in range(m)] + [(i, m+i) for i in range(m)] + [(m+i, m+(i+k) % m) for i in range(m)]
    return 2*m, E
def prism(m): return gp(m, 1) if m >= 3 else None
def mobius(m):  # Möbius ladder on 2m vertices
    N = 2*m; E = [(i, (i+1) % N) for i in range(N)] + [(i, i+m) for i in range(m)]
    return N, E
def lcf(N, code):
    E = [(i, (i+1) % N) for i in range(N)]
    for i in range(N):
        j = (i + code[i % len(code)]) % N
        if i < j: E.append((i, j))
    return N, E
def truncate(n, E):
    # replace each vertex by a clique on its degree (triangle for degree 3)
    ports = {v: [] for v in range(n)}; idx = 0; NE = []
    newid = {}
    for (a, b) in E:
        for v in (a, b):
            newid[(v, len(ports[v]))] = idx; ports[v].append(idx); idx += 1
        NE.append((ports[a][-1], ports[b][-1]))
    for v in range(n):
        for x, y in itertools.combinations(ports[v], 2): NE.append((x, y))
    return idx, NE
def flower(k):  # flower snark J_k, k odd
    # vertices a_i, b_i, c_i, d_i
    A = lambda i: 4*(i % k); B = lambda i: 4*(i % k)+1; C = lambda i: 4*(i % k)+2; D = lambda i: 4*(i % k)+3
    E = []
    for i in range(k):
        E += [(A(i), B(i)), (A(i), C(i)), (A(i), D(i)), (B(i), B(i+1))]
    for i in range(k-1):
        E += [(C(i), C(i+1)), (D(i), D(i+1))]
    E += [(C(k-1), D(0)), (D(k-1), C(0))]
    return 4*k, E
def cleanup(n, E):
    S = set((min(a, b), max(a, b)) for a, b in E if a != b)
    return n, sorted(S)
def ok(n, E):
    deg = [0]*n
    for a, b in E: deg[a] += 1; deg[b] += 1
    if max(deg) > 3 or len(set(E)) != len(E): return False
    return n <= 64
out = []
for m in range(3, 33):
    for k in range(1, m//2 + 1):
        if 2*k == m: continue
        out.append(gp(m, k))
for m in range(2, 33): out.append(mobius(m))
named = {
 'heawood': lcf(14, [5, -5]), 'mcgee': lcf(24, [12, 7, -7]), 'tutte8cage': lcf(30, [-13, -9, 7, -7, 9, 13]),
 'f26a': lcf(26, [-7, 7]), 'franklin': lcf(12, [5, -5]), 'frucht': lcf(12, [-5, -2, -4, 2, 5, -2, 2, 5, -2, -5, 4, 2]),
 'dyck': lcf(32, [5, -5, 13, -13]), 'foster': lcf(90, [17, -9, 37, -37, 9, -17]),
 'gray': lcf(54, [-25, 7, -7, 13, -13, 25]), 'tietze_like': lcf(12, [-3, 3]), 'k33': lcf(6, [3]),
 'truncated_tetra': lcf(12, [2, 6, -2]), 'pappus': lcf(18, [5, 7, -7, 7, -7, -5]),
 'desargues': lcf(20, [5, -5, 9, -9]), 'nauru': lcf(24, [5, -9, 7, -7, 9, -5]),
 'tutte12cage_skip': None,
}
for k, g in named.items():
    if g: out.append(g)
for k in (3, 5, 7, 9, 11, 13, 15): out.append(flower(k))
# truncations of small cubic graphs (claw-free cubic graphs)
base = [gp(5, 2), lcf(6, [3]), prism(3), gp(4, 1), lcf(14, [5, -5]), gp(8, 3), gp(10, 2), gp(10, 3), mobius(4), mobius(5), mobius(6), prism(5), prism(6), (4, list(itertools.combinations(range(4), 2)))]
for g in base:
    out.append(truncate(*g))
# also truncations of random cubic graphs
random.seed(1)
def rand_cubic(m):
    while True:
        pts = [i // 3 for i in range(3*m)]; random.shuffle(pts)
        E = [(pts[i], pts[i+1]) for i in range(0, 3*m, 2)]
        if any(a == b for a, b in E): continue
        S = set((min(a, b), max(a, b)) for a, b in E)
        if len(S) != len(E): continue
        adj = {v: set() for v in range(m)}
        for a, b in S: adj[a].add(b); adj[b].add(a)
        seen = {0}; st = [0]
        while st:
            v = st.pop()
            for u in adj[v]:
                if u not in seen: seen.add(u); st.append(u)
        if len(seen) == m: return m, sorted(S)
for m in (4, 6, 8, 10, 12, 14, 16, 18, 20):
    for _ in range(30): out.append(truncate(*rand_cubic(m)))
for n, E in out:
    n, E = cleanup(n, E)
    if ok(n, E): print(g6(n, E))
