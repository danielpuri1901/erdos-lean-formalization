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
