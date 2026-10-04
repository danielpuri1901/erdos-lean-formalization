# Find P,Q in Q[a,b] with  target = P*g1 + Q*g2  (bounded degree), g1 = a*b + a*b^3 - 1, g2 = a + a^2 b^2 + b^3
from fractions import Fraction as F
import sys, itertools
D=int(sys.argv[1]); which=sys.argv[2] if len(sys.argv)>2 else "lin"
def pm(P,Q):
    R={}
    for (i,j),c in P.items():
        for (k,l),d in Q.items(): R[(i+k,j+l)]=R.get((i+k,j+l),0)+c*d
    return {m:c for m,c in R.items() if c}
g1={(1,1):1,(1,3):1,(0,0):-1}; g2={(1,0):1,(2,2):1,(0,3):1}
target={(3,0):1,(2,1):1,(1,1):1,(0,1):1,(0,0):-1}
mons=[(i,j) for i in range(D+1) for j in range(D+1) if i+j<=D]
unk=[('P',m) for m in mons]+[('Q',m) for m in mons]
rows={}
for idx,(nm,m) in enumerate(unk):
    g=g1 if nm=='P' else g2
    for (i,j),c in g.items():
        key=(i+m[0],j+m[1]); rows.setdefault(key,{})[idx]=rows.get(key,{}).get(idx,0)+c
keys=sorted(set(rows)|set(target))
M=[[F(rows.get(kk,{}).get(i,0)) for i in range(len(unk))]+[F(target.get(kk,0))] for kk in keys]
# gaussian elimination
n=len(unk); r=0; piv=[]
for c in range(n):
    pr=next((i for i in range(r,len(M)) if M[i][c]!=0),None)
    if pr is None: continue
    M[r],M[pr]=M[pr],M[r]; iv=1/M[r][c]; M[r]=[x*iv for x in M[r]]
    for i in range(len(M)):
        if i!=r and M[i][c]!=0:
            f=M[i][c]; M[i]=[x-f*y for x,y in zip(M[i],M[r])]
    piv.append(c); r+=1
ok=all(M[i][n]==0 for i in range(r,len(M)))
print("D=",D,"solvable:",ok)
if ok:
    sol=[F(0)]*n
    for i,c in enumerate(piv): sol[c]=M[i][n]
    P={unk[i][1]:sol[i] for i in range(n) if unk[i][0]=='P' and sol[i]}
    Q={unk[i][1]:sol[i] for i in range(n) if unk[i][0]=='Q' and sol[i]}
    print("P=",P); print("Q=",Q)
