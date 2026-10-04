import pickle,sys
M=int(sys.argv[1]); P=pickle.load(open(f"P_{M}.pkl","rb"))
def S(p): return "["+",".join(map(str,p['st']))+"]"
C={3:2,4:4,5:2}
def r(p):
    st=p['st'];k=p['k']
    if k>=3 and st[2] <= 2*st[0]-C.get(k,99): return st[2]+1
    return st[0]+1
for par in (0,1):
    F=[p for p in P if p['k']%2==par and r(p) not in p['G']]
    print("M",M,"rule A (a3+1 if a3<=2a1-c_k, c3=2,c4=4,c5=2):","even" if par==0 else "odd",len(F),"/",sum(p['k']%2==par for p in P),[S(p)+str(sorted(p['G'])) for p in F][:14])
