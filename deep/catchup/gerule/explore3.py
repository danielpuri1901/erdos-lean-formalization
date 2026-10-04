import pickle,sys,collections
M=int(sys.argv[1]); P=pickle.load(open(f"P_{M}.pkl","rb"))
def S(p): return "["+",".join(map(str,p['st']))+"]"
def mk(c,ix):
    def r(p):
        st=p['st']
        if p['k']>=3 and st[ix] <= 2*st[0]-c: return st[2]+1
        return st[0]+1
    return r
res=[]
for ix in (2,):
  for c in range(-2,6):
    r=mk(c,ix)
    fe=[p for p in P if p['k']%2==0 and r(p) not in p['G']]; fo=[p for p in P if p['k']%2==1 and r(p) not in p['G']]
    print(f"rule: a3+1 if k>=3 and a3 <= 2*a1-{c}, else a1+1: even fails {len(fe)}, odd fails {len(fo)}")
    if c==2: print("  even:",[S(p)+str(sorted(p['G'])) for p in fe][:20]); print("  odd:",[S(p)+str(sorted(p['G'])) for p in fo][:20])
