import pickle,sys
def S(p): return "["+",".join(map(str,p['st']))+"]"
for M in (20,22):
  P=pickle.load(open(f"P_{M}.pkl","rb"))
  for c in (1,2,3):
    def r(p):
        st=p['st']
        if p['k']>=3 and st[2] <= 2*st[0]-c: return st[1]+1 if st[1]==st[0]+2 else st[2]+1
        return st[0]+1
    for par in (0,1):
        Q=[p for p in P if p['k']%2==par]; F=[p for p in Q if r(p) not in p['G']]
        print(f"M={M} ruleB(c={c}) {'even' if par==0 else 'odd'}: fails {len(F)}/{len(Q)}: "+" ".join(S(p)+"G="+"{"+",".join(map(str,sorted(p['G'])))+"}" for p in F[:12]))
