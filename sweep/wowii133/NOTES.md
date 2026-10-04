# wowii133 sweep notes

start: 1791105249 (date -u +%s), 2026-10-04 09:14 UTC

## Phase A: statement

Lean: `WrittenOnTheWallII.GraphConjecture133.conjecture133`.
Context: `α` Fintype, DecidableEq, Nontrivial (so n >= 2); `G` simple, `G.Connected`.
Claim: `(G.radius.toNat : ℝ) + l G ^ cC4 ≤ (path G : ℝ)` where `cC4 = 0` if G has a (not nec. induced) 4-cycle, else 1.

Definitions read from source:
- `G.radius = ⨅ u, G.eccent u`, `eccent u = ⨆ v, G.edist u v` (ℕ∞, Mathlib `Diam.lean`).
  Connected + finite + n >= 2 => radius is finite and >= 1, so `toNat` is the honest radius.
- `l G = averageIndepNeighbors G = (∑ v, indepNum (G.induce (G.neighborSet v))) / card α` (real).
- `path G` = max card of `l.toFinset` over lists `l` with `isInducedPath G l`:
  `l.Nodup ∧ ∀ i j, G.Adj l[i] l[j] ↔ i+1=j ∨ j+1=i`. Max over a nonempty family (singletons) so >= 1.
- `hasC4 := ∃ a b c d distinct, a~b, b~c, c~d, d~a` (non-induced 4-cycle) = "two vertices with >= 2 common nbrs".

Edge cases: n>=2 forced by `Nontrivial`; connected so no isolated vertex; no division by zero
(card α >= 2); radius not ⊤; `l^0 = 1`. Nothing degenerate.

statement check: matches (docstring and Lean agree; exponent is ℕ 0/1).

Observation A1 (C4 case is trivial): any shortest path is an induced path, so path >= diam+1 >= rad+1.
So when G has a C4 the claim `rad + 1 <= path` holds for a trivial reason. All content is in the
C4-free case: `rad + l(G) <= path`.

Observation A2 (C4-free structure): if G is C4-free, any two distinct vertices have <= 1 common
neighbour, so G[N(v)] has max degree <= 1 (a matching M_v) and l(v) = deg(v) - |M_v| >= deg(v)/2.
In particular l(v) <= deg(v), and l(v) = deg(v) when v is in no triangle.

Observation A3 (greedy induced path in C4-free graphs): extend induced path v1..vk at vk by a
neighbour w not adjacent to v1..v_{k-1}. Forbidden: v_{k-1}, and for each i<=k-1 the (at most one)
common neighbour of v_i and v_k; for i=k-2 that common neighbour is v_{k-1} itself. So at most k-1
forbidden (k>=3), and the path extends while deg(vk) >= k. Hence path >= δ+1 (δ = min degree).

## Phase B: search (09:16-09:21 UTC)

Code: `check.py` (pure Python, exact, general indepNum, independent of the C code),
`families.py` (structured families), `anneal.c`/`anneal2.c` (simulated annealing over connected
C4-free graphs maximising `rad + l - path`), `exactpath.c` (exact induced-path number, DFS).

Structured families, all OK (`python3 families.py`, early-stopping DFS finds an induced path of the
needed length; witnesses re-checked by `is_induced_path`):
- cycles C3..C11; Petersen; Hoffman-Singleton (n=50, need 9);
- Erdős–Rényi polarity graphs ER_q, q in {2,3,4,5,7,8,9,11,13} (n up to 183; rad 2, l ~ 0.6q);
- incidence graphs of PG(2,q), q in {2,3,4,5,7,8,9} (rad 3, l = q+1);
- generalized Petersen GP(m,k), 5<=m<=15.
Exact path numbers (`exactpath`): Petersen 5, ER_3 8, ER_4 11, PG(2,2)-inc 7, PG(2,3)-inc 11,
Hoffman-Singleton 20 (from vertex 0, vertex-transitive; witness verified in Python), PG(2,4)-inc 20.

Tight cases seen: C3, C4 (C4 branch), C5 (2+2=4), C6 (3+2=5), Petersen (2+3=5), K2.
Double stars approach tightness from below: rad 2, l = 2(n-1)/n, path 4.

Annealing (C4-free, connected): n=10..19 (seeds n, 7n; 2-3M moves each; random-tree start and
random-maximal-C4-free start): best score `rad + l - path` = -0.1667 (n=12), always a tree near a
double star or similar. No positive score. (n=22 run still going when written.)

Margins grow quickly with density: HS needs 9, has 20; ER/PG families have long induced paths
(conic / arc constructions give ~2q induced paths in PG(2,q) incidence graphs).
