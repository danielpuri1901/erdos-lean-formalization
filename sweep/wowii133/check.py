"""Independent exact checker for wowii133: rad + (hasC4 ? 1 : l(G)) <= path(G).
Pure Python, general indepNum (no C4-free shortcut)."""
import itertools, sys
from fractions import Fraction

def adjsets(n, edges):
    A = [set() for _ in range(n)]
    for u, v in edges:
        if u != v:
            A[u].add(v); A[v].add(u)
    return A

def bfs(A, s):
    d = {s: 0}; fr = [s]
    while fr:
        nf = []
        for u in fr:
            for w in A[u]:
                if w not in d:
                    d[w] = d[u] + 1; nf.append(w)
        fr = nf
    return d

def rad(A):
    n = len(A); r = None
    for s in range(n):
        d = bfs(A, s)
        if len(d) < n: return None
        e = max(d.values()); r = e if r is None else min(r, e)
    return r

def indep(A, S):
    S = list(S); best = 0
    # simple branch and bound
    def go(cand, size):
        nonlocal best
        if size + len(cand) <= best: return
        if not cand:
            best = max(best, size); return
        v = cand[0]
        go([w for w in cand[1:] if w not in A[v]], size + 1)
        go(cand[1:], size)
    go(S, 0)
    return best

def lavg(A):
    return Fraction(sum(indep(A, A[v]) for v in range(len(A))), len(A))

def hasC4(A):
    n = len(A)
    for a in range(n):
        for b in range(a + 1, n):
            if len(A[a] & A[b]) >= 2: return True
    return False

def path_at_least(A, target):
    """return length of an induced path with >= target vertices if found, else exact max."""
    n = len(A); best = [1]; witness = [None]
    sys.setrecursionlimit(10000)
    def dfs(p, forbid):
        if len(p) > best[0]:
            best[0] = len(p); witness[0] = list(p)
        if best[0] >= target: return True
        last = p[-1]
        for w in A[last]:
            if w in forbid or w in p: continue
            p.append(w)
            if dfs(p, forbid | A[last]): return True
            p.pop()
        return False
    for s in range(n):
        if dfs([s], frozenset()): break
    return best[0], witness[0]

def is_induced_path(A, p):
    if len(set(p)) != len(p): return False
    for i in range(len(p)):
        for j in range(len(p)):
            if (p[j] in A[p[i]]) != (abs(i - j) == 1): return False
    return True

def check(name, n, edges, exact=False):
    A = adjsets(n, edges)
    r = rad(A)
    if r is None:
        print(name, "disconnected"); return
    c4 = hasC4(A)
    l = lavg(A)
    rhs = r + (1 if c4 else l)
    import math
    target = math.ceil(rhs) if not exact else n + 1
    p, w = path_at_least(A, target)
    assert is_induced_path(A, w)
    ok = p >= rhs
    print(f"{name}: n={n} m={len(edges)} rad={r} C4={c4} l={float(l):.4f} need>={float(rhs):.4f} found_path={p} {'OK' if ok else 'FAIL'}", flush=True)
    return ok
