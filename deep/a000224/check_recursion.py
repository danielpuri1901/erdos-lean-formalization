# Numerical check of R3/R4 (recursion and closed forms) against the direct definition.
import sys
def direct_a(n): return len({k*k % n for k in range(n)})
primes = [p for p in range(3, 60) if all(p % d for d in range(2, int(p**0.5)+1))]
bad = 0
for p in primes:
    for k in range(0, 12):
        N = p**k
        if N > 400000: break
        a = direct_a(N)
        if k >= 2:
            ak2 = direct_a(p**(k-2))
            if 2*a != N - N//p + 2*ak2: bad += 1; print("R3 FAIL", p, k)
        if k % 2 == 1:
            if 2*(p+1)*a != p**(k+1) + 2*p + 1: bad += 1; print("R4odd FAIL", p, k, a)
        else:
            if 2*(p+1)*a != p**(k+1) + p + 2: bad += 1; print("R4even FAIL", p, k, a)
        # R5 sanity: congruence fails for k >= 2
        if k >= 2:
            M = a*(a-1)
            if (N*N) % M == 1 % M: bad += 1; print("R5 FAIL", p, k)
print("checked; failures:", bad)
