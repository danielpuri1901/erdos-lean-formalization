# Structured families: chains of K_{2,m} glued at cut vertices c_0..c_k, with p pendants on each c_i
# (pend_end pendants on c_0 and c_k). Prints graphs in the eval format of g61.
import sys
def chain(k,m,p,pe):
    E=[];n=0
    c=list(range(k+1)); n=k+1
    for i in range(k):
        for t in range(m):
            v=n;n+=1;E+=[(c[i],v),(c[i+1],v)]
    for i in range(k+1):
        q = pe if i in (0,k) else p
        for t in range(q):
            v=n;n+=1;E.append((c[i],v))
    return n,E
out=[]
for k in range(1,9):
  for m in range(2,6):
    for p in range(0,4):
      for pe in range(0,4):
        n,E=chain(k,m,p,pe)
        if n>30: continue
        out.append((f"chain k={k} m={m} p={p} pe={pe}",n,E))
with open('fam_labels.txt','w') as L, open('fam_in.txt','w') as F:
    for lab,n,E in out:
        L.write(lab+"\n"); F.write(f"{n} {len(E)}\n"+" ".join(f"{a} {b}" for a,b in E)+"\n")
