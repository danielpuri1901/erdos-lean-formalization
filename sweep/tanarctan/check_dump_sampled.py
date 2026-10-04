# Like check_dump.py, but compares A_n mod q0 at every n and gcd(A_n,B_n) mod q0 at sampled n.
import sys
from math import gcd
q = 2305843009213693951
N = int(sys.argv[1]); step = int(sys.argv[2])
rows = {}
for line in sys.stdin:
    if line[0].isdigit():
        n, am, cm = map(int, line.split()); rows[n] = (am, cm)
a, b = 1, 0
cnt = 0
for n in range(1, N + 1):
    a, b = a - n * b, b + n * a
    if rows[n][0] != a % q:
        print("A MISMATCH", n); sys.exit(1)
    if n % step == 0 or n == N:
        cnt += 1
        if rows[n][1] != gcd(a, b) % q:
            print("C MISMATCH", n); sys.exit(1)
print("A_n mod q matches for all n <=", N, "; content matches at", cnt, "sampled n")
