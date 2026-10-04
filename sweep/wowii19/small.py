# Enumerate connected graphs on 2..N vertices up to isomorphism (vertex addition +
# canonical form by colour refinement + permutations inside cells), and check claim 19.
import sys, itertools
from fractions import Fraction

def refine(n, adj):
    col = [0]*n
    while True:
        sig = [(col[v], tuple(sorted(col[u] for u in range(n) if adj[v]>>u&1))) for v in range(n)]
        keys = sorted(set(sig))
        new = [keys.index(s) for s in sig]
        if len(set(new)) == len(set(col)) and all((new[a]==new[b])==(col[a]==col[b]) for a in range(n) for b in range(n)):
            return new
        col = new

def canon(n, adj):
    col = refine(n, adj)
    cells = {}
    for v in range(n): cells.setdefault(col[v], []).append(v)
    order = [cells[k] for k in sorted(cells)]
    best = None
    for perms in itertools.product(*[itertools.permutations(c) for c in order]):
        p = [v for c in perms for v in c]  # p[i] = old vertex at new position i
        code = 0
        for i in range(n):
            for j in range(i+1, n):
                code = code*2 + (adj[p[i]]>>p[j]&1)
        if best is None or code > best: best = code
    return best

def connected(n, adj):
    seen = 1; stack=[0]
    while stack:
        v=stack.pop(); m = adj[v] & ~seen
        seen |= m
        for u in range(n):
            if m>>u&1: stack.append(u)
    return seen == (1<<n)-1

def alpha(mask, adj):
    if mask == 0: return 0
    v = (mask & -mask).bit_length()-1
    rest = mask & ~(1<<v)
    a = alpha(rest, adj)
    b = 1 + alpha(rest & ~adj[v], adj)
    return max(a,b)

def bipartite_set(S, adj):
    col = {}
    for s in range(len(adj)):
        if not (S>>s&1) or s in col: continue
        col[s]=0; st=[s]
        while st:
            v=st.pop()
            for u in range(len(adj)):
                if S>>u&1 and adj[v]>>u&1:
                    if u not in col: col[u]=1-col[v]; st.append(u)
                    elif col[u]==col[v]: return False
    return True

def bnum(n, adj):
    best = 0
    for S in range(1<<n):
        c = bin(S).count('1')
        if c > best and bipartite_set(S, adj): best = c
    return best

def ecc(n, adj, v):
    dist = {v:0}; fr=[v]
    while fr:
        nf=[]
        for x in fr:
            for u in range(n):
                if adj[x]>>u&1 and u not in dist: dist[u]=dist[x]+1; nf.append(u)
        fr=nf
    return max(dist.values())

def evaluate(n, adj):
    e = [ecc(n, adj, v) for v in range(n)]
    l = [alpha(adj[v], adj) for v in range(n)]
    rhs = (Fraction(sum(e), n) + max(l))
    fl = rhs.numerator // rhs.denominator
    return bnum(n, adj), fl

def main():
    N = int(sys.argv[1])
    level = {1: [(1, (0,))]}
    graphs = [[0]]
    tot=fail=tight=0
    for n in range(2, N+1):
        seen = set(); new=[]
        for g in graphs:
            for m in range(1<<(n-1)):
                adj = list(g) + [m]
                for u in range(n-1):
                    if m>>u&1: adj[u] |= 1<<(n-1)
                c = canon(n, adj)
                if c in seen: continue
                seen.add(c); new.append(adj)
        graphs = new
        cn = [g for g in graphs if connected(n, g)]
        f=t=0
        for g in cn:
            b, fl = evaluate(n, g)
            if b < fl: f+=1; print("FAIL", n, g)
            if b == fl: t+=1
        print(n, "all", len(graphs), "connected", len(cn), "fail", f, "tight", t, flush=True)
        tot+=len(cn); fail+=f; tight+=t
    print("total connected", tot, "fail", fail, "tight", tight)

if __name__ == '__main__':
    main()
