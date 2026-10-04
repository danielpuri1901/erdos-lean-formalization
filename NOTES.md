# green66: trivial bound — notes

## Argument (C = 5, X ≥ 1)

- Lemma `floor_sq`: for real r ≥ 0 there is v : ℕ with v² ≤ r and r - v² ≤ 2√r + 1.
  Take v = ⌊√r⌋₊; then v ≤ √r < v + 1, so v² ≤ r and r < (v+1)² = v² + 2v + 1 ≤ v² + 2√r + 1.
- Apply it to X to get u, put r = X - u² (so 0 ≤ r ≤ 2√X + 1), apply it to r to get v; n = u² + v².
- n ≤ X since v² ≤ r. X - n = r - v² ≤ 2√r + 1.
- Let t = X^(1/4) (rpow). t ≥ 1 and t⁴ = X, so √X ≤ t², r ≤ 2t² + 1 ≤ 3t², √r ≤ 2t (as (2t)² = 4t² ≥ r).
- Hence X - n ≤ 4t + 1 ≤ 5t = 5 X^(1/4).

## Plan

1. `floor_sq` (sorry), main theorem from it plus the rpow facts (sorry), build.
2. Fill `floor_sq`, then the rpow facts, then the main theorem.

## Status

- Proof complete, no `sorry`; builds in about 9 s. Decision: C = 5, threshold X ≥ 1.
- `#print axioms green66_trivial_bound`: propext, Classical.choice, Quot.sound.
- `type_of% @green66_trivial_bound = type_of% @Green66.green_66.variants.trivial_bound := rfl` checks.
