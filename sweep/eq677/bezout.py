# u(t)(t^3+t) + v(t) o(t) = 1 over Q; then w with T(u,t)-1 = w*o and H-part.
from fractions import Fraction as F
def trim(p):
    while p and p[-1]==0: p.pop()
    return p
def add(a,b): n=max(len(a),len(b)); return trim([(a[i] if i<len(a) else 0)+(b[i] if i<len(b) else 0) for i in range(n)])
def mul(a,b):
    if not a or not b: return []
    r=[F(0)]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): r[i+j]+=x*y
    return trim(r)
def sc(c,a): return trim([c*x for x in a])
def divmod_(a,b):
    a=a[:]; qq=[F(0)]*max(len(a)-len(b)+1,1)
    while len(a)>=len(b) and a:
        c=a[-1]/b[-1]; d=len(a)-len(b); qq[d]=c
        a=add(a,sc(-c,[0]*d+b))
    return trim(qq),a
o=[F(x) for x in [1,1,1,0,1,0,2,0,1]]; g=[F(0),F(1),F(0),F(1)]
# extended Euclid
r0,r1=o,g; s0,s1=[F(1)],[]; t0,t1=[],[F(1)]
while r1:
    qq,r=divmod_(r0,r1); r0,r1=r1,r; s0,s1=s1,add(s0,sc(-1,mul(qq,s1))); t0,t1=t1,add(t0,sc(-1,mul(qq,t1)))
c=r0[0]; v=sc(1/c,s0); u=sc(1/c,t0)
print("gcd const",c); print("u =",[str(x) for x in u]); print("v =",[str(x) for x in v])
print("check:",add(mul(u,g),mul(v,o)))
# T(u,t) - 1 mod o
def pw(p,n):
    r=[F(1)]
    for _ in range(n): r=mul(r,p)
    return r
t=[F(0),F(1)]
T=add(add(add(pw(u,3),mul(pw(u,2),t)),mul(u,t)),t); T=add(T,[F(-1)])
w,rem=divmod_(T,o); print("T(u,t)-1 mod o =",rem)
print("w =",[str(x) for x in w])
