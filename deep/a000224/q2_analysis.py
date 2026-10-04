# Paper-route checks for the family n = p^2 q (Q2). m = p^2, A = (p^2-p+2)/2, w = (q+1)/2.
# From Q1: delta = 4p^4 - kA^2 >= 1, B = 4p^4 - kA, (E): delta w^2 + (p^4-1) = B w, w | p^4-1.
import math
from fractions import Fraction
def A_(p): return (p*p-p+2)//2
def isprime(n):
    if n<2: return False
    i=2
    while i*i<=n:
        if n%i==0: return False
        i+=1
    return True
# Q2.1: k <= 20 for all p >= 3, i.e. 21 A^2 >= 4 p^4.
print("Q2.1 violations (k=21 possible) for 3<=p<5000:", [p for p in range(3,5000) if 21*A_(p)**2 < 4*p**4])
# Q2.2: k >= 17 => p <= 31
print("Q2.2: p<5000 with 17A^2 < 4p^4:", [p for p in range(3,5000) if 17*A_(p)**2 < 4*p**4])
print("Q2.2 finite cases (p<=31 prime, 17<=k<=20, kA^2<4p^4):")
for p in range(3,32):
    if not isprime(p): continue
    A=A_(p)
    for k in range(17,21):
        if k*A*A >= 4*p**4: continue
        d=4*p**4-k*A*A; B=4*p**4-k*A; D=B*B-4*d*(p**4-1)
        s=math.isqrt(D); sq=(s*s==D); roots=[]
        if sq:
            for sg in (-1,1):
                num=B+sg*s
                if num>0 and num%(2*d)==0: roots.append(num//(2*d))
        print(f"  p={p} k={k} delta={d} B={B} Disc={D} isqrt={s} square={sq} roots(w)={roots}")
# Q2.4: k <= 15 => delta >= p^4/4 => w <= 15; (E) mod p gives p | k w (w-1) + 1.
print("Q2.4: 4*delta_min >= p^4 for k<=15, 3<=p<3000:", all(4*(4*p**4-15*A_(p)**2) >= p**4 for p in range(3,3000)))
sols=[]
for k in range(1,16):
    for w in range(2,16):
        N=k*w*(w-1)+1
        for p in range(3,N+1):
            if N%p: continue
            A=A_(p); d=4*p**4-k*A*A; B=4*p**4-k*A
            if d<1: continue
            if d*w*w+(p**4-1)==B*w: sols.append((k,w,p))
print("Q2.4 solutions of (E) with p | kw(w-1)+1 (p prime or not):", sols)
bf=[]
for k in range(1,16):
    for w in range(2,16):
        for p in range(3,3200):
            A=A_(p); d=4*p**4-k*A*A; B=4*p**4-k*A
            if d>=1 and d*w*w+(p**4-1)==B*w: bf.append((k,w,p))
print("brute force (E) for k<=15, 2<=w<=15, 3<=p<3200:", bf)
# also check the mod-p claim itself on random triples: (E) => p | kw(w-1)+1
import random
ok=True
for _ in range(2000):
    p=random.choice([3,5,7,11,13,17,19,23]); k=random.randint(1,20); w=random.randint(2,50)
    A=A_(p); d=4*p**4-k*A*A; B=4*p**4-k*A
    lhs=(d*w*w+(p**4-1)-B*w)  # (E) says this is 0; mod p it is -(k w^2 - k w + 1)... check congruence
    if (lhs + (k*w*w-k*w+1)) % p != 0: ok=False
print("mod p identity  delta w^2 + p^4 - 1 - B w ≡ -(k w^2 - k w + 1) (mod p):", ok)
# Q2.3: k = 16. delta = 4(p-2)(2p^2-p+2), B = 4p^4 - 8p^2 + 8p - 16. Discriminant poly and squeeze.
def pmul(a,b):
    r=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): r[i+j]+=x*y
    return r
def padd(a,b):
    n=max(len(a),len(b)); return [(a[i] if i<len(a) else 0)+(b[i] if i<len(b) else 0) for i in range(n)]
def pscale(a,c): return [c*x for x in a]
def pev(a,x): return sum(c*x**i for i,c in enumerate(a))
P=[0,1]
delta=pscale(pmul([-2,1],[2,-1,2]),4)          # 4(p-2)(2p^2-p+2)
B=[-16,8,-8,0,4]                                # 4p^4 - 8p^2 + 8p - 16
D=padd(pmul(B,B), pscale(pmul(delta,[-1,0,0,0,1]),-4))
print("k=16 delta coeffs (low->high):", delta); print("k=16 B coeffs:", B); print("k=16 Disc coeffs:", D)
for p in [3,5,7,11,13,101,1009,10007,100003]:
    Dv=pev(D,p); s=math.isqrt(Dv); g=4*p**4-4*p**3
    print(f"  p={p}: isqrt(Disc)-(4p^4-4p^3)={s-g}, square={s*s==Dv}, Disc-(4p^4-4p^3-3p^2)^2={Dv-(g-3*p*p)**2}, (4p^4-4p^3-3p^2+1)^2-Disc={(g-3*p*p+1)**2-Dv}")
# direct check of k=16 (E) for w up to (p+3)/2 and p < 3000
bf16=[]
for p in range(3,3000):
    A=A_(p); d=4*p**4-16*A*A; Bv=4*p**4-16*A
    for w in range(2,(p+3)//2+2):
        if d*w*w+(p**4-1)==Bv*w: bf16.append((p,w))
print("k=16 brute force (E), p<3000, w<=(p+3)/2+1:", bf16)
