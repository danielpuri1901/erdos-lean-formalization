# How far is n from an integer value?  Integer value <=> |A_n| / gcd(A_n,B_n) = 1.
# Prints, per range, the minimum of log10(|A_n| / gcd) and where it occurs (exact big integers).
import sys
from math import gcd, log10
N = int(sys.argv[1])
a, b = 1, 0
best = {}
def lg(x):  # log10 of a big positive int
    s = len(str(x)) if x < 10**300 else None
    if s is None:
        k = x.bit_length() - 900
        return log10(x >> k) + k * log10(2)
    return log10(x)
for n in range(1, N + 1):
    a, b = a - n * b, b + n * a
    if n >= 5:
        g = gcd(a, b)
        v = lg(abs(a) // g) if abs(a) // g > 0 else float('-inf')
        r = 5 if n < 10 else 10 ** (len(str(n)) - 1)
        if r not in best or v < best[r][0]:
            best[r] = (v, n)
for r in sorted(best):
    print(f"n in [{r}, {min(10*r, N) if r>5 else 9}]: min log10(|A_n|/c_n) = {best[r][0]:.2f} at n = {best[r][1]}")
