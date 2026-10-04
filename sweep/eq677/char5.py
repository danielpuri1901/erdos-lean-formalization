# Char 5, eigenvalue 2 (q(2)=0, 2^2=-1): B = blockdiag(2I+Jordan) ⊕ optional other blocks.
# Solve BA + B^2AB = I (linear in A), report solution dim, enumerate if small, test g2 and 255.
import sys, itertools
exec(open("matlin.py").read().split("nB=0")[0].replace("p=int(sys.argv[1]); k=int(sys.argv[2]); MAXD=int(sys.argv[3]) if len(sys.argv)>3 else 4","p=5; k=int(sys.argv[1]); MAXD=int(sys.argv[2])"))
def partitions(n,mx=None):
    if n==0: yield []; return
    for s in range(min(n,mx or n),0,-1):
        for r in partitions(n-s,s): yield [s]+r
def jordan(lam,s):
    return [[lam if i==j else (1 if j==i+1 else 0) for j in range(s)] for i in range(s)]
others=[[[4]],[[3]],[[1]]]  # also mix with eigenvalue 4,3,1 1x1 blocks
for part in partitions(k):
    B=blockdiag([jordan(2,s) for s in part])
    B2=mul(B,B); B3=mul(B2,B)
    cols=[]
    for t in range(k*k):
        E=[[int(i*k+j==t) for j in range(k)] for i in range(k)]
        cols.append(sum(add(mul(B,E),mul(mul(B2,E),B)),[]))
    Mat=[[cols[t][r] for t in range(k*k)] for r in range(k*k)]
    res=solve(Mat,sum(I,[]))
    if res is None: print("partition",part,": BA+B^2AB=I has no solution"); continue
    part_,basis=res
    print("partition",part,": solution dim",len(basis),flush=True)
    if len(basis)>MAXD: print("  skipped (dim>MAXD)"); continue
    nsol=0; nnc=0; bad=0
    for coeffs in itertools.product(range(p),repeat=len(basis)):
        v=[(part_[i]+sum(c*b[i] for c,b in zip(coeffs,basis)))%p for i in range(k*k)]
        A=tomat(v); A2=mul(A,A)
        if add(A,mul(B2,A2),B3)!=Z: continue
        nsol+=1; nnc+=(mul(A,B)!=mul(B,A))
        lin255 = add(mul(A2,A),mul(A2,B),mul(A,B),B)==I
        K=add(mul(B2,A),B2,B,I); Kc=kernel(K); H=add(A2,A,I)
        cbad=any(any(sum(H[i][j]*c[j] for j in range(k))%p for i in range(k)) for c in Kc)
        if not lin255 or cbad:
            bad+=1
            if bad<=3: print("  COUNTEREXAMPLE A=",A,"B=",B,lin255,cbad)
    print("  677 solutions:",nsol,"non-commuting:",nnc,"failing 255:",bad,flush=True)
