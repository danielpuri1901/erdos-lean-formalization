# theta graphs: hubs 0,1 joined by k internally disjoint paths of length L
from check import *
import sys
for L in [3, 4, 5]:
    for k in range(2, 13 if L == 3 else 7):
        n = 2 + k*(L-1); e = []; nxt = 2
        for i in range(k):
            prev = 0
            for j in range(L-1):
                e.append((prev, nxt)); prev = nxt; nxt += 1
            e.append((prev, 1))
        A = adjsets(n, e)
        r = rad(A); l = lavg(A); p, w = path_at_least(A, n+1)
        print(f"theta(L={L},k={k}): n={n} rad={r} C4={hasC4(A)} l={l} rad+l={float(r+l):.4f} path={p} margin={float(p-r-l):.4f}", flush=True)
