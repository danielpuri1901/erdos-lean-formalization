import sys, re
def digits(n,b=3):
    d=[]
    while n: d.append(n%b); n//=b
    return d
def ofd(d,b=3):
    r=0
    for x in reversed(d): r=r*b+x
    return r
N=int(sys.argv[1])
a=103
best=0
for k in range(N):
    d=digits(a)[::-1]
    s=''.join(map(str,d))
    # max run
    m=max(len(x.group()) for x in re.finditer(r'(.)\1*',s))
    if k%100==0 or m>best:
        print(k,len(s),'maxrun',m)
        best=max(best,m)
    a=a+ofd(d[::-1][::-1][::-1]) if False else a+int(s[::-1],3)
