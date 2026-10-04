# Independent check of the witness file written by mitm.c.
# For every m coprime to 10 below N: the witness is a positive 0/1 number divisible by m.
# Then for every n < N: n = 2^a 5^b m, so 10^max(a,b) * w(m) is a 0/1 multiple of n,
# and len(a(n)) <= max(a,b) + len(w(m)).  Report per k the max bound over [10^(k-1)-1, 10^k-1).
import sys
N = int(sys.argv[2])
W = {}
for line in open(sys.argv[1]):
    m, L, kind, s = line.split()
    m = int(m); L = int(L)
    if kind == 'H':
        mask = int(s, 16); w = 0; i = 0; x = mask
        digs = bin(mask)[2:]          # binary string of mask = decimal string of witness
        w = int(digs)                 # read as decimal: digits 0/1, positions = bits
    else:
        assert set(s) <= set('01'), m
        w = int(s); digs = s
    assert w > 0 and w % m == 0, m
    assert len(str(w)) == L, (m, L)
    W[m] = L
for m in range(1, N):
    if m % 2 and m % 5:
        assert m in W, m
best = {}
k = 1
for n in range(1, N):
    m = n; a = 0; b = 0
    while m % 2 == 0: m //= 2; a += 1
    while m % 5 == 0: m //= 5; b += 1
    U = max(a, b) + W[m]
    while n >= 10**k - 1: k += 1      # smallest k with n < 10^k - 1
    if k not in best or U > best[k][0]: best[k] = (U, n)
for k in sorted(best):
    print("k=%d: max bound %d at n=%d, need <= %d -> %s" % (k, best[k][0], best[k][1], 9*k-1, "ok" if best[k][0] <= 9*k-1 else "CHECK"))
