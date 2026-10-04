# wowii40 sweep notes

start: 1791105082 (date -u +%s), 2026-10-04 09:11 UTC

## Phase A: statement

Source: `FormalConjectures/WrittenOnTheWallII/GraphConjecture40.lean`, theorem `conjecture40`.
Context: `α` Fintype, DecidableEq, Nontrivial; `G : SimpleGraph α`.
Hypotheses: `G.Connected`, `1 < Fintype.card α`.
Claim: `⌈((pathCoverNumber G : ℝ) + b G + 1) / 2⌉ ≤ (G.largestInducedForestSize : ℤ)`.

Definitions as read from the Lean source (FormalConjecturesForMathlib/Combinatorics/SimpleGraph):
- `IsPathCover G P` (P : Finset (Finset α)): distinct members of P are disjoint; `univ ⊆ P.biUnion id`;
  every `s ∈ P` equals `p.support.toFinset` for some walk `p : G.Walk u v` with `p.IsPath`.
  So members are vertex sets of (not necessarily induced) paths; single vertices allowed (nil walk).
- `pathCoverNumber G = sInf {k | ∃ P, P.card = k ∧ IsPathCover G P}`. The set is nonempty
  (all singletons), so this is a true minimum. Call it p.
- `largestInducedForestSize G = sSup {n | ∃ s : Finset α, (G.induce s).IsAcyclic ∧ s.card = n}`.
  Bounded by card α and contains 0, so a true maximum. Call it f.
- `b G = (largestInducedBipartiteSubgraphSize G : ℝ)`, a max over s with `(G.induce s).IsBipartite`
  (= 2-colourable). Call it b.
- Claim: 2f ≥ p + b + 1 (ceil((p+b+1)/2) ≤ f iff p+b+1 ≤ 2f for integers).

Edge cases: n ≥ 2 and connected, so G has an edge; sInf/sSup are over nonempty bounded sets; no
subtraction or division issues (the /2 is in ℝ, then ceil). No vacuous hypotheses.

statement check: matches (Lean statement says what the docstring says).

Basic facts (proved on paper):
- f ≤ b (a forest is bipartite).
- Gallai–Milgram (from memory, unverified as a citation but standard): p ≤ α.
- f ≥ α + 1 for connected n ≥ 2 (max independent set plus one more vertex is a star + isolated).
- Define slack(G) = 2f − b − p. Claim is slack ≥ 1. Slack is additive over disjoint unions.
- Adding one vertex s: Δf ∈ {0,1}, Δb ∈ {0,1}, Δp ∈ {−1,0,1} (removing s from a path cover splits
  at most one path). So Δslack ≥ −2. A minimal counterexample G has G−s connected for a non-cut s,
  so G−s has slack 1 or 2.
- Tight families (slack = 1): trees (f=b=n, p ≤ n−1, and slack = n−p ≥ 1 is just p ≤ n−1), K_{m,n},
  K_{a,a,a}, pendant additions preserve tightness.

## Phase A.6: reproduction of the problem file's numbers

Code: `sweep/wowii40/inv.h` (f, b, p exact by subset enumeration / path-cover DP over subsets),
`sweep/wowii40/gen.c` (all graphs up to isomorphism by vertex augmentation + canonical codes).
- Graph counts n=2..9: 2, 4, 11, 34, 156, 1044, 12346, 274668 (all), connected 1, 2, 6, 21, 112, 853,
  11117, 261080; cumulative connected 2..9 = 273,192. Matches the problem file and OEIS A000088/A001349.
- 0 failures for n ≤ 9.
- "832 of 12,112 tight for n ≤ 8": I first got 120. Resolved: the problem file calls a graph tight when
  f = ceil((p+b+1)/2) exactly, i.e. slack = 2f−b−p ∈ {1, 2}. My counts: slack 1: 120, slack 2: 712,
  total 832. Reproduced.
- Slack histograms (slack 1, 2, 3, ...):
  n=8: 86 571 2863 3915 3393 288 1; n=9: 499 5599 45321 82101 93604 33058 897 1.

## Phase B: exhaustive extension search

Lemma (proved on paper): if s is any vertex, Δf, Δb ∈ {0,1} and Δp ∈ {−1,0,1} between G−s and G.
Hence slack(G−s) ≤ slack(G) + 2. Every connected graph has a non-cut vertex s (leaf of a spanning
tree), so every connected counterexample on n+1 vertices extends a connected n-vertex graph of slack ≤ 2,
and every connected n+1 graph of slack ≤ 2 extends a connected n-vertex graph of slack ≤ 4.
`ext.c` / `ext2.c`: extend each parent by a new vertex in all 2^n − 1 nonempty ways, with exact
shortcuts: Δf = 1 iff some maximum forest F of the parent stays acyclic with s (N(s) meets each
component of F at most once); Δb = 1 iff some maximum bipartite set stays bipartite (N(s) meets only
one colour class of each component). Validation: extending the n=8 slack≤4 list with T=2 reproduces
exactly the 6098 n=9 graphs of slack ≤ 2 from gen.c (`cmp` identical), for both ext and ext2.

Results:
- n=10, complete: 6098 parents (n=9, slack ≤ 2) × 511 extensions: 0 graphs with slack ≤ 0.
  So no counterexample on 10 vertices.
- n=10 slack ≤ 2 list, complete: from 133,520 n=9 parents of slack ≤ 4: 115,154 graphs
  (slack 1: 4960, slack 2: 110194).
- n=11, complete: 115,154 parents (n=10, slack ≤ 2) extended in all 1023 ways (23.7M candidates
  passed the Δf filter and were tested exactly): 0 graphs with slack ≤ 0.
  So no counterexample on 11 vertices. With the problem file's n ≤ 9 and my n ≤ 9 re-check:
  **no counterexample on ≤ 11 vertices** (computer, exhaustive up to isomorphism).
- n = 12 exhaustive was not attempted: it needs the complete slack ≤ 4 list at n = 10 (millions of
  graphs) and then about 10^9 extension tests. Decision: skip, use heuristic searches instead.

## Phase C: proof attempt

Reformulation: the claim is p ≤ 2f − b − 1.

Lemmas:
- L1 p ≤ n − 1 for connected n ≥ 2 (one edge plus singletons). Proved on paper and in Lean.
- L2 b ≤ n. Proved, Lean.
- L3 f = n when G is acyclic. Proved, Lean (only f ≥ n is needed).
- L4 an independent set Z plus one vertex w induces a forest (all edges contain w; after deleting an
  edge wx, x is isolated, so every edge is a bridge). Proved, Lean.
- L5 b + 2 ≤ 2f for connected n ≥ 2: take a largest induced bipartite set, its larger colour class Z
  (b ≤ 2|Z|), a vertex w ∉ Z (an edge cannot lie inside Z), and use L4. Proved, Lean.
  Sharper on paper: 2f − b − 1 ≥ |Z| − |Z'| + 1 where Z' is the other class.
- L6 p ≤ α (Gallai–Milgram). From memory, unverified; not formalised.
- L7 f ≥ α + 1 (L4 applied to a maximum independent set). Proved on paper.
- L8 (paper, conditional on L6): the claim holds whenever b ≤ 2f − α − 1; in particular whenever
  b = f (then p ≤ α ≤ f − 1 = 2f − b − 1). So a counterexample needs b > f, indeed b − f > f − α − 1.
- L9 the general case: unknown. I found no way to turn a large induced bipartite set into a path
  cover with few paths; the examples K_{n,n}, K_{a,a,a} (slack 1) show L5 is sharp and leave no room.

Lean (Solution.lean, namespace Wowii40Sweep, builds, no sorry, axioms propext/Classical.choice/
Quot.sound only):
- `conjecture40_of_isAcyclic`: the exact conclusion of `conjecture40` under the extra hypothesis
  `G.IsAcyclic` (trees).
- `conjecture40_of_pathCoverNumber_le_one`: the exact conclusion under `pathCoverNumber G ≤ 1`
  (graphs with a Hamiltonian path).
- helpers: `edgeCover_isPathCover`, `edgeCover_card`, `pathCoverNumber_le_card_sub_one`,
  `largestInducedBipartiteSubgraphSize_le_card`, `card_le_largestInducedForestSize`, `exists_adj`,
  `induce_insert_isAcyclic`, `b_add_two_le` (b + 2 ≤ 2f).

## Phase B (continued): heuristic searches beyond n = 11 (not exhaustive)

- Simulated annealing on slack (`anneal.c`, random connected starts, edge flips keeping
  connectivity, 1200 s per run): n=12: 1,174,299 evaluations; n=13: 528,354 + 531,417; n=14: 249,748.
  Minimum slack reached: 1 in every run (slack-1 graphs visited often). No counterexample.
- Blow-ups (`blowup.c`): every connected base graph H on 2..5 vertices (30 classes), each vertex
  replaced by an independent set (or, in the mixed run, an independent set or a clique) of size w_i,
  adjacent classes completely joined. Independent-set blow-ups with n ≤ 15: 62,794 tested
  (duplicates removed only for n ≤ 11); mixed with n ≤ 12: 256,435 tested. Minimum slack 1.
- Chain through tight graphs (`ext3.c`): the complete n=10 slack-1 list (4960) extended in all 1023
  ways keeping slack ≤ 1 gives 96,949 slack-1 graphs on 11 vertices (all with slack exactly 1). This
  list is NOT all slack ≤ 2 graphs on 11 vertices (slack-2 graphs and graphs reached only through
  slack-2 parents are missing). Extending these to 12 vertices in all 2047 ways (exact test after the
  Δf filter), time-boxed: first pass ≥ 8000 parents (shuffled order) done, about 1.7M candidates
  tested; 0 graphs with slack ≤ 0. Second pass: see the report block.
