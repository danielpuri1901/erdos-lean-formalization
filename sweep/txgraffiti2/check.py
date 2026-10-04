# Independent check: follows the Lean definitions literally (step iterated card V times,
# Z = least card of a forcing set, alpha = max independent set), labelled subcubic graphs.
import itertools, sys
def step(n, adj, S):
    new = set(S)
    for w in range(n):
        if w in S: continue
        for v in S:
            if w in adj[v] and all((u == w) for u in adj[v] if u not in S):
                new.add(w); break
    return frozenset(new)
def forcing(n, adj, S):
    for _ in range(n): S = step(n, adj, S)
    return len(S) == n
def Z(n, adj):
    for k in range(n + 1):
        for S in itertools.combinations(range(n), k):
            if forcing(n, adj, frozenset(S)): return k
def alpha(n, adj):
    for k in range(n, -1, -1):
        for S in itertools.combinations(range(n), k):
            if all(b not in adj[a] for a, b in itertools.combinations(S, 2)): return k
def conn(n, adj):
    seen = {0}; st = [0]
    while st:
        v = st.pop()
        for u in adj[v]:
            if u not in seen: seen.add(u); st.append(u)
    return len(seen) == n
for n in range(1, int(sys.argv[1]) + 1):
    pairs = list(itertools.combinations(range(n), 2))
    classes = set(); lab = tight = fail = 0
    for mask in range(1 << len(pairs)):
        E = [pairs[i] for i in range(len(pairs)) if mask >> i & 1]
        adj = [set() for _ in range(n)]
        for a, b in E: adj[a].add(b); adj[b].add(a)
        if max(len(s) for s in adj) > 3 or not conn(n, adj): continue
        lab += 1
        z, a = Z(n, adj), alpha(n, adj)
        if z > a + 1: fail += 1
        if z == a + 1: tight += 1
        canon = min(tuple(sorted(tuple(sorted((p[x], p[y]))) for x, y in E)) for p in itertools.permutations(range(n)))
        classes.add(canon)
    print(f"n={n} labelled={lab} classes={len(classes)} tight={tight} fails={fail}")
