# Random check of the two lemmas of the paper proof:
#  (A) b >= l(v) + d(v,y) for all v,y      (B) b >= l(v) + d(x,y) - 1 for all v,x,y
import random, sys
sys.setrecursionlimit(10000)
from small import alpha, bnum, connected
def dists(n, adj, v):
    d={v:0}; fr=[v]
    while fr:
        nf=[]
        for x in fr:
            for u in range(n):
                if adj[x]>>u&1 and u not in d: d[u]=d[x]+1; nf.append(u)
        fr=nf
    return d
random.seed(int(sys.argv[1]))
cnt=0
for it in range(int(sys.argv[2])):
    n=random.randint(2,12); p=random.choice([0.15,0.25,0.4,0.6,0.8])
    adj=[0]*n
    for i in range(n):
        for j in range(i+1,n):
            if random.random()<p: adj[i]|=1<<j; adj[j]|=1<<i
    if not connected(n,adj): continue
    cnt+=1
    b=bnum(n,adj); D=[dists(n,adj,v) for v in range(n)]
    diam=max(max(d.values()) for d in D)
    for v in range(n):
        l=alpha(adj[v],adj)
        assert b >= l+max(D[v].values()), (n,adj,v)
        assert b >= l+diam-1, (n,adj,v)
print("checked", cnt, "connected random graphs, no violation")
