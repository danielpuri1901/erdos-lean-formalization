# Minimal strategy-certificate tree sizes (gap form) for {1..N}, gap 0.
# ge(R,g): mover secures >= D : pick one x; if x>=g then need le(R-x,x-g) else ge(R-x,g-x)
# le(R,g): mover cannot do better than D : all x; if x>=g need ge(R-x,x-g) else le(R-x,g-x)
# terminal: R empty: ge needs g==0 ; le always true. sumR<g: le true, ge false.
import sys
sys.setrecursionlimit(100000)
N=int(sys.argv[1])
FULL=(1<<N)-1
INF=float('inf')
sums=[0]*(1<<N)
for m in range(1,1<<N):
    lb=m&-m; i=lb.bit_length()
    sums[m]=sums[m^lb]+i
memo_ge={}; memo_le={}
def ge(R,g):
    key=(R,g)
    if key in memo_ge: return memo_ge[key]
    if R==0: r = 1 if g==0 else INF
    elif sums[R]<g: r=INF
    else:
        best=INF
        m=R
        while m:
            lb=m&-m; x=lb.bit_length(); m^=lb
            R2=R^lb
            c = le(R2,x-g) if x>=g else ge(R2,g-x)
            if c+1<best: best=c+1
        r=best
    memo_ge[key]=r; return r
def le(R,g):
    key=(R,g)
    if key in memo_le: return memo_le[key]
    if R==0 or sums[R]<g: r=1
    else:
        tot=1; m=R
        while m:
            lb=m&-m; x=lb.bit_length(); m^=lb
            R2=R^lb
            c = ge(R2,x-g) if x>=g else le(R2,g-x)
            if c==INF: tot=INF; break
            tot+=c
        r=tot
    memo_le[key]=r; return r
a=ge(FULL,0); b=le(FULL,0)
print("N=%d  ge-tree nodes=%s  le-tree nodes=%s  states ge=%d le=%d"%(N,a,b,len(memo_ge),len(memo_le)))
