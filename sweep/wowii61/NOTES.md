```
result: partial
claim: (Lean, no sorry) For a connected graph G on a Nontrivial finite type:
  (1) α(G) + 1 ≤ f(G);  (2) diam ≥ 5 → α(G) + 2 ≤ f(G);  (3) ⌊(diam+1)/2⌋ ≤ n - α(G).
  Hence, under the hypothesis residue G ≤ indepNum G (the Favaron–Mahéo–Saclé theorem,
  from memory, unverified, NOT formalized), conjecture 61 holds when diam ≤ 3, when
  diam ∈ {5, 6}, when G is a tree, and more generally when n - f + ⌈diam/3⌉ ≤ ⌊(diam+1)/2⌋.
  On paper (not in Lean): f ≥ α + ⌈diam/4⌉, sharp; with FMS this also covers diam = 9.
  The unconditional conjecture is NOT proved or disproved.
lean: Solution.lean, namespace Wowii61Sweep, builds with no sorry, axioms only
  propext/Classical.choice/Quot.sound: card_le_largestInducedForestSize,
  induce_insert_indep_isAcyclic, indepNum_add_one_le, conjecture61_of_diam_le_three,
  walk_support_filter_length, diam_half_le_card_sub_indepNum,
  largestInducedForestSize_le_card, conjecture61_of_feedback_le, conjecture61_of_isAcyclic,
  induce_insert_two_isAcyclic, indepNum_add_two_le, conjecture61_of_diam_five_six.
  (All the conjecture61_of_* theorems take `residue G ≤ G.indepNum` as a hypothesis.)
computed: no counterexample. Exhaustive over all labeled connected graphs n ≤ 8
  (251,548,592 at n = 8, matching OEIS A001187): 0 failures. Annealing searches (edge
  toggles, banded graphs, degree-preserving swaps) n = 10..28, diam up to 13: min slack
  f - r - ⌈D/3⌉ is 0 only at diam = 4; ≥ 1 for diam 5-6 (n = 12, 16), ≥ 1 at diam 7
  (n = 20), ≥ 2 at diam ≥ 7 in the other runs. K_{2,m}-chain family (287 graphs, n ≤ 30): tight only
  for one K_{2,m} plus pendants (diam 4). The stronger f ≥ α + ⌈D/3⌉ is FALSE (C4 plus two
  pendants, n = 6; confirmed by two independent programs, C and Python). Residue lemma
  R(G) ≤ R(G - v) + 1 holds for all labeled graphs n ≤ 7.
next idea: The open cases (given FMS) are exactly diam = 4, 7, 8 and diam ≥ 10, where
  f - α can be as small as ⌈D/4⌉, so the residue itself must be shown to be < α by about
  D/12. Start with diam = 4: prove "f = α + 1 and diam ≥ 4 ⇒ residue ≤ α - 1". The tight
  graphs there (K_{2,m} plus pendants on both hubs; all tight graphs found have diam 4)
  suggest following one Havel–Hakimi step on a max-degree vertex and tracking a geodesic
  through the reduced realization (Griggs–Kleitman/Triesch style realization argument).
  In Lean, the next cheap step is a Finset version of induce_insert_two_isAcyclic
  (S pairwise at distance ≥ 3) plus geodesic vertices via Walk.getVert, giving the diam = 9
  case and the general f ≥ α + ⌈diam/4⌉.
dead ends: (a) going through α: f ≥ α + ⌈D/3⌉ is false (n = 6) and f - α = ⌈D/4⌉ is attained
  by K_{2,2}-chains, so residue ≤ α alone cannot work for diam = 4, 7, 8, ≥ 10. (b) Vertex
  deletion: R(G) ≤ R(G - S) + |S| (if L1 holds) combined with FMS still gives ≥ 4 > 3 = R on
  C4 + 2 pendants for every S. (c) Residue is not monotone under edge deletion (fails n = 5).
  (d) Unconstrained annealing drifts to dense, small-diameter graphs; force large diameter
  (band or minD) to search the interesting regime.
confidence: high because every Lean result builds with no sorry and only the standard axioms,
  and the computational claims were reproduced (n ≤ 7 counts, the α counterexample checked
  twice). The conditional results depend on the FMS theorem, which I recall but did not
  check or formalize.
```

# wowii61 sweep notes

start: 1791105131 (date -u +%s)

## Phase A: statement

Lean: `WrittenOnTheWallII.GraphConjecture61.conjecture61`
`{α} [Fintype α] [DecidableEq α] [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj] (h : G.Connected) :
  (residue G : ℝ) + ⌈(G.diam : ℝ) / 3⌉ ≤ (G.largestInducedForestSize : ℝ)`

In words: for a finite connected simple graph on n >= 2 vertices,
f(G) >= residue(G) + ceil(diam(G)/3).

Definitions as read from the Lean source:
- `residue G = residueAux (sort (≥) (multiset of degrees))`.
  `residueAux [] = 0`, `residueAux (0 :: s) = 1 + |s|`,
  `residueAux (d :: rest) = residueAux (havelHakimiStep (d :: rest))` for d > 0.
  `havelHakimiStep (d :: rest)`: split rest at d, subtract 1 (truncated ℕ) from the first d,
  append the remainder, mergeSort by (≥). If d > |rest| only |rest| entries are decremented.
  For a graphic sequence, Havel-Hakimi keeps it graphic, so the first d entries of rest are >= 1
  and truncation never fires; the list given is always graphic here.
- `largestInducedForestSize G = sSup {k | ∃ s : Finset α, (G.induce s).IsAcyclic ∧ s.card = k}`.
  Set is nonempty (s = ∅) and bounded by n, so sSup is the true max. Fine.
- `G.diam` is Mathlib `SimpleGraph.diam : ℕ` = `ediam.toNat`; for a finite connected graph it
  is the usual diameter (no ⊤ issue).
- ⌈(diam:ℝ)/3⌉ is an integer ceiling in ℝ; equals ⌈diam/3⌉ in ℕ.

Edge cases:
- Empty type: excluded by `Nontrivial α` (n >= 2). One vertex excluded.
- Connected with n >= 2 means every vertex has degree >= 1, so residue >= 1 and f >= 2.
- n = 2: K2, residue 1, diam 1, f 2: 1 + 1 <= 2, tight.
- No real/ℕ subtraction issue in the statement; ceiling of a nonnegative real.

statement check: matches (the Lean statement says what the docstring says).
No trivial truth/falsity: residue <= alpha <= f is classical (Favaron-Mahéo-Saclé 1991,
from memory, unverified), so the content is the extra ceil(diam/3).

## Phase A: reproduction (own C code `g61.c`, labeled exhaustive, no isomorphism reduction)

`./g61 exh 7`: every labeled graph on n = 2..7, connected ones checked
(labeled connected counts 1, 4, 38, 728, 26704, 1866256 match OEIS A001187).
- conjecture 61: 0 failures for n <= 7 (labeled).
- residue <= alpha held in every case (sanity check of my residue code).
- The problem file reports 0 failures for all unlabeled connected graphs n <= 9; I only re-checked
  n <= 7 exhaustively (time budget), consistent.

Finding: the stronger statement f >= alpha + ceil(diam/3) is FALSE (9240 labeled failures at n=7,
180 at n=6). Smallest example: C4 = 0-2-1-3-0 with a pendant 5 on 0 and a pendant 4 on 1
(edges 0-2 0-3 0-5 1-2 1-3 1-4). diam = 4 (5..4), alpha = 4 ({2,3,4,5}), f = 5,
residue = 3 (degrees 3,3,2,2,1,1 -> 2,1,1,1,1 -> 0,0,1,1 -> sorted 1,1,0,0 -> 0,0,0 -> 3).
So 4 + 2 = 6 > 5 but 3 + 2 = 5 <= 5 (tight for conjecture 61).
Consequence: any proof must use the residue itself, not just residue <= alpha.

## Phase B: counterexample search (all with `timeout`, code `g61.c`, `fam.py`)

slack := f - residue - ceil(diam/3); a counterexample needs slack < 0.
- `./g61 search n 3e6 seed` (annealing over edge toggles, random start, n = 10,12,14,16):
  min slack 0,0,0,2. Drifts to dense graphs with small diameter. No counterexample.
- `./g61 band n iters seed w` (edges only between i,j with |i-j| <= w, so diam >= (n-1)/w;
  annealing): (n,w) = (16,2),(18,3),(20,4),(22,3): min slack 2,2,1,2 with D = 10,7,7,10.
  Longer runs (n,w) = (24,3),(26,4),(20,2),(28,5), 900 s each: see final numbers below.
  Large-diameter graphs found have slack >= 1, typically growing with D.
- Structured family (fam.py): chains of k copies of K_{2,m} glued at cut vertices c_0..c_k,
  p pendants per inner c_i, pe pendants on c_0, c_k; k <= 8, m <= 5, p,pe <= 3, n <= 30
  (287 graphs). k = 1 (one K_{2,m} plus pendants) is TIGHT (slack 0) for every m, p, pe
  tested: an infinite-looking tight family with D = 4. For k >= 2 slack grows with k
  (min slack 1,2,3,4,6,6,7 for k = 2..8): the residue drops to about k while alpha ~ 2k,
  so residue is far below alpha in these chains. This family also shows f - alpha ~ D/4,
  so the alpha-version fails by a linear amount.
No counterexample found anywhere.

## Phase C: proof attempt

### Written argument for what is proved (diam <= 3 case, conditional on FMS)
1. If s induces a forest then |s| <= f(G) (definition of sSup, set bounded by n).
2. If I is independent and v is any vertex, then G[I ∪ {v}] has every edge incident to v,
   so it is a subgraph of the star centred at v, hence acyclic.
3. If G is connected with n >= 2 it has an edge uw; a maximum independent set I cannot contain
   both u and w, so some v ∉ I; by 2, f(G) >= |I ∪ {v}| = α(G) + 1.
4. If diam <= 3 then ceil(diam/3) <= 1, so residue <= α (Favaron–Mahéo–Saclé, from memory,
   unverified, NOT proved in Lean) gives residue + ceil(diam/3) <= α + 1 <= f.

Lemma status: 1, 2, 3 proved on paper and in Lean; 4's arithmetic proved in Lean;
residue <= α is a hypothesis (a classical theorem, but not formalized here).

Lean (`Solution.lean`, namespace `Wowii61Sweep`, builds with no sorry; axioms are only
propext, Classical.choice, Quot.sound):
- `card_le_largestInducedForestSize`
- `induce_insert_indep_isAcyclic`
- `indepNum_add_one_le` : connected, Nontrivial α → `G.indepNum + 1 ≤ G.largestInducedForestSize`
- `conjecture61_of_diam_le_three` : connected, `residue G ≤ G.indepNum`, `G.diam ≤ 3` →
  the inequality of `conjecture61`.

### Why the general case is out of reach here
- For diam >= 4 one needs f >= residue + 2, but f = α + 1 happens with diam = 4
  (K_{2,m} plus pendants on both hubs, C4 plus two pendants), so the route through α is dead:
  the residue must be shown to be strictly below α in such graphs.
- Tested candidate induction lemmas on all labeled graphs (not nec. connected) n <= 7 (`lem.c`):
  - L1: R(G) <= R(G - v) + 1 for every vertex v: 0 failures (n <= 7). Plausible, unknown.
  - R(G - v) <= R(G): fails (1,455,937 (G,v) pairs at n = 7).
  - Edge deletion: R(G) <= R(G - e) fails (557,676 at n = 7); R(G - e) <= R(G) + 1: 0 failures.
  L1 combined with FMS gives R(G) <= α(G - S) + |S| for every S, but on C4+2 pendants
  every choice of S still gives a bound >= 4 > R = 3, so L1 + FMS cannot reach the conjecture
  either; the HH process itself has to be analysed.

### Tight graphs with diam >= 4 (labeled, n <= 7, `./g61t tight 7`)
All of them have diam exactly 4 (no tight graph with diam >= 5 for n <= 7); they have
r = 3, f = 5 (n = 6, 7) or r = 4, f = 6 (n = 7), with α in {r, r + 1}.
So diam = 4, 7, 10, ... (where ceil(diam/3) jumps) are where counterexamples should be looked for.

### More computation (Phase B/C, background)
- `./g61 exh8 2 {0,1}`: every labeled graph on 8 vertices; connected count 251,548,592
  (= OEIS A001187(8)); conjecture 61: 0 failures; tight: 3,150,534 labeled, of which
  1,548,120 have diam >= 4. (Independent re-check of n = 8 beyond the problem file's Python.)
- `./g61 mix n iters seed minD` (annealing with edge toggles AND degree-preserving double-edge
  swaps, which keep the residue fixed; start from a random caterpillar with spine > minD;
  only graphs with diam >= minD accepted):
  n=18 (minD 4): min slack 0 (D = 4); n=24 (minD 4): min slack 0 (D = 4);
  n=22 (minD 7): min slack 2 (D = 7, f - r = 5); n=26 (minD 10): min slack 3 (D = 10).
  All tight graphs found have diam exactly 4.

### Paper lemma: f >= α + ceil(diam/4) (proved on paper), and what it gives
Lemma S. If I is independent and S ⊆ V \ I has pairwise distances >= 3, then I ∪ S induces a
forest. Proof: S is independent and no vertex of I is adjacent to two vertices of S (they would
be at distance <= 2), so every vertex of I has at most one neighbour in I ∪ S; the induced graph
is a disjoint union of stars centred at S-vertices plus isolated vertices.
Corollary. Take a diametral geodesic v_0..v_D and a maximum independent set I. For each block
{v_{4j}, v_{4j+1}} (4j+1 <= D) one of the two is outside I (they are adjacent); these choices
are pairwise at distance >= 3 (geodesic). So f >= α + floor((D-1)/4) + 1 = α + ceil(D/4).
Sharpness: chains of K_{2,2} with one pendant at each end (fam.py, m=2, p=0, pe=1) have
f - α = ceil(D/4) exactly (e.g. k=8: D=18, α=18, f=23).
Consequence (conditional on FMS residue <= α): conjecture 61 holds when ceil(D/4) >= ceil(D/3),
i.e. D ∈ {1,2,3,5,6,9}. Open (needs residue < α): D = 4, 7, 8 and every D >= 10.
D = 4 is exactly where all tight graphs found so far live.
Simple version for D >= 5 used in Lean (no geodesic needed): with dist(u,v) = D, pick x = u if
u ∉ I else a neighbour of u (then x ∉ I), likewise y near v; dist(x,y) >= D - 2 >= 3.
