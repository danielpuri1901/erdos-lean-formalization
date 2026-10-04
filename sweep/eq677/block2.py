# 2-dim block candidates: B = diag(l, m), m = -1/l, q(l) = l^3 - l - 1 = 0, A = [[al, e],[f, am]].
# (derived in NOTES: off-diagonal A-blocks need q(l)=0). Check over F_p for p < N.
import sys
N=int(sys.argv[1])
def isprime(n): return n>1 and all(n%d for d in range(2,int(n**.5)+1))
def inv(x,p): return pow(x%p,p-2,p)
def mm(X,Y,p): return [[(X[0][0]*Y[0][j]+X[0][1]*Y[1][j])%p for j in range(2)] for X0 in [0] for _ in [0]] if False else [[sum(X[i][t]*Y[t][j] for t in range(2))%p for j in range(2)] for i in range(2)]
def ad(p,*Ms): return [[sum(M[i][j] for M in Ms)%p for j in range(2)] for i in range(2)]
found=0
for p in range(3,N):
    if not isprime(p): continue
    for l in range(1,p):
        if (l**3-l-1)%p: continue
        m=(-inv(l,p))%p
        if m==l: print("p=%d l=%d: l = -1/l (degenerate, skip)"%(p,l)); continue
        if (l*l+1)%p==0: continue
        al=inv(l**3+l,p); am=inv(m**3+m,p)
        cl=(al+l*l*al*al+l**3)%p; cm=(am+m*m*am*am+m**3)%p
        sl=(-cl*inv(l*l,p))%p; sm=(-cm*inv(m*m,p))%p   # need ef = sl = sm
        if sl!=sm: print("p=%d l=%d m=%d: inconsistent ef=%d vs %d"%(p,l,m,sl,sm)); continue
        e=1; f=sl
        A=[[al,e],[f,am]]; B=[[l,0],[0,m]]; I=[[1,0],[0,1]]
        B2=mm(B,B,p); A2=mm(A,A,p)
        r1=ad(p,mm(B,A,p),mm(mm(B2,A,p),B,p)); r2=ad(p,A,mm(B2,A2,p),mm(B2,B,p))
        T=ad(p,mm(A2,A,p),mm(A2,B,p),mm(A,B,p),B)
        print("p=%d l=%d m=%d A=%s: 677 ok=%s, 255 linear ok=%s"%(p,l,m,A,r1==I and r2==[[0,0],[0,0]],T==I)); found+=1
print("candidates:",found)
