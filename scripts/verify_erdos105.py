#!/usr/bin/env python3
"""Exact check: A not collinear, |A| = |B| + 4, disjoint, every line through two points of A meets B."""
import json, itertools, pathlib
d = json.loads((pathlib.Path(__file__).resolve().parent.parent / "data/erdos105.json").read_text())
A = [tuple(p) for p in d["A"]]; B = [tuple(p) for p in d["B"]]
def col(p, q, r): return (q[0]-p[0])*(r[1]-p[1]) - (q[1]-p[1])*(r[0]-p[0]) == 0
assert len(set(A)) == 10 and len(set(B)) == 6 and not set(A) & set(B) and len(A) == len(B) + 4
assert any(not col(A[0], A[1], r) for r in A[2:]), "A collinear"
missing = [(p, q) for p, q in itertools.combinations(A, 2) if not any(col(p, q, b) for b in B)]
assert not missing, missing
print("erdos105 witness ok: 45 lines, each meets B")
