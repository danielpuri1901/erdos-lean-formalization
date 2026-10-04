# Uniform-route record: (E) for n = p^e q with X = p^e, 2(p+1)A = pX + c, searched exactly.
# Part 1: k >= 17: p odd <= 31, e in 2..40, all k with kA^2 < 4X^2, 2 <= w <= B/delta.
# Part 2: k <= 15: w <= 15, p odd prime <= 3151 dividing k w (w-1) + 1 (e even) or k w (w-2) + 4 (e odd), e in 2..23.
# Part 3: k = 16: p odd <= 2000, e in 2..8, 2 <= w <= (p+5)/2.
def A_e(p,e):
    c = p+2 if e%2==0 else 2*p+1
    num = p*p**e + c; assert num % (2*(p+1)) == 0; return num//(2*(p+1))
def E(p,e,k,w):
    X=p**e; A=A_e(p,e); d=4*X*X-k*A*A
    if d<1: return None
    B=4*X*X-k*A; return d*w*w+(X*X-1)==B*w
sol=[]; cnt=0
for p in range(3,32,2):
    for e in range(2,41):
        X=p**e; A=A_e(p,e)
        for k in range(17,40):
            if k*A*A>=4*X*X: continue
            d=4*X*X-k*A*A; B=4*X*X-k*A
            for w in range(2,B//d+1):
                cnt+=1
                if d*w*w+(X*X-1)==B*w: sol.append((p,e,k,w))
print("Part 1 (k>=17, p<=31 odd, e<=40, w<=B/delta):", cnt, "cases, solutions:", sol)
def isprime(n):
    if n<2: return False
    i=2
    while i*i<=n:
        if n%i==0: return False
        i+=1
    return True
sol=[]; cnt=0
for k in range(1,16):
    for w in range(2,16):
        for e in range(2,24):
            N = k*w*(w-1)+1 if e%2==0 else k*w*(w-2)+4
            for p in range(3,N+1,2):
                if N%p or not isprime(p): continue
                cnt+=1
                r=E(p,e,k,w)
                if r: sol.append((p,e,k,w))
print("Part 2 (k<=15, w<=15, p | N, e<=23):", cnt, "cases, solutions (expect only q = p cases):", sol)
sol=[]; cnt=0
for p in range(3,2001,2):
    for e in range(2,9):
        for w in range(2,(p+5)//2+1):
            cnt+=1
            if E(p,e,16,w): sol.append((p,e,w))
print("Part 3 (k=16, p<=2000 odd, e<=8, w<=(p+5)/2):", cnt, "cases, solutions:", sol)
