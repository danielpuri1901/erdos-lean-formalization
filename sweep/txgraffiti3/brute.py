# Independent brute force: i(G) and mu*(G) by exhaustive search, small n only.
import random, itertools, subprocess, sys

def rand_regular(n, r, rng):
    while True:
        pts = [v for v in range(n) for _ in range(r)]
        rng.shuffle(pts)
        E = set(); ok = True
        for k in range(0, len(pts), 2):
            a, b = pts[k], pts[k+1]
            if a == b or (min(a,b), max(a,b)) in E: ok = False; break
            E.add((min(a,b), max(a,b)))
        if ok: return sorted(E)

def brute_i(n, E):
    adj = [set() for _ in range(n)]
    for a,b in E: adj[a].add(b); adj[b].add(a)
    for k in range(n+1):
        for D in itertools.combinations(range(n), k):
            Ds = set(D)
            if any(b in Ds for a in D for b in adj[a]): continue
            if all(v in Ds or adj[v] & Ds for v in range(n)): return k

def brute_mu(n, E):
    for k in range(len(E)+1):
        for M in itertools.combinations(E, k):
            cov = set()
            ok = True
            for a,b in M:
                if a in cov or b in cov: ok = False; break
                cov.add(a); cov.add(b)
            if not ok: continue
            if all(a in cov or b in cov for a,b in E): return k

if __name__ == "__main__":
    rng = random.Random(1)
    cases = []
    for n in range(3, 13): cases.append((n, [(k, (k+1)%n) for k in range(n)]))
    for _ in range(120):
        r = rng.choice([1,2,3,4,5])
        n = rng.choice([x for x in range(r+1, 13) if (x*r) % 2 == 0])
        cases.append((n, rand_regular(n, r, rng)))
    inp = "".join(f"{n} {len(E)} " + " ".join(f"{a} {b}" for a,b in E) + "\n" for n,E in cases)
    out = subprocess.run(["./check"], input=inp, capture_output=True, text=True).stdout.split("\n")
    bad = 0
    for (n,E), line in zip(cases, out):
        ci, cm = map(int, line.split()[:2])
        bi, bm = brute_i(n,E), brute_mu(n,E)
        if (ci,cm) != (bi,bm): bad += 1; print("MISMATCH", n, E, ci, cm, bi, bm)
        if bi > bm: print("COUNTEREXAMPLE?", n, E)
    print("cases", len(cases), "mismatches", bad)
    print("cycles:", [l for l in out[:10]])
