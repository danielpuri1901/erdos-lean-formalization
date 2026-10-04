import sys
kind=sys.argv[1]; p=int(sys.argv[2]); perms=[]
if kind=="agl":
    for a in range(1,p):
        for b in range(p): perms.append([(a*y+b)%p for y in range(p)])
    n=p
elif kind=="pgl":  # Möbius maps on P^1(F_p), point p = infinity
    n=p+1; seen=set()
    def app(M,z):
        a,b,c,d=M
        if z==p: return p if c==0 else a*pow(c,p-2,p)%p
        num=(a*z+b)%p; den=(c*z+d)%p
        return p if den==0 else num*pow(den,p-2,p)%p
    for a in range(p):
        for b in range(p):
            for c in range(p):
                for d in range(p):
                    if (a*d-b*c)%p==0: continue
                    t=tuple(app((a,b,c,d),z) for z in range(n))
                    if t not in seen: seen.add(t); perms.append(list(t))
print(n,len(perms)); [print(*q) for q in perms]
