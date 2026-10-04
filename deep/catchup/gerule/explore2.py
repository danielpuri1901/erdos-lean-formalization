import pickle,sys,collections
M=int(sys.argv[1]); P=pickle.load(open(f"P_{M}.pkl","rb"))
def S(p): return "["+",".join(map(str,p['st']))+"]"
def ex(p): return p['st'][0]+1 not in p['G']
for k in (3,4,5):
    Q=[p for p in P if p['k']==k]
    best=None
    for num in range(1,4):
     for den in range(1,4):
      for d in range(-12,6):
        cond=lambda p:den*(p['st'][-1]) <= num*p['st'][0]+d*den  # a_k <= (num/den) a1 + d
        mis=sum(cond(p)!=ex(p) for p in Q)
        if best is None or mis<best[0]: best=(mis,num,den,d)
    mis,num,den,d=best
    cond=lambda p:den*(p['st'][-1]) <= num*p['st'][0]+d*den
    print(f"k={k}: best 'exception iff a_k <= {num}/{den}*a1 + {d}': mismatches {mis} of {len(Q)} (exc {sum(map(ex,Q))})")
    print("   false pos:",[S(p) for p in Q if cond(p) and not ex(p)][:12])
    print("   false neg:",[S(p) for p in Q if ex(p) and not cond(p)][:12])
# sum-based: exception iff sum of pair elements excluding lowest pair <= c * a1 ?
for k in (3,4,5):
    Q=[p for p in P if p['k']==k]
    best=None
    for c in range(1,12):
      for d in range(-20,20):
        cond=lambda p: sum(2*a+1 for a in p['st'][1:]) <= c*p['st'][0]+d
        mis=sum(cond(p)!=ex(p) for p in Q)
        if best is None or mis<best[0]: best=(mis,c,d)
    print(f"k={k}: best 'exc iff sum(other pairs) <= c*a1+d':",best)
