import sys
sys.setrecursionlimit(10000)
from functools import lru_cache
L,D,W=0,1,2; neg={L:W,D:D,W:L}
@lru_cache(maxsize=None)
def v(R,g):
    if not R: return D if g==0 else L
    if sum(R)<g: return L
    return max((neg[v(R-{x},x-g)] if x>=g else v(R-{x},g-x)) for x in R)
def good(starts):
    R=frozenset(x for a in starts for x in (a,a+1)); k=len(starts); g=0 if k%2==0 else 1
    assert v(R,g)==D
    return sorted(x for x in R if neg[v(R-{x},x-g)]>=D)
for st in [[7,10,12],[6,8,10],[7,9,12],[5,7,9,14],[8,10,12,14],[1,5,8]]:
    print(st, "good picks:", good(st))
