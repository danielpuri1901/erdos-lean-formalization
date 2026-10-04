# Independent check of search.c's dump: exact A_n mod q0 and gcd(A_n,B_n) mod q0.
import sys
from math import gcd
q = 2305843009213693951
N = int(sys.argv[1])
rows = {}
for line in sys.stdin:
    if line[0].isdigit():
        n, am, cm = map(int, line.split()); rows[n] = (am, cm)
a, b = 1, 0
for n in range(1, N + 1):
    a, b = a - n * b, b + n * a
    if rows[n] != (a % q, gcd(a, b) % q):
        print("MISMATCH", n); sys.exit(1)
print("dump matches exact values for n <=", N)
