import pickle,sys,collections
M=int(sys.argv[1]); P=pickle.load(open(f"P_{M}.pkl","rb"))
def S(p): return "["+",".join(map(str,p['st']))+"]"
E=[p for p in P if p['st'][0]+1 not in p['G']]
print("r1 exc where a3+1 not good:", [ (S(p),sorted(p['G'])) for p in E if len(p['st'])<3 or p['st'][2]+1 not in p['G']])
# structural thresholds
for p in E[:0]: pass
def rule(p,T):
    st=p['st'];k=p['k']
    if k>=3 and st[0]>=T.get(k,99): return st[2]+1
    return st[0]+1
best=None
import itertools
for t3 in range(4,16):
  for t4 in range(4,16):
    for t5 in range(4,16):
      T={3:t3,4:t4,5:t5}
      f=sum(rule(p,T) not in p['G'] for p in P)
      if best is None or f<best[0]: best=(f,T)
print("best a1-threshold rule (a3+1 if a1>=T_k):",best)
# features of exceptions vs non-exceptions with k in 3..5
for k in (3,4,5):
    Q=[p for p in P if p['k']==k]
    ex=collections.Counter(p['st'][0] for p in Q if p['st'][0]+1 not in p['G'])
    tot=collections.Counter(p['st'][0] for p in Q)
    print("k",k,"a1: exc/tot",[(a,ex[a],tot[a]) for a in sorted(tot) if ex[a]])
