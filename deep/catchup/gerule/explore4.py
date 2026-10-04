import pickle,sys,itertools
M=int(sys.argv[1]); P=pickle.load(open(f"P_{M}.pkl","rb"))
def S(p): return "["+",".join(map(str,p['st']))+"]"
def mk(C):
    def r(p):
        st=p['st'];k=p['k']
        if k>=3 and st[2] <= 2*st[0]-C.get(k,99): return st[2]+1
        return st[0]+1
    return r
best=None
for c3,c4,c5,c6 in itertools.product(range(0,6),range(0,8),range(0,6),[0,1,2,99]):
    C={3:c3,4:c4,5:c5,6:c6}; r=mk(C)
    f=sum(r(p) not in p['G'] for p in P)
    if best is None or f<best[0]: best=(f,C)
f,C=best; r=mk(C)
print("best per-k thresholds (a3+1 if a3<=2a1-c_k):",best)
for par in (0,1):
    F=[p for p in P if p['k']%2==par and r(p) not in p['G']]
    print(" ","even" if par==0 else "odd",len(F),[S(p)+str(sorted(p['G'])) for p in F])
