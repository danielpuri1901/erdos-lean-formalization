# Depth-1 and depth-2 cocycle extensions: bases = linear Z_q models (q<=13) and their random
# nontrivial extensions (order <= 70); fibers = all commutative linear 677 solutions mod p.
import subprocess, os, itertools
def linsols(p): return [(a,b) for a in range(p) for b in range(p) if (a*b*(1+b*b)-1)%p==0 and (a+a*a*b*b+b**3)%p==0]
def write(fn,T):
    with open(fn,"w") as f: f.write("%d\n"%len(T)); [f.write(" ".join(map(str,r))+"\n") for r in T]
def run(base,p,a,b,seed,out=None):
    args=["./extc",str(p),str(a),str(b),str(seed)]+([out] if out else [])
    r=subprocess.run(args,stdin=open(base),capture_output=True,text=True,timeout=600)
    return r.stdout
P=[5,7,11,13]; os.makedirs("bases",exist_ok=True); bases=[]
for q in P:
    for (a,b) in linsols(q):
        fn="bases/Z%d_%d_%d.txt"%(q,a,b); write(fn,[[(a*x+b*y)%q for y in range(q)] for x in range(q)]); bases.append(fn)
lvl2=[]
for fn in bases:
    for p in P:
        for (a,b) in linsols(p):
            o=run(fn,p,a,b,1)
            if "COUNTEREXAMPLE" in o: print("!!!",fn,p,a,b,o)
            dim=int(o.split("cocycle_dim=")[1].split()[0])
            n=int(o.split("n=")[1].split()[0])
            if n*p<=70 and dim>n:  # likely nontrivial (coboundary dim <= n)
                out="bases/ext_%s_%d_%d_%d.txt"%(os.path.basename(fn)[:-4],p,a,b); run(fn,p,a,b,7,out); lvl2.append(out)
print("level-1 runs done; level-2 bases:",len(lvl2),flush=True)
for fn in lvl2:
    for p in P:
        for (a,b) in linsols(p):
            o=run(fn,p,a,b,3)
            print(fn,p,a,b,o.replace("\n"," | "),flush=True)
