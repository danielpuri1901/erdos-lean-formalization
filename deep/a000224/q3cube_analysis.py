# Route check for the family n = p^3 q (odd primes p != q). m = X = p^3, 2A = p^3 - p^2 + p + 1 (from R4a, j=1:
# 2(p+1)a(p^3) = p^4 + 2p + 1 = (p+1)(p^3 - p^2 + p + 1)), w = (q+1)/2 >= 2.
# Q1: delta = 4X^2 - kA^2 >= 1, B = 4X^2 - kA, (E): delta w^2 + (X^2 - 1) = B w, delta w < B.
import math
def A3(p): return (p**3 - p*p + p + 1)//2
def direct_a(n): return len({x*x % n for x in range(n)})
for p in [3,5,7,11,13]: assert direct_a(p**3)==A3(p), p
print("closed form a(p^3) = (p^3-p^2+p+1)/2 checked for p in 3,5,7,11,13")
# k bound: k A^2 < 4 p^6  <=>  k (p^3-p^2+p+1)^2 < 16 p^6
kmax=max(math.floor((16*p**6-1)//(2*A3(p))**2) for p in range(3,3000))
print("max k over p<3000:", kmax, " (k <= 24 ?)", all(25*(2*A3(p))**2 >= 16*p**6 for p in range(3,3000)))
print("k>=17 => p <= ?:", [p for p in range(3,3000) if 17*(2*A3(p))**2 < 16*p**6][-1])
# k <= 15: delta >= 4X^2 - 15 A^2 >= X^2/4 ?
print("4*(4X^2 - 15A^2) >= X^2 for 3<=p<3000:", all(4*(4*p**6-15*A3(p)**2) >= p**6 for p in range(3,3000)))
# mod p: (E) mod p with 2A ≡ 1 (mod p): p | k w (w-2) + 4 ; check identity
import random
ok=True
for _ in range(3000):
    p=random.choice([3,5,7,11,13,17,19]); k=random.randint(1,30); w=random.randint(1,60)
    A=A3(p); X=p**3; d=4*X*X-k*A*A; B=4*X*X-k*A
    lhs=d*w*w+(X*X-1)-B*w
    if (4*lhs + (k*w*w-2*k*w+4)) % p != 0: ok=False
print("mod-p identity 4*(delta w^2 + X^2 - 1 - B w) ≡ -(k w^2 - 2 k w + 4) (mod p):", ok)
# F1' finite: k<=15, w<=15 (w>=3 since w=2 gives p | 4), p | k w (w-2) + 4, p>=3: solutions of (E)?
sols=[]
for k in range(1,16):
    for w in range(2,16):
        N=k*w*(w-2)+4
        for p in range(3,N+1):
            if N%p: continue
            A=A3(p); X=p**3; d=4*X*X-k*A*A; B=4*X*X-k*A
            if d>=1 and d*w*w+(X*X-1)==B*w: sols.append((k,w,p))
print("F1' solutions (k<=15,w<=15,p|kw(w-2)+4):", sols, " max N:", max(k*w*(w-2)+4 for k in range(1,16) for w in range(2,16)))
bf=[(k,w,p) for k in range(1,16) for w in range(2,16) for p in range(3,2000) if (lambda A,X:(4*X*X-k*A*A)>=1 and (4*X*X-k*A*A)*w*w+(X*X-1)==(4*X*X-k*A)*w)(A3(p),p**3)]
print("brute force k<=15,w<=15,p<2000:", bf)
# k = 16: delta = 4(X-2A)(X+2A) = 4(p^2-p-1)(2p^3-p^2+p+1); Disc = B^2 - 4 delta (X^2-1); squeeze
def pmul(a,b):
    r=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): r[i+j]+=x*y
    return r
def padd(a,b):
    n=max(len(a),len(b)); return [(a[i] if i<len(a) else 0)+(b[i] if i<len(b) else 0) for i in range(n)]
def psc(a,c): return [c*x for x in a]
def pev(a,x): return sum(c*x**i for i,c in enumerate(a))
twoA=[1,1,-1,1]            # p^3 - p^2 + p + 1
X=[0,0,0,1]
X2=pmul(X,X)
delta=padd(psc(X2,4), psc(pmul(twoA,twoA),-4))     # 4X^2 - 16A^2 = 4X^2 - 4(2A)^2
B=padd(psc(X2,4), psc(twoA,-8))                    # 4X^2 - 16A = 4X^2 - 8(2A)
D=padd(pmul(B,B), psc(pmul(delta,padd(X2,[-1])),-4))
print("k=16 e=3: delta coeffs:", delta); print("   B coeffs:", B); print("   Disc coeffs (low->high):", D)
# guess g = 4p^6 - 4p^5 + c4 p^4 + ...: look at isqrt(Disc) - 4p^6 + 4p^5
for p in [3,5,7,11,13,101,1009,10007]:
    Dv=pev(D,p); s=math.isqrt(Dv)
    print(f"   p={p}: isqrt-(4p^6-4p^5)={s-(4*p**6-4*p**5)}, square={s*s==Dv}")
bf16=[(p,w) for p in range(3,1500) for w in range(2,p+4) if (lambda A,X:(4*X*X-16*A*A)*w*w+(X*X-1)==(4*X*X-16*A)*w)(A3(p),p**3)]
print("k=16 brute force p<1500, w<=p+3:", bf16)
# k >= 17 finite: p <= bound, k in 17..24, w <= B/delta
print("k>=17 cases (p<=40, k A^2 < 4X^2):")
tot=0
for p in range(3,41):
    A=A3(p); X=p**3
    for k in range(17,25):
        if k*A*A>=4*X*X: continue
        d=4*X*X-k*A*A; B=4*X*X-k*A; wb=B//d; tot+=wb
        hits=[w for w in range(2,wb+1) if d*w*w+(X*X-1)==B*w]
        print(f"   p={p} k={k} B/delta={wb} hits={hits}")
print("total w iterations:", tot)
