#!/usr/bin/env python3
"""Independent checker for emitted Catch-Up certificates.
usage: check.py N [expected_ge expected_le]
Parses out/Cert{N}/*.lean, checks each child against the position in its header,
then assembles both roots per manifest and checks them against ([1..N], 0)."""
import sys, re, os, glob
sys.setrecursionlimit(1000000)

TOK = re.compile(r'\(|\)|Cert\.leaf|Cert\.pick|Cert\.all|CertList\.nil|CertList\.cons|\d+|\S')

def tokenize(s):
    return TOK.findall(s)

class P:
    def __init__(self, toks): self.t = toks; self.i = 0
    def peek(self): return self.t[self.i] if self.i < len(self.t) else None
    def eat(self, x=None):
        tk = self.peek()
        if tk is None or (x is not None and tk != x): raise ValueError(f"expected {x} got {tk} at {self.i}")
        self.i += 1; return tk
    def nat(self):
        tk = self.eat()
        if not tk.isdigit(): raise ValueError(f"expected nat got {tk}")
        return int(tk)
    def cert(self):        # argument position: atom or parenthesised
        tk = self.peek()
        if tk == '(':
            self.eat('('); c = self.cert_app(); self.eat(')'); return c
        if tk == 'Cert.leaf': self.eat(); return ('leaf',)
        raise ValueError(f"bad Cert arg {tk} at {self.i}")
    def cert_app(self):
        tk = self.peek()
        if tk == '(':
            self.eat('('); c = self.cert_app(); self.eat(')'); return c
        if tk == 'Cert.leaf': self.eat(); return ('leaf',)
        if tk == 'Cert.pick': self.eat(); x = self.nat(); c = self.cert(); return ('pick', x, c)
        if tk == 'Cert.all': self.eat(); cs = self.clist(); return ('all', cs)
        raise ValueError(f"bad Cert {tk} at {self.i}")
    def clist(self):
        tk = self.peek()
        if tk == 'CertList.nil': self.eat(); return ('nil',)
        if tk == '(':
            self.eat('('); c = self.clist_app(); self.eat(')'); return c
        raise ValueError(f"bad CertList arg {tk}")
    def clist_app(self):
        tk = self.peek()
        if tk == 'CertList.nil': self.eat(); return ('nil',)
        if tk == 'CertList.cons':
            self.eat(); x = self.nat(); c = self.cert(); r = self.clist(); return ('cons', x, c, r)
        if tk == '(':
            self.eat('('); c = self.clist_app(); self.eat(')'); return c
        raise ValueError(f"bad CertList {tk}")

def erase(l, x):
    l = list(l)
    if x in l: l.remove(x)
    return tuple(l)

def keys(cs):
    out = []
    while cs[0] == 'cons':
        out.append(cs[1]); cs = cs[3]
    return out

def chkGe(l, g, c):
    if len(l) == 0 and c[0] == 'leaf': return g == 0
    if c[0] == 'pick':
        x, c2 = c[1], c[2]
        if not (x in l and not (sum(l) < g)): return False
        if g <= x: return chkLe(erase(l, x), x - g, c2)
        return chkGe(erase(l, x), g - x, c2)
    return False

def chkLe(l, g, c):
    if c[0] == 'leaf': return len(l) == 0 or sum(l) < g
    if c[0] == 'all':
        ks = set(keys(c[1]))
        if not all(x in ks for x in l): return False
        return chkLeList(l, g, c[1])
    return False

def chkLeList(l, g, cs):
    while True:
        if cs[0] == 'nil': return True
        x, c, r = cs[1], cs[2], cs[3]
        if not (x in l): return False
        ok = chkGe(erase(l, x), x - g, c) if g <= x else chkLe(erase(l, x), g - x, c)
        if not ok: return False
        cs = r

def count(c):   # Cert constructors only
    if c[0] == 'leaf': return 1
    if c[0] == 'pick': return 1 + count(c[2])
    n = 1; cs = c[1]
    while cs[0] == 'cons':
        n += count(cs[2]); cs = cs[3]
    return n

def parse_file(path):
    txt = open(path).read()
    hdr = {}
    body_lines = []
    for line in txt.split('\n'):
        if line.startswith('--'):
            m = re.match(r'-- definition: (\S+)', line)
            if m: hdr['name'] = m.group(1)
            m = re.match(r'-- position: l = \[([0-9, ]*)\], g = (\d+)', line)
            if m:
                hdr['l'] = tuple(int(a) for a in m.group(1).split(',') if a.strip())
                hdr['g'] = int(m.group(2))
            m = re.match(r'-- checker: (chkGe|chkLe)', line)
            if m: hdr['chk'] = m.group(1)
            m = re.match(r'-- nodes: (\d+)', line)
            if m: hdr['nodes'] = int(m.group(1))
        else:
            body_lines.append(line)
    body = '\n'.join(body_lines)
    m = re.match(r'\s*def (\S+) : Cert :=(.*)\Z', body, re.S)
    if not m: raise ValueError(f"{path}: no def")
    assert m.group(1) == hdr['name'], path
    p = P(tokenize(m.group(2)))
    c = p.cert_app()
    if p.peek() is not None: raise ValueError(f"{path}: trailing tokens {p.peek()}")
    return hdr, c

def mk_list(pairs):
    cs = ('nil',)
    for x, c in reversed(pairs): cs = ('cons', x, c, cs)
    return cs

def main():
    N = int(sys.argv[1])
    d = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out', f'Cert{N}')
    certs = {}
    nfiles = {'ge': 0, 'le': 0}; maxn = {'ge': 0, 'le': 0}
    for path in sorted(glob.glob(os.path.join(d, '*.lean'))):
        hdr, c = parse_file(path)
        f = chkGe if hdr['chk'] == 'chkGe' else chkLe
        ok = f(hdr['l'], hdr['g'], c)
        n = count(c)
        if not ok: print("FAIL", path); sys.exit(1)
        if n != hdr['nodes']: print("NODECOUNT MISMATCH", path, n, hdr['nodes']); sys.exit(1)
        side = 'ge' if os.path.basename(path).startswith('Ge') else 'le'
        nfiles[side] += 1; maxn[side] = max(maxn[side], n)
        certs[hdr['name']] = c
    man = open(os.path.join(d, 'manifest.txt')).read()
    m = re.search(r'# ge root: Cert\.pick (\d+) \(Cert\.all cs\).*?keys of cs = ([0-9 ]+)', man)
    x0 = int(m.group(1)); gek = [int(a) for a in m.group(2).split()]
    m = re.search(r'# le root: Cert\.all cs.*?keys of cs = ([0-9 ]+)', man)
    lek = [int(a) for a in m.group(1).split()]
    full = tuple(range(1, N + 1))
    rootGe = ('pick', x0, ('all', mk_list([(k, certs[f'cert{N}ge_{k}']) for k in gek])))
    rootLe = ('all', mk_list([(k, certs[f'cert{N}le_{k}']) for k in lek]))
    okge = chkGe(full, 0, rootGe); okle = chkLe(full, 0, rootLe)
    nge, nle = count(rootGe), count(rootLe)
    print(f"N={N}: child files ge={nfiles['ge']} le={nfiles['le']} all verified; "
          f"max child nodes ge={maxn['ge']} le={maxn['le']}; "
          f"rootGe chkGe([1..{N}],0)={okge} nodes={nge}; rootLe chkLe([1..{N}],0)={okle} nodes={nle}")
    if len(sys.argv) >= 4:
        eg, el = int(sys.argv[2]), int(sys.argv[3])
        print(f"  expected sizes ge={eg} le={el}: {'MATCH' if (eg, el) == (nge, nle) else 'MISMATCH'}")
    if not (okge and okle): sys.exit(1)

main()
