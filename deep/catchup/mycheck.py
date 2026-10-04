import re, sys, os
sys.setrecursionlimit(100000)
TOK=re.compile(r'Cert\.leaf|Cert\.pick|Cert\.all|CertList\.nil|CertList\.cons|\d+|\(|\)')
def parse(toks):
    pos=[0]
    def cert():
        t=toks[pos[0]]; pos[0]+=1
        if t=='(':
            c=cert(); assert toks[pos[0]]==')'; pos[0]+=1; return c
        if t=='Cert.leaf': return ('leaf',)
        if t=='Cert.pick':
            x=int(toks[pos[0]]); pos[0]+=1; return ('pick',x,cert())
        if t=='Cert.all': return ('all',clist())
        raise ValueError(t)
    def clist():
        t=toks[pos[0]]; pos[0]+=1
        if t=='(':
            c=clist(); assert toks[pos[0]]==')'; pos[0]+=1; return c
        if t=='CertList.nil': return []
        if t=='CertList.cons':
            x=int(toks[pos[0]]); pos[0]+=1; c=cert(); r=clist(); return [(x,c)]+r
        raise ValueError(t)
    c=cert(); assert pos[0]==len(toks); return c
def chkGe(l,g,c):
    if c[0]=='leaf': return l==[] and g==0
    if c[0]=='pick':
        x,sub=c[1],c[2]
        if x not in l or sum(l)<g: return False
        l2=[y for y in l if y!=x]
        return chkLe(l2,x-g,sub) if g<=x else chkGe(l2,g-x,sub)
    return False
def chkLe(l,g,c):
    if c[0]=='leaf': return l==[] or sum(l)<g
    if c[0]=='all':
        keys=[x for x,_ in c[1]]
        if not all(x in keys for x in l): return False
        for x,sub in c[1]:
            if x not in l: return False
            l2=[y for y in l if y!=x]
            ok = chkGe(l2,x-g,sub) if g<=x else chkLe(l2,g-x,sub)
            if not ok: return False
        return True
    return False
def nodes(c):
    if c[0]=='leaf': return 1
    if c[0]=='pick': return 1+nodes(c[2])
    return 1+sum(nodes(s) for _,s in c[1])
base='/home/user/erdos-lean-formalization/deep/catchup/certgen/out'
for N in [int(a) for a in sys.argv[1:]]:
    d=f'{base}/Cert{N}'
    full=list(range(1,N+1))
    ge_children={}; le_children={}
    for fn in sorted(os.listdir(d)):
        if not fn.endswith('.lean'): continue
        src=open(f'{d}/{fn}').read()
        body=src.split(':=',1)[1]
        c=parse(TOK.findall(body))
        k=int(re.search(r'(?:Ge|Le)(\d+)\.lean',fn).group(1))
        (ge_children if fn.startswith('Ge') else le_children)[k]=c
    rootGe=('pick',1,('all',sorted(ge_children.items())))
    rootLe=('all',sorted(le_children.items()))
    print(N, 'chkGe root:',chkGe(full,0,rootGe),'nodes',nodes(rootGe),'| chkLe root:',chkLe(full,0,rootLe),'nodes',nodes(rootLe))
