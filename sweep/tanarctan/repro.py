# Reproduce small values; check content formula c_n = gcd(A_n, B_n) against exact gcd;
# check A_n never divides B_n.  Usage: python3 repro.py N
from fractions import Fraction
from math import gcd
import sys

def factor(m):
    f = {}
    d = 2
    while d * d <= m:
        while m % d == 0:
            f[d] = f.get(d, 0) + 1
            m //= d
        d += 1 if d == 2 else 2
    if m > 1:
        f[m] = f.get(m, 0) + 1
    return f

N = int(sys.argv[1]) if len(sys.argv) > 1 else 300
a, b = 1, 0          # Z_0 = 1
vs = {}              # p -> [v on side k%p < p/2, v on side k%p > p/2]
odd = 0
bad = []
for n in range(1, N + 1):
    a, b = a - n * b, b + n * a
    for p, e in factor(1 + n * n).items():
        if p == 2:
            odd += 1
            continue
        s = 0 if (n % p) < p - (n % p) else 1
        vs.setdefault(p, [0, 0])[s] += e
    c = 2 ** (odd // 2)
    for p, (u, v) in vs.items():
        c *= p ** min(u, v)
    g = gcd(a, b)
    if g != c:
        print("content mismatch", n, g, c); sys.exit(1)
    if n <= 10:
        print(n, a, b, Fraction(b, a) if a else "pole")
    if a == 0 or b % a == 0:
        bad.append(n)
print("content formula ok for n <=", N)
print("n with A_n | B_n (or A_n=0):", bad)
