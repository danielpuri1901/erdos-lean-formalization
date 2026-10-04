import random, itertools, subprocess
from brute import rand_regular, brute_i
def count_min(n,E,k):
    adj=[set() for _ in range(n)]
    for a,b in E: adj[a].add(b); adj[b].add(a)
    c=0
    for D in itertools.combinations(range(n),k):
        Ds=set(D)
        if any(b in Ds for a in D for b in adj[a]): continue
        if all(v in Ds or adj[v]&Ds for v in range(n)): c+=1
    return c
rng=random.Random(5); cases=[]
for _ in range(60):
    r=rng.choice([2,3,4]); n=rng.choice([x for x in range(r+1,15) if x*r%2==0])
    cases.append((n,rand_regular(n,r,rng)))
inp="".join(f"{n} {len(E)} "+" ".join(f"{a} {b}" for a,b in E)+"\n" for n,E in cases)
out=subprocess.run(["./check"],input=inp,capture_output=True,text=True).stdout.split("\n")
bad=0
for (n,E),line in zip(cases,out):
    i,m,c=map(int,line.split())
    if c!=count_min(n,E,i) or i!=brute_i(n,E): bad+=1; print("MISMATCH",n,E,line)
print("count cases",len(cases),"mismatches",bad)
