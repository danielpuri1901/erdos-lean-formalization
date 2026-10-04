import pickle,sys,collections
def S(p): return "["+",".join(map(str,p['st']))+"]"
def lab(p,x):
    st=p['st']; names=[]
    for i,a in enumerate(st):
        if x==a: names.append(f"a{i+1}")
        if x==a+1: names.append(f"a{i+1}+1")
    return names[0] if names else "?"
for M in (20,22):
    P=pickle.load(open(f"P_{M}.pkl","rb"))
    ones=[p for p in P if len(p['G'])==1]
    print(f"M={M} unique-good-pick label distribution:",collections.Counter((lab(p,min(p['G'])),p['k']) for p in ones).most_common())
    nc=[p for p in P if not ({p['st'][0]+1}|({p['st'][1]+1} if p['k']>=2 else set())|({p['st'][2]+1} if p['k']>=3 else set())) & p['G']]
    print(f"M={M} positions where none of a1+1,a2+1,a3+1 is good: {len(nc)}:",[S(p)+str(sorted(p['G'])) for p in nc])
    E=[p for p in P if p['st'][0]+1 not in p['G'] and (p['k']<3 or p['st'][2]+1 not in p['G'])]
    print(f"M={M} a1+1 and a3+1 both bad: {len(E)}:",[S(p)+str(sorted(p['G'])) for p in E])
