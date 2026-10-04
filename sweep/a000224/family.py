# Structured search: n = m*q, m odd >= 3, q prime not dividing m, q unbounded.
# a(n) = A(q+1)/2 with A = a(m). Condition a(a-1)*k = n^2-1 for an integer k >= 1 is
# (4m^2 - kA^2) q^2 - 2kA(A-1) q - (kA^2 - 2kA + 4) = 0, and needs 4m^2 - kA^2 > 0.
import sys, math
M = int(sys.argv[1])
# a(m) via smallest prime factor + recursion
spf = list(range(M+1))
for i in range(2, int(M**0.5)+1):
    if spf[i] == i:
        for j in range(i*i, M+1, i):
            if spf[j] == j: spf[j] = i
def apk(p, k):
    if k == 0: return 1
    if p == 2:
        if k <= 2: return 2
        return 2**(k-3) + apk(2, k-2)
    if k == 1: return (p+1)//2
    return p**(k-1)*(p-1)//2 + apk(p, k-2)
def a(m):
    r = 1
    while m > 1:
        p = spf[m]; k = 0
        while m % p == 0: m //= p; k += 1
        r *= apk(p, k)
    return r
def isprime(q):
    if q < 2: return False
    for p in (2,3,5,7,11,13,17,19,23,29,31,37):
        if q % p == 0: return q == p
    d = q-1; s = 0
    while d % 2 == 0: d//=2; s+=1
    for b in (2,3,5,7,11,13,17,19,23,29,31,37):
        x = pow(b, d, q)
        if x in (1, q-1): continue
        for _ in range(s-1):
            x = x*x % q
            if x == q-1: break
        else: return False
    return True
def direct_a(n): return len({k*k % n for k in range(n)})
pairs = 0; roots = 0; hits = []
for m in range(3, M+1, 2):
    A = a(m)
    k = 1
    while 4*m*m - k*A*A > 0:
        c = 4*m*m - k*A*A; b = 2*k*A*(A-1); d = k*A*A - 2*k*A + 4
        disc = b*b + 4*c*d; s = math.isqrt(disc)
        pairs += 1
        if s*s == disc and (b + s) % (2*c) == 0:
            q = (b + s)//(2*c)
            roots += 1
            if q > 1 and m % q != 0 and isprime(q):
                n = m*q; aa = A*(q+1)//2
                ok = (n*n - 1) % (aa*(aa-1)) == 0
                hits.append((m, q, k, ok)); print("HIT", m, q, k, ok, flush=True)
        k += 1
print("m odd in [3,%d]: (m,k) pairs %d, integer roots %d, prime-q hits %d" % (M, pairs, roots, len(hits)))
