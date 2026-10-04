```
result: partial
claim: Conjecture 133 (exact Lean statement, same `let` form) holds for every connected graph G on
  >= 2 vertices that (a) contains a 4-cycle; or (b) has l(G) <= 2; or (c) has a vertex adjacent to
  all others (radius 1); or (d) satisfies l(G)^cC4 <= diam + 1 - rad; or (e) has l(v) >= k >= 2
  for all v and rad + l(G) <= k + 2, in particular (f) has radius <= 2 and l(v) = k >= 2 for all v
  (on paper every diameter-2 Moore graph meets (f): girth 5 gives l(v) = deg v = k, radius 2;
  so C5, Petersen, Hoffman-Singleton and a 57-regular Moore graph if it exists; the Lean theorem
  takes (f) as hypotheses and does not formalize Moore graphs).
  Also proved: path >= diam+1 >= rad+1 (any connected G); path >= rad+2 (C4-free G with a vertex
  having two non-adjacent neighbours); path >= k+2 (C4-free G with l(v) >= k >= 2 for all v).
  The conjecture is reduced to C4-free graphs with l(G) > 2; that case is NOT proved.
lean: Solution.lean, namespace Wowii133Sweep, builds with no sorry (axioms: propext,
  Classical.choice, Quot.sound only): conjecture133_of_hasC4, conjecture133_of_C4free_case,
  conjecture133_of_l_le_two, conjecture133_of_dominating, conjecture133_of_le_diam,
  conjecture133_of_minl, conjecture133_of_const_l, radius_toNat_add_one_le_path,
  diam_add_one_le_path, radius_toNat_add_two_le_path, add_two_le_path_of_minl,
  indepNeighborsCard_le_of_cover, isInducedPath_support_of_length_eq_dist, isInducedPath_cons,
  geodesic_shortcut; fidelity_hasC4, fidelity_l_le_two, fidelity_reduction state their results
  with type `type_of% (conjecture133 G h)`, so the restatement is literally the imported statement.
computed: EXHAUSTIVE (exhaust.c, canonical augmentation, counts 1,2,3,8,19 for n=2..6 match an
  independent brute force): all connected C4-free graphs n=2..12 (n=9: 740, n=10: 3389,
  n=11: 18502, n=12: 120221): 0 failures; ties only K2, K3, C5, C6 and one graph at n=10, which
  is the Petersen graph (a known tie). n=13: see the Phase D note at the end.
  HEURISTIC: cycles C3..C11; Petersen; Hoffman-Singleton; ER_q polarity graphs
  q in {2,3,4,5,7,8,9,11,13}; PG(2,q) incidence graphs q in {2,3,4,5,7,8,9}; generalized Petersen
  GP(m,k) 5<=m<=15; all 548 connected C4-free circulants C_n(S), n<=60, |S|<=5; theta graphs
  L=3 k<=12, L=4,5 k<=6; random/annealed connected C4-free graphs n=10..60 (~170k samples,
  annealing n=10..24, also restricted to l>2); MCMC samples of cubic girth>=5 graphs n=12..30 and
  4-regular girth>=5 graphs n=24..32. No failure anywhere.
next idea: The open case is C4-free with l(G) > 2: show path >= rad + 3 when l(G) > 2, and in
  general path - rad >= l(G). The two Lean tools are (1) extend a geodesic of length ecc(v) by one
  vertex at a vertex with two non-adjacent neighbours, (2) the greedy prepend with the clique-cover
  count of N(head). Next: extend at BOTH ends of an eccentric geodesic (both endpoints branching
  give path >= e + 3 when e >= 4), and pay for high-l vertices with l <= 2 vertices by a charging
  argument modelled on the near-extremal families: double stars (rad 2, path 4, l -> 2), theta
  graphs theta(3,k) (two hubs joined by k paths of length 3: rad 3, path 6, l = 3k/(k+1) -> 3,
  margin 3/(k+1)), and Petersen (exact tie, l = 3). A counterexample must beat these limits;
  search "hub + C4-free gadget" constructions and run the exhaustive check at n=14.
dead ends: Pointwise greedy alone (needs min_v l(v), not the average). Extending only at the far
  end of a geodesic beyond one step (later steps can lose 2 components per step, giving only
  ~rad + l/2). Per-vertex inequality path >= rad + l(v) is false (stars). Annealing on
  rad + l - path drifts to trees; restricted to l > 2 it drifts to theta(3,k). Edge-switch chain
  never reached girth 5 for 4-regular n<=22 or 5-regular n=30..40.
confidence: high for the Lean special cases (they build, axioms checked) and for the exhaustive
  n<=12 C4-free check (cross-checked counts n<=6); medium that the conjecture is true (margins go
  to 0 along theta(3,k) and double stars, so it is sharp).
```

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


C6 (paper = Lean `radius_toNat_add_two_le_path`, `conjecture133_of_l_le_two`), 09:30-09:33 UTC:
G C4-free, v with distinct non-adjacent neighbours a, b. Let u be eccentric to v, p a shortest walk
v = p_0, ..., p_e = u, e = ecc(v) >= rad, e >= 1. Some x in {a,b} has x != p_1 and x not~ p_1
(if a = p_1 then b ~ p_1 = a, impossible; if both are adjacent to p_1, v a p_1 b is a C4).
x is not on p (x = p_0 = v impossible, x = p_1 excluded, x = p_k with k >= 2 is a chord v p_k).
x not~ p_2 (else v x p_2 p_1 is a C4; v != p_2 and x != p_2 by the geodesic property) and x not~ p_k,
k >= 3 (v x p_k is a walk of length 2 < k). So x, p_0, ..., p_e is induced: path >= e + 2 >= rad + 2.
If G is not complete, a shortest walk between two non-adjacent vertices gives such a v (its
second vertex). If G is complete, l(G) <= 1. Hence l(G) <= 2 implies the conjecture.

Near-extremal family found (09:34 UTC, `theta.py`, exact): theta(3,k), two hubs joined by k
internally disjoint paths of length 3, n = 2k+2: C4-free, rad 3, path 6, l = 3k/(k+1),
margin path - rad - l = 3/(k+1) -> 0 (k = 2 is C6, margin 0). theta(4,k), theta(5,k): large margins.
Annealing restricted to l(G) > 2 (`anneal3`, n=11..24) converged to theta(3,k)-like graphs
(best margins: n=14 0.4286, n=12 0.5) or worse; Petersen (n=10) is the only exact tie with l > 2.


## Phase D notes (09:36-09:45 UTC)

`exhaust.c`: connected C4-free graphs by adding a vertex with neighbourhood S (valid iff no vertex
of G has two neighbours in S) to connected C4-free graphs on n-1 vertices; dedup by an exact
canonical form (minimum adjacency code over permutations preserving an isomorphism-invariant
ordered partition; an imperfect invariant only costs time, never completeness). Counts 1, 2, 3, 8, 19
for n=2..6 (cross-checked against the labelled brute force `bruteforce_count.py`), then 57, 186,
740, 3389, 18502, 120221 for n=7..12. Each graph checked exactly (`n*(path-rad) >= sum_v l(v)` in integers, general
brute-force indepNum, exact DFS path): 0 failures n<=12. Run time n=12: about 5 minutes.
`exhaust13.c`: final level n=13 without dedup (every extension checked, redundantly), split over
4 processes by parent index; skips graphs with sum_v l(v) <= 2n (covered by the Lean theorem
`conjecture133_of_l_le_two`), and for the rest searches an induced path with
`rad + ceil(sum l / n)` vertices. Sanity: making the test non-strict flags exactly the Petersen
graph at n=10.

Greedy theorem formalized at 09:38-09:40 (`add_two_le_path_of_minl`, ~110 lines, compiled on the
first try once the counting lemma `indepNeighborsCard_le_of_cover` was isolated).
