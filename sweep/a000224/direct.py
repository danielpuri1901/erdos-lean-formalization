# Direct check: a(n) = #{k^2 mod n : 0<=k<n}, Lean form with Nat subtraction.
import sys
def a(n):
    if n == 0: return 1
    return len({k*k % n for k in range(n)})
def isprime(n):
    if n < 2: return False
    i = 2
    while i*i <= n:
        if n % i == 0: return False
        i += 1
    return True
N = int(sys.argv[1])
print([a(n) for n in range(1,16)])
bad = []
for n in range(2, N+1):
    A = a(n); m = A*max(A-1,0)
    rhs = (n*n % m == 1 % m) if m else (n*n == 1)
    lhs = isprime(n) and n != 2
    if lhs != rhs: bad.append(n)
print("mismatches up to", N, ":", bad)
