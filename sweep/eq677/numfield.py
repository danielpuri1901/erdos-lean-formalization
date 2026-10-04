# Exact arithmetic in K = Q(l), l^3 = l + 1. Compute s_l - s_m (m = -1/l) and its norm.
from fractions import Fraction as F
def mul(x,y):
    r=[F(0)]*5
    for i in range(3):
        for j in range(3): r[i+j]+=x[i]*y[j]
    for d in (4,3):  # l^d = l^(d-2) + l^(d-3)
        c=r[d]; r[d]=0; r[d-2]+=c; r[d-3]+=c
    return r[:3]
def add(*xs): return [sum(x[i] for x in xs) for i in range(3)]
def sc(c,x): return [c*v for v in x]
def matof(x):  # multiplication-by-x matrix in basis 1,l,l^2 (columns = images)
    cols=[mul(x,e) for e in ([F(1),F(0),F(0)],[F(0),F(1),F(0)],[F(0),F(0),F(1)])]
    return [[cols[j][i] for j in range(3)] for i in range(3)]
def det3(M):
    return (M[0][0]*(M[1][1]*M[2][2]-M[1][2]*M[2][1]) - M[0][1]*(M[1][0]*M[2][2]-M[1][2]*M[2][0]) + M[0][2]*(M[1][0]*M[2][1]-M[1][1]*M[2][0]))
def norm(x): return det3(matof(x))
def inv(x):
    # solve M y = e0
    M=matof(x); A=[row[:]+[F(int(i==0))] for i,row in enumerate(M)]
    for c in range(3):
        pr=next(i for i in range(c,3) if A[i][c]!=0); A[c],A[pr]=A[pr],A[c]
        iv=1/A[c][c]; A[c]=[v*iv for v in A[c]]
        for i in range(3):
            if i!=c and A[i][c]!=0:
                f=A[i][c]; A[i]=[a-f*b for a,b in zip(A[i],A[c])]
    return [A[i][3] for i in range(3)]
one=[F(1),F(0),F(0)]; l=[F(0),F(1),F(0)]
def pw(x,n):
    r=one
    for _ in range(n): r=mul(r,x)
    return r
m=sc(-1,inv(l))
def s_of(b):
    a=inv(add(pw(b,3),b))                     # alpha = 1/(b^3+b)
    c=add(a,mul(mul(b,b),mul(a,a)),pw(b,3))   # c = a + b^2 a^2 + b^3
    return sc(-1,mul(c,inv(mul(b,b))))
sl=s_of(l); sm=s_of(m); d=add(sl,sc(-1,sm))
print("s_l =",sl,"\ns_m =",sm,"\nN(s_l)=",norm(sl),"N(s_m)=",norm(sm),"N(s_l-s_m)=",norm(d))
print("check q(m):", add(pw(m,3),sc(-1,m),sc(-1,one)))
