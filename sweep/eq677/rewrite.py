# Independent check of (*) and (**): elements p0(B) + p1(B) A with Laurent polys in B over Q.
# Rules (from g1, g2, B invertible): A B = B^-2 - B^-1 A ; A B^-1 = B^-2 - B A ; A A = -B^-2 A - B.
from fractions import Fraction as F
def padd(*ps):
    r={}
    for p in ps:
        for e,c in p.items(): r[e]=r.get(e,0)+c
    return {e:c for e,c in r.items() if c}
def pmul(p,q):
    r={}
    for e,c in p.items():
        for f,d in q.items(): r[e+f]=r.get(e+f,0)+c*d
    return {e:c for e,c in r.items() if c}
def psc(c,p): return {e:c*v for e,v in p.items() if c*v}
memo={0:({},{0:F(1)})}
def A_Bn(n):  # A*B^n = alpha + beta*A
    if n in memo: return memo[n]
    if n>0:
        a,b=A_Bn(n-1)  # A B^n = (a + b A) B = a B + b (B^-2 - B^-1 A)
        r=(padd(pmul(a,{1:F(1)}),pmul(b,{-2:F(1)})), psc(-1,pmul(b,{-1:F(1)})))
    else:
        a,b=A_Bn(n+1)  # A B^n = (a + b A) B^-1 = a B^-1 + b (B^-2 - B A)
        r=(padd(pmul(a,{-1:F(1)}),pmul(b,{-2:F(1)})), psc(-1,pmul(b,{1:F(1)})))
    memo[n]=r; return r
def A_times_poly(r):  # A * r(B)
    a,b={},{}
    for e,c in r.items():
        x,y=A_Bn(e); a=padd(a,psc(c,x)); b=padd(b,psc(c,y))
    return a,b
def mul(X,Y):
    p0,p1=X; r0,r1=Y
    a,b=A_times_poly(r0); c,d=A_times_poly(r1)   # A r0 = a + bA ; A r1 = c + dA
    # p1 A r1 A = p1 (c + d A) A = p1 c A + p1 d (-B^-2 A - B)
    c0=padd(pmul(p0,r0), pmul(p1,a), psc(-1,pmul(pmul(p1,d),{1:F(1)})))
    c1=padd(pmul(p0,r1), pmul(p1,b), pmul(p1,c), psc(-1,pmul(pmul(p1,d),{-2:F(1)})))
    return (c0,c1)
Aelt=({}, {0:F(1)}); Belt=({1:F(1)},{}); one=({0:F(1)},{})
AA_B=mul(mul(Aelt,Aelt),Belt); A_AB=mul(Aelt,mul(Aelt,Belt))
R1=(padd(AA_B[0],psc(-1,A_AB[0])), padd(AA_B[1],psc(-1,A_AB[1])))
def show(p): return " + ".join("%s*B^%d"%(c,e) for e,c in sorted(p.items()))
print("R1 = (A A) B - A (A B):  p0 =",show(R1[0]),"   p1 =",show(R1[1]))
q={3:F(1),1:F(-1),0:F(-1)}
cand0=psc(-1,pmul(q,{-4:F(1)})); cand1=pmul(pmul(q,{1:F(1),3:F(1)}),{-4:F(1)})
print("R1 == B^-4 q(B) (B(B^2+1) A - 1):", R1==(cand0,cand1))
R2=mul(R1,Aelt)
pure=padd(pmul(R1[1],R2[0]), psc(-1,pmul(R2[1],R1[0])))
o={8:F(1),6:F(2),4:F(1),2:F(1),1:F(1),0:F(1)}
qo=pmul(q,o)
# check pure is a Laurent-monomial multiple of q*o (times a polynomial unit?)
print("pure relation:",show(pure))
print("q*o          :",show(qo))
# also check consistency: (A A) A == A (A A)
L=mul(mul(Aelt,Aelt),Aelt); Rr=mul(Aelt,mul(Aelt,Aelt))
R3=(padd(L[0],psc(-1,Rr[0])),padd(L[1],psc(-1,Rr[1])))
print("R3 = (AA)A - A(AA): p0 =",show(R3[0]),"  p1 =",show(R3[1]))
# hand derivation check: R1' = -q + q B(B^2+1) A  (claimed = -B^4 * R1 up to sign)
Rp=(psc(-1,q), pmul(q,{1:F(1),3:F(1)}))
print("R1' == -B^4 R1 :", Rp==(psc(-1,pmul({4:F(1)},R1[0])), psc(-1,pmul({4:F(1)},R1[1]))) or Rp==(pmul({4:F(1)},R1[0]), pmul({4:F(1)},R1[1])))
E=mul(Rp,Aelt)
lm=lambda p,X:(pmul(p,X[0]),pmul(p,X[1]))
Ep=lm({1:F(1),3:F(1)},E); Rq=lm({0:F(1),1:F(1),-1:F(1)},Rp)
tot=(padd(Ep[0],Rq[0]),padd(Ep[1],Rq[1]))
print("B(B^2+1) R1'A + (1+B+B^-1) R1' : p0 =",show(tot[0])," p1 =",show(tot[1]))
print("equals -B^-1 q o ?", tot==(psc(-1,pmul({-1:F(1)},qo)),{}))
