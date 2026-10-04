# Non-commutative ideal membership in Z<A,B> (checked mod a large prime), bounded word length D.
# Two-sided ideal I=(g1,g2); target1 = T-1 in I?  target2 = H in R*K + I ?
import sys, itertools
P=2147483647; D=int(sys.argv[1]); track=len(sys.argv)>2
ALPH="ABC"  # C = inverse of B
invB1={"BC":1,"":-1}; invB2={"CB":1,"":-1}
g1={"BA":1,"BBAB":1,"":-1}; g2={"A":1,"BBAA":1,"BBB":1}; K={"BBA":1,"BB":1,"B":1,"":1}
t1={"AAA":1,"AAB":1,"AB":1,"B":1,"":-1}; t2={"AA":1,"A":1,"":1}
def words(L):
    for l in range(L+1):
        for w in itertools.product(ALPH,repeat=l): yield "".join(w)
def deg(g): return max(len(w) for w in g)
def cols_for(gens_two, gens_left):
    out=[]
    for name,g in gens_two:
        d=D-deg(g)
        for u in words(d):
            for v in words(d-len(u)):
                out.append(((u,name,v),{u+w+v:c for w,c in g.items()}))
    for name,g in gens_left:
        for u in words(D-deg(g)): out.append(((u,name,""),{u+w:c for w,c in g.items()}))
    return out
def member(target, cols):
    basis={}  # pivot word -> (vec, combo)
    def reduce(vec, combo):
        vec=dict(vec)
        while vec:
            pw=max(vec, key=lambda w:(len(w),w))
            if pw not in basis: return vec, combo, pw
            bv,bc=basis[pw]; f=vec[pw]*pow(bv[pw],P-2,P)%P
            for w,c in bv.items():
                nv=(vec.get(w,0)-f*c)%P
                if nv: vec[w]=nv
                else: vec.pop(w,None)
            if track:
                combo=dict(combo)
                for k,c in bc.items():
                    nv=(combo.get(k,0)-f*c)%P
                    if nv: combo[k]=nv
                    else: combo.pop(k,None)
        return vec, combo, None
    for key,vec in cols:
        v,c,pw=reduce({w:x%P for w,x in vec.items() if x%P}, {key:1} if track else {})
        if pw is not None: basis[pw]=(v,c)
    v,c,pw=reduce({w:x%P for w,x in target.items()}, {})
    return (not v), c
ok1,c1=member(t1, cols_for([("g1",g1),("g2",g2),("i1",invB1),("i2",invB2)],[]))
print("D=%d  T-1 in (g1,g2): %s"%(D,ok1))
ok2,c2=member(t2, cols_for([("g1",g1),("g2",g2),("i1",invB1),("i2",invB2)],[("K",K)]))
print("D=%d  H in R K + (g1,g2): %s"%(D,ok2))
if track:
    def show(c): return {k:(-x)%P if (-x)%P<P//2 else (-x)%P-P for k,x in c.items()}
    if ok1: print("cert1 (target = sum coef*u g v):", show(c1))
    if ok2: print("cert2:", show(c2))
