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

More search (09:23-09:26 UTC):
- `regsearch.c`: MCMC over k-regular girth>=5 graphs (edge switches keeping girth>=5; there l(v)=k),
  exact path with early stop at rad+k+1. Cubic n=12,14,16,...,30 (10k-120k states each):
  max `rad+k-path` = -1 (only Petersen n=10 reaches 0). 4-regular n=24..32: max -1.
  4-regular n=19..22 and 5-regular n=30..40: the switch chain never reached girth 5 (no data).
- `circ.c`: every connected C4-free circulant C_n(S), 5<=n<=60, |S|<=5 (548 graphs; vertex-transitive,
  so rad = ecc(0), l = l(0), DFS from vertex 0 only): no failure; tight only C5 (both S) and C6.
- `sample.c`: random C4-free graphs (random edge order, greedy add up to a random edge budget
  between n-1 and ~n^{3/2}/2), connected ones checked, ~15k per n for n in
  {10,12,14,16,18,20,24,28,32,40,48,60}: no failure (n=10 reaches score 0).

## Phase C: proof attempts (paper)

C1 (proved, Lean): any connected G, n>=2: path >= diam+1 >= rad+1. Shortest walks have no chord
(a chord v_i v_j, j>=i+2, gives a shorter walk take_i ++ chord ++ drop_j), and are paths.
=> C4 branch of the conjecture holds; conjecture <=> its C4-free case.
=> More generally the conjecture holds whenever l(G)^cC4 <= diam + 1 - rad.

C2 (paper, proved): C4-free => any two distinct vertices have <= 1 common neighbour,
G[N(v)] is a matching, l(v) = #components of G[N(v)] = deg(v) - t(v), t(v) = #triangles at v.

C3 (paper, proved): greedy induced path in C4-free G. Let L = v_1..v_k be induced, x = v_k.
N(x) is covered by the cliques S_{k-1} = N[v_{k-1}] ∩ N(x) (size <= 2) and S_i = N(v_i) ∩ N(x)
(size <= 1) for i <= k-3 (S_{k-2} = {v_{k-1}} is inside S_{k-1}). A neighbour of x outside all S_i
extends L. An independent set meets each clique once, so if l(x) >= k-1 (k>=3) or l(x) >= 2 (k=2)
L extends. Hence with λ = min_v l(v) >= 2: path >= λ + 2.
Consequence: every C4-free G with rad + l(G) <= λ + 2 satisfies the conjecture. This covers every
Moore graph of diameter 2 (rad 2, l = k = λ): C5, Petersen, Hoffman-Singleton and a hypothetical
57-regular Moore graph; more generally every C4-free graph of radius <= 2 with constant l.
Not formalized (ran out of time budget for it).

C4 (paper, proved): radius 1. If G has a C4, C1 applies. If C4-free with centre c adjacent to all:
each u != c has at most one neighbour other than c (two would give a C4 through c), and that
neighbour is adjacent to c, so l(u) = 1; l(c) <= n-1. So l(G) <= (2n-2)/n < 2.
If G is complete, every N(v) is a clique so l(G) <= 1 and path >= 2 = rad + 1.
If not complete, diam = 2 and path >= 3 > 1 + l(G). So the conjecture holds for every graph of radius 1.

C5 (paper, sketch): trees. l(T) = 2(n-1)/n < 2 and diam >= 2 rad - 1, so diam + 1 - rad >= 2 > l
when rad >= 2; rad = 1 is C4. Covered by C1's sufficient condition (Lean has the condition, not the
tree facts).

Why the general C4-free case is not done: the greedy C3 needs a pointwise lower bound on l along
the path, but the conjecture has only the average l(G). Starting the greedy at the end of a
geodesic of length >= rad keeps the first extension free, but later steps can lose up to 2
components per step (earlier geodesic vertices at distance 2), giving only path >= rad + λ/2.
Lemma list for a full proof: (i) C1 proved; (ii) C2 proved; (iii) "Σ_v (path - rad - l(v)) >= 0"
for C4-free G: unknown; no charging scheme found.
