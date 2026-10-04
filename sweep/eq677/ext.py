# Cocycle extensions: base 677 magma M (table), fiber F_p with constants (al, be) solving the
# commutative linear 677 relations mod p.  (x,a)*(y,b) = (x*y, al a + be b + th(x,y)).
# 677 for the extension <=> linear equations on th (n^2 unknowns). 255 fails iff some solution th
# has g3(x) != 0, g3 = fiber of ((x*x)*x)*x at zero fibers.
import sys, itertools
def is677(T):
    n=len(T); return all(T[y][T[x][T[T[y][x]][y]]]==x for x in range(n) for y in range(n))
def is255(T):
    return all(T[T[T[x][x]][x]][x]==x for x in range(len(T)))
def linsols(p):
    return [(a,b) for a in range(p) for b in range(p) if (a*b*(1+b*b)-1)%p==0 and (a+a*a*b*b+b**3)%p==0]
def nullspace(rows, ncols, p):
    rows=[r[:] for r in rows]; piv=[]; r=0
    for c in range(ncols):
        pr=next((i for i in range(r,len(rows)) if rows[i][c]),None)
        if pr is None: continue
        rows[r],rows[pr]=rows[pr],rows[r]; iv=pow(rows[r][c],p-2,p); rows[r]=[x*iv%p for x in rows[r]]
        for i in range(len(rows)):
            if i!=r and rows[i][c]:
                f=rows[i][c]; rows[i]=[(x-f*y)%p for x,y in zip(rows[i],rows[r])]
        piv.append(c); r+=1
    free=[c for c in range(ncols) if c not in piv]; basis=[]
    for fc in free:
        v=[0]*ncols; v[fc]=1
        for i,c in enumerate(piv): v[c]=(-rows[i][fc])%p
        basis.append(v)
    return basis
def run(name, T, p, al, be):
    n=len(T); idx=lambda u,v:u*n+v; rows=[]
    for x in range(n):
        for y in range(n):
            s1=T[y][x]; s2=T[s1][y]; s3=T[x][s2]
            r=[0]*(n*n)
            # f4 = be*(be*(al*th(y,x) + th(s1,y)) + th(x,s2)) + th(y,s3)
            r[idx(y,x)]+=be*be*al; r[idx(s1,y)]+=be*be; r[idx(x,s2)]+=be; r[idx(y,s3)]+=1
            rows.append([c%p for c in r])
    B=nullspace(rows,n*n,p)
    # 255 functional: g3(x) = al*(al*th(x,x) + th(t1,x)) + th(t2,x)
    bad=0
    for v in B:
        for x in range(n):
            t1=T[x][x]; t2=T[t1][x]
            g=(al*al*v[idx(x,x)] + al*v[idx(t1,x)] + v[idx(t2,x)])%p
            if g: bad+=1; break
    # coboundary dimension: th(u,v) = al h(u) + be h(v) - h(u*v); rank of that map
    cob=[]
    for h in range(n):
        v=[0]*(n*n)
        for u in range(n):
            for w in range(n):
                v[idx(u,w)]=((al if u==h else 0)+(be if w==h else 0)-(1 if T[u][w]==h else 0))%p
        cob.append(v)
    cobrank=n-len(nullspace([list(c) for c in zip(*cob)] if cob else [],n,p)) if n else 0
    print("%s p=%d (al,be)=(%d,%d): dim cocycles=%d dim coboundaries=%d  basis vectors failing 255: %d"%(name,p,al,be,len(B),cobrank,bad), flush=True)
    return bad
bases={}
for q in (5,7,11,13):
    for (a,b) in linsols(q):
        bases["Z%d(%dx+%dy)"%(q,a,b)]=[[(a*x+b*y)%q for y in range(q)] for x in range(q)]
bases["trivial"]=[[0]]
maxn=int(sys.argv[1]) if len(sys.argv)>1 else 13
for name,T in bases.items():
    assert is677(T) and is255(T)
    if len(T)>maxn: continue
    for p in (5,7,11,13):
        for (al,be) in linsols(p):
            run(name,T,p,al,be)
