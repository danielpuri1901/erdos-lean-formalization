# Ideal membership with bounded-degree ansatz over Q: target = sum_i C_i * gens_i
from fractions import Fraction as F
import sys
D=int(sys.argv[1])
g1={(1,1):1,(1,3):1,(0,0):-1}; g2={(1,0):1,(2,2):1,(0,3):1}
K={(1,2):1,(0,2):1,(0,1):1,(0,0):1}
tests={"K unit (target 1)":({(0,0):1},[K,g1,g2]),
       "a^2+a+1 in (K,g1,g2)":({(2,0):1,(1,0):1,(0,0):1},[K,g1,g2])}
for name,(target,gens) in tests.items():
    mons=[(i,j) for i in range(D+1) for j in range(D+1) if i+j<=D]
    unk=[(gi,m) for gi in range(len(gens)) for m in mons]
    rows={}
    for idx,(gi,m) in enumerate(unk):
        for (i,j),c in gens[gi].items():
            key=(i+m[0],j+m[1]); rows.setdefault(key,{}); rows[key][idx]=rows[key].get(idx,0)+c
    keys=sorted(set(rows)|set(target)); n=len(unk)
    M=[[F(rows.get(kk,{}).get(i,0)) for i in range(n)]+[F(target.get(kk,0))] for kk in keys]
    r=0; piv=[]
    for c in range(n):
        pr=next((i for i in range(r,len(M)) if M[i][c]!=0),None)
        if pr is None: continue
        M[r],M[pr]=M[pr],M[r]; iv=1/M[r][c]; M[r]=[x*iv for x in M[r]]
        for i in range(len(M)):
            if i!=r and M[i][c]!=0:
                f=M[i][c]; M[i]=[x-f*y for x,y in zip(M[i],M[r])]
        piv.append(c); r+=1
    ok=all(M[i][n]==0 for i in range(r,len(M)))
    print(name,"D=",D,"solvable over Q:",ok)
    if ok:
        sol=[F(0)]*n
        for i,c in enumerate(piv): sol[c]=M[i][n]
        for gi in range(len(gens)): print("  C%d="%gi,{unk[i][1]:str(sol[i]) for i in range(n) if unk[i][0]==gi and sol[i]})
