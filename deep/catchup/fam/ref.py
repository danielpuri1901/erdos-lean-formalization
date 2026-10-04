import sys
from functools import lru_cache
sys.setrecursionlimit(10000)
M=10
@lru_cache(None)
def v(R,g):
    if R==0: return 'L' if g>0 else 'D'
    s=sum(x for x in range(1,M+1) if R>>(x-1)&1)
    if s<g: return 'L'
    order={'L':0,'D':1,'W':2}; neg={'L':'W','W':'L','D':'D'}
    best='L'
    for x in range(1,M+1):
        if R>>(x-1)&1:
            R2=R&~(1<<(x-1))
            r=neg[v(R2,x-g)] if x>=g else v(R2,g-x)
            if order[r]>order[best]: best=r
    return best
lines=open('dump10.txt').read().split()
bad=0
for R in range(1<<M):
    for g in range(0,M+2):
        if v(R,g)!=lines[R][g]: bad+=1
print("compared",(1<<M)*(M+2),"entries; mismatches",bad)
