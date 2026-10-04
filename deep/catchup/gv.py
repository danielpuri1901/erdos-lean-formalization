import sys, itertools
from functools import lru_cache
sys.setrecursionlimit(10000)
L,D,W=0,1,2
neg={L:W,D:D,W:L}
@lru_cache(maxsize=None)
def v(R,g):
    # R frozenset, g gap for mover
    if not R: return D if g==0 else L
    if sum(R)<g: return L
    best=L
    for x in R:
        R2=R-{x}
        r = neg[v(R2,x-g)] if x>=g else v(R2,g-x)
        if r>best: best=r
    return best
nm={L:'L',D:'D',W:'W'}
print("sanity N=0..14:", ''.join(nm[v(frozenset(range(1,N+1)),0)] for N in range(0,15)))
print("v({2,3,4,5},2) =", nm[v(frozenset({2,3,4,5}),2)])
# equal-sum pairs: unions of k pairs {a,b} with a+b=c, inside {1..M}
M=14
bad=0;tot=0;ex=[]
for c in range(3,2*M):
    pairs=[(a,c-a) for a in range(1,M+1) if a<c-a<=M]
    for k in range(0,len(pairs)+1):
        for comb in itertools.combinations(pairs,k):
            R=frozenset(x for p in comb for x in p)
            s=sum(R)
            if s%2==0:
                tot+=1
                if v(R,0)!=D: bad+=1; ex.append((c,comb))
            else:
                # odd total: test gap-1 variant
                tot+=1
                if v(R,1)!=D: bad+=1; ex.append((c,comb,'g1'))
print("equal-sum pairs inside 1..%d: tot %d bad %d"%(M,tot,bad))
print(ex[:12])
