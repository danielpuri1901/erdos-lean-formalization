import sys
def digits(n,b=3):
    if n==0: return []
    d=[]
    while n: d.append(n%b); n//=b
    return d  # little endian
def ofd(d,b=3):
    r=0
    for x in reversed(d): r=r*b+x
    return r
def rev(n,b=3): return ofd(digits(n,b)[::-1],b)
N=int(sys.argv[1]) if len(sys.argv)>1 else 60
a=103
for k in range(N):
    s=''.join(map(str,digits(a)[::-1]))
    print(k, a if k<15 else '', len(s), s)
    assert a!=rev(a)
    a=a+rev(a)
