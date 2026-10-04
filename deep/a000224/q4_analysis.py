# Q4: uniform family n = p^e q (e >= 2), X = p^e, 2(p+1)A = pX + c, c = p+2 (e even) or 2p+1 (e odd).
# Claim: (E) => X | F with F = k c^2 w^2 - 2k(p+1)c w + 4(p+1)^2.  Verify the polynomial identity:
#   4(p+1)^2 (kA^2 w^2 - kAw + 1) - F = X * G  for some polynomial G  (with 2(p+1)A = pX + c)
import math, random
def direct_a(n): return len({x*x % n for x in range(n)})
def A_e(p,e):
    c = p+2 if e%2==0 else 2*p+1
    num = p*p**e + c; assert num % (2*(p+1)) == 0; return num//(2*(p+1))
for p in [3,5,7]:
    for e in range(1,7):
        if p**e < 300000: assert A_e(p,e)==direct_a(p**e), (p,e)
print("closed form a(p^e) = (p^(e+1)+c)/(2(p+1)) checked against direct count for small p^e")
ok=True
for _ in range(3000):
    p=random.choice([3,5,7,11,13]); e=random.randint(2,9); k=random.randint(0,40); w=random.randint(1,100)
    X=p**e; A=A_e(p,e); c = p+2 if e%2==0 else 2*p+1
    F=k*c*c*w*w-2*k*(p+1)*c*w+4*(p+1)**2
    lhs=4*(p+1)**2*(k*A*A*w*w-k*A*w+1)-F
    if lhs % X: ok=False
    # (E) <=> kA^2w^2 - kAw + 1 = X^2 (2w-1)^2 ; so under (E), 4(p+1)^2 X^2 (2w-1)^2 ≡ F (mod X) => X | F
print("4(p+1)^2 (kA^2w^2 - kAw + 1) ≡ F (mod X) always:", ok)
# F = k(cw-p-1)^2 + (4-k)(p+1)^2 ; F = 0 impossible for k != 4 (k(k-4) not a square), and for k=4 since cw > p+1
print("F identity:", all(k*c*c*w*w-2*k*(p+1)*c*w+4*(p+1)**2 == k*(c*w-p-1)**2+(4-k)*(p+1)**2 for k in range(0,40) for p in range(3,20) for c in (p+2,2*p+1) for w in range(1,30)))
print("k(k-4) perfect square for k in 1..100:", [k for k in range(4,101) if math.isqrt(k*(k-4))**2==k*(k-4)] if True else None)
# bounds for e >= 4: rho_e(p) = 4X^2/A^2 ; max k
def rho(p,e): X=p**e; A=A_e(p,e); return 4*X*X/(A*A)
print("max floor(rho) over e in 4..40, p odd 3..200:", max(math.floor(rho(p,e)-1e-9) for e in range(4,41) for p in range(3,200,2)))
print("p with rho_e(p) > 17 for some e in 4..40 (odd p):", [p for p in range(3,200,2) if any(rho(p,e)>17 for e in range(4,41))])
# k=16, e>=4: w < 4X^2/delta; bound in terms of p
print("k=16: max w bound (B//delta) over e in 4..30 for p=3..50:", max((lambda X,A:(4*X*X-16*A)//(4*X*X-16*A*A))(p**e,A_e(p,e)) - (p+3)//2 for e in range(4,31) for p in range(3,51,2)), "(excess over (p+3)/2)")
# e-bound from p^e <= F for k=16: F = 4(2cw-p-1)^2, w <= (p+3)/2+1
print("k=16: max e with p^e <= 4(2c w - p - 1)^2, w<=(p+5)/2, by p:", {p: max(e for e in range(2,40) if p**e <= 4*(2*(2*p+1)*((p+5)//2)-p-1)**2) for p in [3,5,7,11,13,17,19,23,29,31,37]})
# k<=15: w<=15, p | kw(w-1)+1 (e even) or kw(w-2)+4 (e odd) ; e bound from p^e <= F
Fmax=max(k*c*c*w*w+4*(p+1)**2 for k in range(1,16) for w in range(1,16) for p in range(3,3200) for c in (p+2,2*p+1))
print("k<=15: max F ~", Fmax, "=> e <= log_3 F =", math.floor(math.log(Fmax,3)))
# k>=17 (e>=4): p <= 31 (odd), w bound
wb=0
for p in range(3,32,2):
    for e in range(4,41):
        X=p**e; A=A_e(p,e)
        for k in range(17,36):
            if k*A*A>=4*X*X: continue
            wb=max(wb,(4*X*X-k*A)//(4*X*X-k*A*A))
print("k>=17, e in 4..40, p<=31: max B//delta =", wb)
# direct search of (E) for e in 4..12, p<=31 odd, all k, w<=B/delta  (should be empty)
sol=[]
for p in range(3,32,2):
    for e in range(4,13):
        X=p**e; A=A_e(p,e)
        for k in range(1,36):
            if k*A*A>=4*X*X: continue
            d=4*X*X-k*A*A; B=4*X*X-k*A
            for w in range(2,B//d+1):
                if d*w*w+(X*X-1)==B*w: sol.append((p,e,k,w))
print("(E) solutions for p<=31 odd, e in 4..12, w<=B/delta:", sol)
