import itertools, sys
sys.setrecursionlimit(10000)
from functools import lru_cache
L,D,W=0,1,2; neg={L:W,D:D,W:L}
@lru_cache(maxsize=None)
def v(R,g):
    if not R: return D if g==0 else L
    if sum(R)<g: return L
    best=L
    for x in R:
        r = neg[v(R-{x},x-g)] if x>=g else v(R-{x},g-x)
        best=max(best,r)
    return best
M=14
starts=list(range(1,M))  # pair {a,a+1} with a+1<=M
def pairunions(k):
    for comb in itertools.combinations(starts,k):
        if all(comb[i+1]-comb[i]>=2 for i in range(len(comb)-1)):
            yield comb
tot=0; fail_r1=0; fail_r6=0
for k in range(1,M//2+1,2):   # k odd
    for comb in pairunions(k):
        R=frozenset(x for a in comb for x in (a,a+1))
        assert v(R,1)==D
        for a in comb:
            tot+=1
            R1=R-{a}; g=a-1            # opponent at (R1, g)
            # r1: take a+1 (>= g always since a+1 >= a-1): mover faces (R1-{a+1}, 2)
            r1 = neg[v(R1-{a+1}, 2)]   # opponent's value after reply
            if r1==L: fail_r1+=1
            # r6
            if 2 in comb and a>=4:
                # take 2 (2 < g=a-1 since a>=4), continue at gap a-3, then take a+1 >= a-3: lead 4
                r6 = neg[v(R1-{2,a+1}, 4)]
            else:
                r6 = r1
            if r6==L: fail_r6+=1
print("hard cases inside 1..%d: %d ; r1 fails %d ; r6 fails %d"%(M,tot,fail_r1,fail_r6))
# T2: even pair-unions without pair {2,3}: v(Q,2) != W ; T4: {3} ∪ odd pair-union inside {4..M}: v(.,4)==D
t2=0;t2w=0;t4=0;t4bad=0
for k in range(0,M//2+1):
    for comb in pairunions(k):
        Q=frozenset(x for a in comb for x in (a,a+1))
        if k%2==0 and 2 not in comb:
            t2+=1; t2w+= (v(Q,2)==W)
        if k%2==1 and all(a>=4 for a in comb):
            t4+=1; t4bad+= (v(Q|{3},4)!=D)
print("T2 sets %d, W %d ; T4 sets %d, not-D %d"%(t2,t2w,t4,t4bad))
