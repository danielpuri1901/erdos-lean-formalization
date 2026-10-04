import pickle,sys,itertools
M=int(sys.argv[1]); P=pickle.load(open(f"P_{M}.pkl","rb"))
def S(p): return "["+",".join(map(str,p['st']))+"]"
inner={'a3+1':lambda st:st[2]+1,'adj?a2+1:a3+1':lambda st:(st[1]+1 if st[1]==st[0]+2 else st[2]+1)}
for iname,inn in inner.items():
  for var in ('a3','ak'):
    def r(p,c):
        st=p['st'];k=p['k']
        if k>=3 and (st[2] if var=='a3' else st[-1]) <= 2*st[0]-c: return inn(st)
        return st[0]+1
    C={};F=[]
    for k in range(1,12):
        Q=[p for p in P if p['k']==k]
        if not Q: continue
        best=min(range(-10,30),key=lambda c:(sum(r(p,c) not in p['G'] for p in Q),-c))
        C[k]=best; F+=[p for p in Q if r(p,best) not in p['G']]
    C={k:c for k,c in C.items() if k>=3}
    print(f"M={M} inner={iname} zone: {var}<=2a1-c_k, best c={C}: fails even {sum(p['k']%2==0 for p in F)} odd {sum(p['k']%2==1 for p in F)}")
    print("   ",[S(p)+str(sorted(p['G'])) for p in F][:16])
