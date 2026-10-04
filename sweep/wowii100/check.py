# Exhaustive/random check of conjecture 100 and of every step of the proof in NOTES.md.
import itertools, random, math, sys
def alpha_set(adj, verts):
    # max independent subset of verts (list), returns a max set
    best=[]
    verts=list(verts)
    def rec(cand, cur):
        nonlocal best
        if len(cur)+len(cand)<=len(best): return
        if not cand:
            best=list(cur); return
        v=cand[0]
        rec([u for u in cand[1:] if not adj[v]>>u&1], cur+[v])
        rec(cand[1:], cur)
    rec(verts, [])
    return best
def connected(n, adj):
    seen=1; st=[0]
    while st:
        v=st.pop()
        nb=adj[v]&~seen
        seen|=nb
        for u in range(n):
            if nb>>u&1: st.append(u)
    return seen==(1<<n)-1
def check(n, adj):
    I=alpha_set(adj, range(n)); A=len(I)
    deg=[bin(adj[v]).count('1') for v in range(n)]
    c=[n-1-deg[v] for v in range(n)]
    M=max(len(alpha_set(adj,[u for u in range(n) if adj[v]>>u&1])) for v in range(n))
    S=sum(x*x for x in c)
    t=2*A-2-M
    conj = t<0 or S>4*t*t
    Iset=set(I); R=[w for w in range(n) if w not in Iset]; K=len(R)
    E=sum(deg[u] for u in I)
    P=sum(c[u] for u in I); SI=sum(c[u]**2 for u in I); SR=sum(c[w]**2 for w in R)
    steps = [
        M<=A, M>=1,
        all(sum(1 for u in I if adj[w]>>u&1)<=M for w in R),
        all(deg[u]>=1 for u in I),
        E==sum(sum(1 for u in I if adj[w]>>u&1) for w in R),
        A<=E<=K*M,
        P==A*(n-1)-E,
        A*SI>=P*P,
        all(c[w]>=A-M for w in R),
        P*M>=A*(M*A+A-2*M),
        (M==A) or SR>=1,
    ]
    return conj, steps, (t>=0 and S==4*t*t+0), A, M, S, t
def canon(n, edges):
    best=None
    for p in itertools.permutations(range(n)):
        e=tuple(sorted(tuple(sorted((p[a],p[b]))) for a,b in edges))
        if best is None or e<best: best=e
    return best
fails=0; stepfails=0; total=0
tight_unl={}
for n in range(2,7):
    pairs=list(itertools.combinations(range(n),2))
    seen=set(); cnt=0; tight=0
    for mask in range(1<<len(pairs)):
        adj=[0]*n; edges=[]
        for i,(a,b) in enumerate(pairs):
            if mask>>i&1: adj[a]|=1<<b; adj[b]|=1<<a; edges.append((a,b))
        if not connected(n,adj): continue
        total+=1
        conj,steps,_,A,M,S,t=check(n,adj)
        if not conj: fails+=1; print("FAIL",n,edges)
        if not all(steps): stepfails+=1; print("STEPFAIL",n,edges,steps)
        if n<=6:
            cf=canon(n,edges)
            if cf in seen: continue
            seen.add(cf); cnt+=1
            # tight: alpha == ceil((M+0.5 sqrt S)/2)
            x=(M+0.5*math.sqrt(S))/2
            if A==math.ceil(x-1e-12): tight+=1
    tight_unl[n]=(cnt,tight)
print("labeled connected graphs n=2..6:",total,"conj fails",fails,"step fails",stepfails)
print("unlabeled (count, tight):",tight_unl)
random.seed(int(sys.argv[1]) if len(sys.argv)>1 else 1)
rt=0
for trial in range(int(sys.argv[2]) if len(sys.argv)>2 else 20000):
    n=random.randint(7,16); p=random.choice([0.1,0.15,0.2,0.3,0.5,0.7,0.9])
    adj=[0]*n
    # random spanning tree for connectivity, then extra edges
    for v in range(1,n):
        u=random.randrange(v); adj[u]|=1<<v; adj[v]|=1<<u
    for a in range(n):
        for b in range(a+1,n):
            if random.random()<p: adj[a]|=1<<b; adj[b]|=1<<a
    conj,steps,_,A,M,S,t=check(n,adj); rt+=1
    if not conj: print("RFAIL",n,adj)
    if not all(steps): print("RSTEPFAIL",n,adj,steps)
print("random graphs n=7..16:",rt,"done")
