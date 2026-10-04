# Structured family n = (10^r - 1)/d, d coprime to 10, d | 10^p - 1 with p = ord_d(10), p | r.
# Exact formula (derived in NOTES.md): with b_t = t*(10^p - 1)/d written with p digits
# (t = 1..d), V = min_t maxdigit(b_t), Q = min over t with maxdigit = V of the highest
# position (0 = units) holding that max digit.  Then len(a(n)) = r*V + Q - p + 1.
# The conjecture at n needs a(n) < R_{9k}, k = least k with n < 10^k - 1.
import sys
P = int(sys.argv[1]); DMAX = int(sys.argv[2]); RMAX = int(sys.argv[3])
def order10(d):
    x = 10 % d; o = 1
    while x != 1 % d:
        x = x * 10 % d; o += 1
        if o > P: return None
    return o
worst = []
for d in range(3, DMAX + 1):
    if d % 2 == 0 or d % 5 == 0: continue
    p = order10(d)
    if p is None: continue
    B = (10**p - 1) // d
    V, Q = 10, 0
    for t in range(1, d + 1):
        s = str(t * B).zfill(p)          # most significant first
        v = max(s); q = p - 1 - s.index(v)
        v = int(v)
        if v < V or (v == V and q < Q): V, Q = v, q
    for r in range(p, RMAX + 1, p):
        n = (10**r - 1) // d
        L = r * V + Q - p + 1
        k = len(str(n)); k = k + 1 if n == 10**k - 1 else k
        margin = 9 * k - L
        worst.append((margin, n, d, p, r, V, Q, L, k))
worst.sort()
for w in worst[:25]:
    margin, n, d, p, r, V, Q, L, k = w
    print("margin %d  d=%d p=%d r=%d V=%d Q=%d len=%d k=%d n=%s" % (margin, d, p, r, V, Q, L, k, str(n) if n < 10**30 else str(n)[:12] + "...(%d digits)" % len(str(n))))
print("checked", len(worst), "pairs (d,r); negative margin =", sum(1 for w in worst if w[0] < 0), "; margin 0 =", sum(1 for w in worst if w[0] == 0))
