# Independent count of connected C4-free graphs up to isomorphism for n <= 6 (labelled brute force).
import itertools
for n in range(2, 7):
    pairs = list(itertools.combinations(range(n), 2))
    perms = list(itertools.permutations(range(n)))
    seen = set(); tight = 0
    for mask in range(1 << len(pairs)):
        E = [pairs[i] for i in range(len(pairs)) if mask >> i & 1]
        A = [set() for _ in range(n)]
        for u, v in E: A[u].add(v); A[v].add(u)
        if any(len(A[a] & A[b]) >= 2 for a, b in pairs): continue
        s = {0}; fr = [0]
        while fr:
            fr = [w for u in fr for w in A[u] if w not in s] ; s |= set(fr)
        if len(s) < n: continue
        key = min(tuple(sorted(tuple(sorted((p[u], p[v]))) for u, v in E)) for p in perms)
        seen.add(key)
    print(n, len(seen))
