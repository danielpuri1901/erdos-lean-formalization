import sys, collections
M=int(sys.argv[1])
P=[]
for line in open(f"pos_{M}.txt"):
    a,b=line.split("|"); t=a.split(); k=int(t[0]); g=int(t[1]); val=t[2]; st=list(map(int,t[3:]))
    gm,wm=map(int,b.split())
    G=[x for x in range(1,M+1) if gm>>(x-1)&1]; W=[x for x in range(1,M+1) if wm>>(x-1)&1]
    P.append(dict(k=k,g=g,v=val,st=st,G=set(G),W=set(W)))
out=open(f"report_{M}.txt","w")
def pr(*a):
    print(*a); print(*a,file=out)
pr(f"M={M} positions={len(P)}; value != D at right gap: {sum(p['v']!='D' for p in P)}; no good pick: {sum(len(p['G'])==0 for p in P)}")
def S(p): return "["+",".join(map(str,p['st']))+"]"
with open(f"good_{M}.txt","w") as f:
    f.write("# pairstarts k |G| G | a1 a1+1 ak ak+1 good? (1/0) | W-picks\n")
    for p in P:
        st=p['st'];G=p['G']
        f.write(f"{S(p)} {p['k']} {len(G)} {{{','.join(map(str,sorted(G)))}}} | {int(st[0] in G)} {int(st[0]+1 in G)} {int(st[-1] in G)} {int(st[-1]+1 in G)} | W{{{','.join(map(str,sorted(p['W'])))}}}\n")
for par in (0,1):
    Q=[p for p in P if p['k']%2==par]
    d=collections.Counter(len(p['G']) for p in Q)
    pr(f"k {'even' if par==0 else 'odd'}: total {len(Q)}; |G| distribution {sorted(d.items())}")
ones=[p for p in P if len(p['G'])==1]
pr(f"exactly one good pick: {len(ones)} positions; first 30 (by k, sum):")
ones.sort(key=lambda p:(sum(p['st']),p['k']))
pr("  "+"; ".join(f"{S(p)}->{min(p['G'])}" for p in ones[:30]))
def A(p,i,d):  # a_i + d, i 1-based, -1 = last; fallback None
    st=p['st']
    if i==-1: return st[-1]+d
    return st[i-1]+d if i<=len(st) else None
def test(name,rule,show=10):
    res=[]
    for par in (0,1):
        Q=[p for p in P if p['k']%2==par]; fails=[p for p in Q if rule(p) not in p['G']]
        res.append((len(fails),len(Q),fails))
    pr(f"{name}: even fails {res[0][0]}/{res[0][1]}, odd fails {res[1][0]}/{res[1][1]}")
    for par in (0,1):
        if res[par][2] and show: pr(f"   {'even' if par==0 else 'odd'} ex: "+" ".join(S(p) for p in res[par][2][:show]))
    return res
rules={}
rules['r1 a1+1']=lambda p:A(p,1,1)
rules['r2 a1']=lambda p:A(p,1,0)
rules['r3 ak+1']=lambda p:A(p,-1,1)
rules['r4 ak']=lambda p:A(p,-1,0)
rules['r5 a1+1 unless a1=2 then a2+1']=lambda p:(A(p,2,1) if p['st'][0]==2 and p['k']>=2 else A(p,1,1))
for name,r in rules.items(): test(name,r)
# r6
def has(p,a): return a in p['st']
for c,cf in [('1',lambda p:1),('4',lambda p:4),('5',lambda p:5),('6',lambda p:6),('a3+1',lambda p:A(p,3,1)),('a3',lambda p:A(p,3,0)),('ak+1',lambda p:A(p,-1,1)),('ak',lambda p:A(p,-1,0)),('2',lambda p:2),('3',lambda p:3)]:
    test(f"r6[{c}] a1+1 unless {{2,3}},{{4,5}} present then {c}",lambda p,cf=cf:(cf(p) if has(p,2) and has(p,4) else A(p,1,1)),show=5)
# r1 exceptions
pr("== r1 (a1+1) exceptions")
for par in (0,1):
    E=[p for p in P if p['k']%2==par and A(p,1,1) not in p['G']]
    pr(f" k {'even' if par==0 else 'odd'}: {len(E)} exceptions; contain {{2,3}}: {sum(has(p,2) for p in E)}; contain {{2,3}}&{{4,5}}: {sum(has(p,2) and has(p,4) for p in E)}; a1 histogram {sorted(collections.Counter(p['st'][0] for p in E).items())}; k hist {sorted(collections.Counter(p['k'] for p in E).items())}")
    E.sort(key=lambda p:(sum(p['st']),p['st']))
    with open(f"r1exc_{M}_{'even' if par==0 else 'odd'}.txt","w") as f:
        for p in E: f.write(f"{S(p)} k={p['k']} G={{{','.join(map(str,sorted(p['G'])))}}}\n")
    pr("  smallest: "+"; ".join(f"{S(p)} G={sorted(p['G'])}" for p in E[:15]))
# greedy decision list
cands={'a1':lambda p:A(p,1,0),'a1+1':lambda p:A(p,1,1),'a2':lambda p:A(p,2,0),'a2+1':lambda p:A(p,2,1),'a3':lambda p:A(p,3,0),'a3+1':lambda p:A(p,3,1),'ak':lambda p:A(p,-1,0),'ak+1':lambda p:A(p,-1,1)}
for par in ('all',0,1):
    rem=[p for p in P if par=='all' or p['k']%2==par]
    pr(f"== greedy decision list ({'all' if par=='all' else ('even' if par==0 else 'odd')}), start {len(rem)}")
    for step in range(8):
        if not rem: break
        best=max(cands,key=lambda c:sum(cands[c](p) in p['G'] for p in rem))
        cov=[p for p in rem if cands[best](p) in p['G']]
        rem=[p for p in rem if cands[best](p) not in p['G']]
        pr(f"  step {step+1}: {best} covers {len(cov)}, remaining {len(rem)}")
    if rem: pr("  unexplained: "+" ".join(S(p) for p in rem[:20]))
import pickle; pickle.dump(P,open(f"P_{M}.pkl","wb"))
