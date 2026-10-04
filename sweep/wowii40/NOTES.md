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
