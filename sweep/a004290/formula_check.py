# Cross-check: exact BFS length of a(n) vs the family formula, for n = (10^r-1)/d < LIM.
import subprocess, sys
LIM = int(sys.argv[1]); BFS = sys.argv[2]
def formula(d, r):
    # general V: len = min_t [max_{q: c_q>0} (q + r*c_q)] - p + 1 using period p | r; here use p = r directly
    B = (10**r - 1) // d; best = None
    for t in range(1, d + 1):
        s = str(t * B).zfill(r)
        val = max(q + r * int(ch) for q, ch in enumerate(reversed(s)) if ch != '0')
        best = val if best is None or val < best else best
    return best - r + 1
cases = []
for r in range(1, 8):
    M = 10**r - 1
    for d in range(1, M + 1):
        if M % d == 0 and M // d < LIM and d <= 20000:
            cases.append((M // d, d, r))
ns = sorted(set(c[0] for c in cases))
out = subprocess.run([BFS], input="\n".join(map(str, ns)), capture_output=True, text=True).stdout.split("\n")
ex = {int(l.split()[0]): len(l.split()[1]) for l in out if l.strip()}
bad = 0
for n, d, r in cases:
    f = formula(d, r)
    if f != ex[n]: bad += 1; print("MISMATCH", n, d, r, f, ex[n])
print(len(cases), "cases, mismatches:", bad)
