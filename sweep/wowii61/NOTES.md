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
