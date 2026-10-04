import pickle,sys
M=int(sys.argv[1]); P=pickle.load(open(f"P_{M}.pkl","rb"))
D={tuple(p['st']):p for p in P}
# k=3 table: rows a1, entries over (a2,a3): 'X' exception (a1+1 bad), '.' fine
for a1 in range(5,M):
    row=[]
    for a2 in range(a1+2,M):
        s=""
        for a3 in range(a2+2,M):
            p=D[(a1,a2,a3)]; s+="X" if a1+1 not in p['G'] else "."
        if s: row.append(f"a2={a2}:{s}")
    if row: print(f"a1={a1}: "+" ".join(row))
