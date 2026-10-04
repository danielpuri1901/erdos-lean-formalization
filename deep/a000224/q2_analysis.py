# Paper-route checks for the family n = p^2 q (Q2). m = p^2, A = (p^2-p+2)/2, w = (q+1)/2.
# From Q1: delta = 4p^4 - kA^2 >= 1, B = 4p^4 - kA, (E): delta w^2 + (p^4-1) = B w, w | p^4-1.
import math, sys
from sympy import isprime, primerange, symbols, expand, Poly, factor, sqrt
def A_(p): return (p*p-p+2)//2
# Q2.1: k <= 20 for all primes p >= 3, i.e. 21 A^2 >= 4 p^4.
bad=[p for p in range(3,2000) if 21*A_(p)**2 < 4*p**4]; print("Q2.1 violations (k=21 possible):", bad)
# Q2.2: k >= 17 => p <= 31
bad=[p for p in range(3,5000) if 17*A_(p)**2 < 4*p**4]; print("Q2.2: p with 17A^2 < 4p^4:", bad)
# Q2.2 finite part: for p<=31 prime, k in 17..20 with kA^2 < 4p^4: discriminant of (E) in w
print("Q2.2 cases:")
for p in primerange(3,32):
    A=A_(p)
    for k in range(17,21):
        if k*A*A >= 4*p**4: continue
        d=4*p**4-k*A*A; B=4*p**4-k*A; D=B*B-4*d*(p**4-1)
        s=math.isqrt(D); sq=(s*s==D)
        roots=[]
        if sq:
            for sg in (-1,1):
                num=B+sg*s
                if num>0 and num%(2*d)==0: roots.append(num//(2*d))
        print(f"  p={p} k={k} delta={d} B={B} Disc={D} isqrt={s} square={sq} roots={roots}")
# Q2.4: k <= 15 => delta >= p^4/4 => w <= 15; and (E) mod p gives p | k w (w-1) + 1.
print("Q2.4 check: delta >= p^4/4 for k<=15:", all(4*(4*p**4-15*A_(p)**2) >= p**4 for p in range(3,3000)))
# verify the mod-p claim numerically on random data and list all (k,w,p) with p | kw(w-1)+1 and (E) true
sols=[]
for k in range(1,16):
    for w in range(2,16):
        N=k*w*(w-1)+1
        for p in range(3,N+1):
            if N%p: continue
            A=A_(p); d=4*p**4-k*A*A; B=4*p**4-k*A
            if d<1: continue
            if d*w*w+(p**4-1)==B*w: sols.append((k,w,p))
print("Q2.4 solutions of (E) with p | kw(w-1)+1 (any p, prime or not):", sols)
# sanity: brute force (E) for k<=15, w<=15, p<=4000: must be subset of the above
bf=[]
for k in range(1,16):
    for w in range(2,16):
        for p in range(3,4000):
            A=A_(p); d=4*p**4-k*A*A; B=4*p**4-k*A
            if d>=1 and d*w*w+(p**4-1)==B*w: bf.append((k,w,p))
print("brute force (E) k<=15,w<=15,p<4000:", bf)
# Q2.3: k = 16. Discriminant as polynomial in p; squeeze between consecutive squares.
P=symbols('p')
A=(P**2-P+2)/2
d=expand(4*P**4-16*A**2); B=expand(4*P**4-16*A); D=expand(B**2-4*d*(P**4-1))
print("k=16: delta =", factor(d)); print("       B =", B); print("       Disc =", D)
print("       Disc factored:", factor(D))
# try g = 4p^4 - 4p^3 + c2 p^2 + c1 p + c0 : find polynomial square root approx
from sympy import series
g=expand(4*P**4-4*P**3+ (symbols('c2'))*P**2 + symbols('c1')*P + symbols('c0'))
# instead: compute integer sqrt of Disc for several p and look at differences from 4p^4-4p^3
for p in [3,5,7,11,13,101,1009,10007]:
    Dv=int(D.subs(P,p)); s=math.isqrt(Dv)
    print(f"  p={p}: isqrt(Disc)={s}, 4p^4-4p^3={4*p**4-4*p**3}, diff={s-(4*p**4-4*p**3)}, exact square={s*s==Dv}")
