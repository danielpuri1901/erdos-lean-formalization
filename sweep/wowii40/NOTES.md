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
