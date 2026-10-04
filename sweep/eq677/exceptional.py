# For p in exceptional set, for each irreducible factor f of q mod p, work in F_p[x]/(f) with l = x:
# report multiplicity of l as root of q, o(l), mu=-1/l, q(mu), o(mu), l^2+1, mu==l.
import itertools
def pmod(a,f,p):
    a=[c%p for c in a]
    while len(a)>=len(f):
        c=a[-1]*pow(f[-1],p-2,p)%p
        for i in range(len(f)): a[len(a)-len(f)+i]=(a[len(a)-len(f)+i]-c*f[i])%p
        a.pop()
    while a and a[-1]==0: a.pop()
    return a
def pmulm(a,b,f,p):
    r=[0]*(len(a)+len(b)-1 if a and b else 0)
    for i,x in enumerate(a):
        for j,y in enumerate(b): r[i+j]+=x*y
    return pmod(r,f,p)
def ev(coeffs,x,f,p):
    r=[]
    for c in reversed(coeffs): r=pmod([ (u) for u in (pmulm(r,x,f,p) if r else [])] ,f,p); r=pmod((r+[0])[:max(len(r),1)] if r else [0],f,p); r=pmod([ (r[0] if r else 0)+c]+r[1:],f,p)
    return r
def inv(x,f,p):
    # brute force in small field
    d=len(f)-1
    for cs in itertools.product(range(p),repeat=d):
        y=list(cs)
        if pmulm(x,y,f,p)==[1]: return y
def irr_factors(poly,p):
    # q has degree 3: factor via roots
    roots=[r for r in range(p) if sum(c*pow(r,i,p) for i,c in enumerate(poly))%p==0]
    if not roots: return [poly]
    fs=[[(-r)%p,1] for r in roots]
    if len(roots)==1:
        r=roots[0]; # divide q by (x-r): synthetic division
        c2=1; c1=(r*c2)%p; c0=(poly[1]+r*c1)%p  # q = x^3 + 0x^2 - x - 1
        quad=[c0,c1,c2]
        disc_roots=[s for s in range(p) if (quad[0]+quad[1]*s+quad[2]*s*s)%p==0]
        if not disc_roots: fs.append(quad)
    return fs
q=[-1,-1,0,1]; o=[1,1,1,0,1,0,2,0,1]; dq=[-1,0,3]
for p in (5,11,19,23):
    for f in irr_factors(q,p):
        l=[0,1] if len(f)>2 else [(-f[0])%p]
        l=pmod(l,f,p)
        mu=pmod([(-c)%p for c in inv(l,f,p)],f,p)
        print("p=%d factor=%s: q'(l)=%s o(l)=%s q(mu)=%s o(mu)=%s l^2+1=%s mu==l:%s"%(
            p,f,ev(dq,l,f,p),ev(o,l,f,p),ev(q,mu,f,p),ev(o,mu,f,p),ev([1,0,1],l,f,p),mu==l))
