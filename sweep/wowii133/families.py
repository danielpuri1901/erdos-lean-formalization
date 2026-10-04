from check import *
import itertools, sys

def cycle(n): return n, [(i, (i+1) % n) for i in range(n)]
def petersen():
    e = [(i, (i+1) % 5) for i in range(5)] + [(5+i, 5+(i+2) % 5) for i in range(5)] + [(i, i+5) for i in range(5)]
    return 10, e
def hoffman_singleton():
    idx = lambda t, h, j: (t*25 + h*5 + j)
    e = []
    for h in range(5):
        for j in range(5):
            e.append((idx(0,h,j), idx(0,h,(j+1)%5)))
            e.append((idx(1,h,j), idx(1,h,(j+2)%5)))
    for h in range(5):
        for j in range(5):
            for i in range(5):
                e.append((idx(0,h,j), idx(1,i,(h*i+j)%5)))
    return 50, e

class GF:
    """GF(p^k) as polynomials mod an irreducible poly; elements are ints 0..q-1 (base-p digits)."""
    def __init__(self, p, k, poly):  # poly: coefficients of monic irreducible of degree k, low->high, length k
        self.p, self.k, self.q = p, k, p**k
        q = self.q
        dig = lambda x: [(x // p**i) % p for i in range(k)]
        und = lambda d: sum(c * p**i for i, c in enumerate(d))
        self.add = [[und([(a+b) % p for a, b in zip(dig(x), dig(y))]) for y in range(q)] for x in range(q)]
        def mul(x, y):
            a, b = dig(x), dig(y); r = [0]*(2*k)
            for i in range(k):
                for j in range(k): r[i+j] = (r[i+j] + a[i]*b[j]) % p
            for d in range(2*k-1, k-1, -1):
                c = r[d]
                if c:
                    r[d] = 0
                    for i in range(k): r[d-k+i] = (r[d-k+i] - c*poly[i]) % p
            return und(r[:k])
        self.mul = [[mul(x, y) for y in range(q)] for x in range(q)]

FIELDS = {2: GF(2,1,[0]), 3: GF(3,1,[0]), 4: GF(2,2,[1,1]), 5: GF(5,1,[0]), 7: GF(7,1,[0]),
          8: GF(2,3,[1,1,0]), 9: GF(3,2,[1,0]), 11: GF(11,1,[0]), 13: GF(13,1,[0])}

def proj_points(F):
    q = F.q; pts = []
    for x in range(q):
        for y in range(q): pts.append((x, y, 1))
    for x in range(q): pts.append((x, 1, 0))
    pts.append((1, 0, 0))
    return pts

def dot(F, a, b):
    s = 0
    for x, y in zip(a, b): s = F.add[s][F.mul[x][y]]
    return s

def er_polarity(q):
    F = FIELDS[q]; P = proj_points(F); n = len(P)
    e = [(i, j) for i in range(n) for j in range(i+1, n) if dot(F, P[i], P[j]) == 0]
    return n, e

def pg_incidence(q):
    F = FIELDS[q]; P = proj_points(F); n = len(P)
    e = [(i, n + j) for i in range(n) for j in range(n) if dot(F, P[i], P[j]) == 0]
    return 2*n, e

def gen_petersen(m, k):
    e = [(i, (i+1) % m) for i in range(m)] + [(m+i, m+(i+k) % m) for i in range(m)] + [(i, m+i) for i in range(m)]
    return 2*m, e

if __name__ == "__main__":
    which = sys.argv[1:]
    fams = []
    fams += [("C%d" % k, *cycle(k)) for k in range(3, 12)]
    fams += [("Petersen", *petersen()), ("HoffmanSingleton", *hoffman_singleton())]
    fams += [("ER_%d" % q, *er_polarity(q)) for q in [2, 3, 4, 5, 7, 8, 9, 11, 13]]
    fams += [("PGinc_%d" % q, *pg_incidence(q)) for q in [2, 3, 4, 5, 7, 8, 9]]
    fams += [("GP(%d,%d)" % (m, k), *gen_petersen(m, k)) for m in range(5, 16) for k in range(2, (m+1)//2) if (m, k)]
    for name, n, e in fams:
        check(name, n, e)
