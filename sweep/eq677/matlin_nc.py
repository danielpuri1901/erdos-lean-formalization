# Affine models x*y = A x + B y + c over F_p^k, B ranging over rational canonical forms
# (conjugation (A,B,c) -> (PAP^-1, PBP^-1, Pc) is an isomorphism, so this loses nothing).
# 677 <=> BA + B^2AB = I, A + B^2A^2 + B^3 = 0, (B^2A+B^2+B+I)c = 0.
# 255 <=> A^3+A^2B+AB+B = I and (A^2+A+I)c = 0.
import sys, itertools
p=int(sys.argv[1]); k=int(sys.argv[2]); MAXD=int(sys.argv[3]) if len(sys.argv)>3 else 4
def mul(X,Y): return [[sum(X[i][t]*Y[t][j] for t in range(k))%p for j in range(k)] for i in range(k)]
def add(*Ms): return [[sum(M[i][j] for M in Ms)%p for j in range(k)] for i in range(k)]
I=[[int(i==j) for j in range(k)] for i in range(k)]; Z=[[0]*k for _ in range(k)]
def polymod(a,b):  # a mod b, b monic, coeff lists low->high
    a=a[:]
    while len(a)>=len(b):
        c=a[-1]
        if c:
            for i in range(len(b)): a[len(a)-len(b)+i]=(a[len(a)-len(b)+i]-c*b[i])%p
        a.pop()
    return a
def divides(d,f): return all(x==0 for x in polymod(f,d))
def monic(deg): 
    for cs in itertools.product(range(p),repeat=deg): yield list(cs)+[1]
def companion(f):
    d=len(f)-1; C=[[0]*d for _ in range(d)]
    for i in range(1,d): C[i][i-1]=1
    for i in range(d): C[i][d-1]=(-f[i])%p
    return C
def invfactor_seqs(total, prev=None):
    # sequences d1|d2|...|dr with sum deg = total, each deg>=1, listed with d_r last (largest)
    if total==0: yield []; return
    for deg in range(1,total+1):
        for f in monic(deg):
            if prev is not None and not divides(prev,f): continue
            if prev is not None and deg<len(prev)-1: continue
            for rest in invfactor_seqs(total-deg,f): yield [f]+rest
def blockdiag(blocks):
    M=[[0]*k for _ in range(k)]; o=0
    for C in blocks:
        d=len(C)
        for i in range(d):
            for j in range(d): M[o+i][o+j]=C[i][j]
        o+=d
    return M
def solve(Mat, rhs):  # Mat: m x m over F_p, returns (particular, nullbasis) or None
    m=len(Mat); A=[row[:]+[rhs[i]] for i,row in enumerate(Mat)]; piv=[]; r=0
    for c in range(m):
        pr=next((i for i in range(r,m) if A[i][c]%p),None)
        if pr is None: continue
        A[r],A[pr]=A[pr],A[r]; iv=pow(A[r][c],p-2,p); A[r]=[x*iv%p for x in A[r]]
        for i in range(m):
            if i!=r and A[i][c]:
                fct=A[i][c]; A[i]=[(x-fct*y)%p for x,y in zip(A[i],A[r])]
        piv.append(c); r+=1
    if any(A[i][m]%p for i in range(r,m)): return None
    part=[0]*m
    for i,c in enumerate(piv): part[c]=A[i][m]
    free=[c for c in range(m) if c not in piv]; basis=[]
    for fc in free:
        v=[0]*m; v[fc]=1
        for i,c in enumerate(piv): v[c]=(-A[i][fc])%p
        basis.append(v)
    return part,basis
def tomat(v): return [v[i*k:(i+1)*k] for i in range(k)]
def kernel(M):
    r=solve(M,[0]*k); return r[1]
nB=0; nsol=0; nbad=0; skipped=0; ncnt=0
for seq in invfactor_seqs(k):
    if seq[0][0]==0: continue  # B singular (x | d1 divides all) -> 677 impossible
    B=blockdiag([companion(f) for f in seq]); nB+=1
    B2=mul(B,B); B3=mul(B2,B)
    cols=[]
    for t in range(k*k):
        E=[[int(i*k+j==t) for j in range(k)] for i in range(k)]
        cols.append(sum(add(mul(B,E),mul(mul(B2,E),B)),[]))
    Mat=[[cols[t][r] for t in range(k*k)] for r in range(k*k)]
    res=solve(Mat,sum(I,[]))
    if res is None: continue
    part,basis=res
    if len(basis)>MAXD: skipped+=1; continue
    for coeffs in itertools.product(range(p),repeat=len(basis)):
        v=[(part[i]+sum(c*b[i] for c,b in zip(coeffs,basis)))%p for i in range(k*k)]
        A=tomat(v); A2=mul(A,A)
        if add(A,mul(B2,A2),B3)!=Z: continue
        nsol+=1; nnc = globals().get("nnc",0) + (mul(A,B)!=mul(B,A)); globals()["nnc"]=nnc
        lin255 = add(mul(A2,A),mul(A2,B),mul(A,B),B)==I
        # constants: kernel of K=B^2A+B^2+B+I; need some c with (A^2+A+I)c != 0
        K=add(mul(B2,A),B2,B,I); Kc=kernel(K); H=add(A2,A,I)
        cbad=any(any(sum(H[i][j]*c[j] for j in range(k))%p for i in range(k)) for c in Kc)
        if not lin255 or cbad:
            nbad+=1; ncnt+=1
            if ncnt<=5: print("COUNTEREXAMPLE p=%d k=%d A=%s B=%s lin255=%s cbad=%s"%(p,k,A,B,lin255,cbad))
print("noncommuting sols:",globals().get("nnc",0)); print("p=%d k=%d Breps=%d 677sols=%d fail255=%d skipped(nullity>%d)=%d"%(p,k,nB,nsol,nbad,MAXD,skipped))
