# Generate small groups as permutation groups / direct products; print "name n table".
import itertools, sys
def cyclic(n): return [[(i+j)%n for j in range(n)] for i in range(n)]
def from_perms(gens):
    # closure of permutation group
    idp=tuple(range(len(gens[0]))); els=[idp]; seen={idp}; i=0
    while i<len(els):
        for g in gens:
            h=tuple(g[k] for k in els[i])  # g∘els[i]
            if h not in seen: seen.add(h); els.append(h)
        i+=1
    idx={g:k for k,g in enumerate(els)}
    return [[idx[tuple(a[b[k]] for k in range(len(a)))] for b in els] for a in els]
def prod(A,B):
    m=len(B); return [[A[i//m][j//m]*m + B[i%m][j%m] for j in range(len(A)*m)] for i in range(len(A)*m)]
def dihedral(k):
    r=tuple((i+1)%k for i in range(k)); s=tuple((-i)%k for i in range(k)); return from_perms([r,s])
G={}
for n in range(2,33): G[f"C{n}"]=cyclic(n)
for k in range(3,17): G[f"D{2*k}"]=dihedral(k)
G["Q8"]=from_perms([(1,2,3,0,5,6,7,4)[::1]]) # placeholder replaced below
# Q8 via quaternion multiplication on 8 elements
def q8():
    # elements ±1,±i,±j,±k as (sign, idx) idx 0=1,1=i,2=j,3=k
    tab={(0,0):(1,0),(0,1):(1,1),(0,2):(1,2),(0,3):(1,3),(1,0):(1,1),(2,0):(1,2),(3,0):(1,3),
         (1,1):(-1,0),(2,2):(-1,0),(3,3):(-1,0),(1,2):(1,3),(2,3):(1,1),(3,1):(1,2),(2,1):(-1,3),(3,2):(-1,1),(1,3):(-1,2)}
    els=[(s,i) for s in (1,-1) for i in range(4)]; idx={g:k for k,g in enumerate(els)}
    return [[idx[(a[0]*b[0]*tab[(a[1],b[1])][0], tab[(a[1],b[1])][1])] for b in els] for a in els]
G["Q8"]=q8()
G["A4"]=from_perms([(1,2,0,3),(1,0,3,2)])
G["S4"]=from_perms([(1,0,2,3),(1,2,3,0)])
G["A5"]=from_perms([(1,2,0,3,4),(1,2,3,4,0)])
G["C2xC2"]=prod(cyclic(2),cyclic(2)); G["C2^3"]=prod(G["C2xC2"],cyclic(2)); G["C2^4"]=prod(G["C2^3"],cyclic(2))
G["C3xC3"]=prod(cyclic(3),cyclic(3)); G["C2xC4"]=prod(cyclic(2),cyclic(4)); G["C2xC6"]=prod(cyclic(2),cyclic(6))
G["C4xC4"]=prod(cyclic(4),cyclic(4)); G["C2xC8"]=prod(cyclic(2),cyclic(8)); G["C5xC5"]=prod(cyclic(5),cyclic(5))
G["C3xC6"]=prod(cyclic(3),cyclic(6)); G["C2xC2xC4"]=prod(G["C2xC2"],cyclic(4))
G["C3xS3"]=prod(cyclic(3),dihedral(3)); G["C2xA4"]=prod(cyclic(2),G["A4"]); G["C2xQ8"]=prod(cyclic(2),G["Q8"])
G["C2xD8"]=prod(cyclic(2),dihedral(4)); G["C3xC3xC3"]=prod(G["C3xC3"],cyclic(3))
name=sys.argv[1]; T=G[name]; print(len(T)); [print(*r) for r in T]
