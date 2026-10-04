# Notes: giugacarmichael target (isStrongGiuga_implies_isCarmichael)

## Argument

Let a be strong Giuga: a composite and a ∣ 1 + S with S = ∑_{0<i<a} i^(a-1).
Write P(a) := ∀ p ∈ a.primeFactors, (p - 1 ∣ a - 1 ∧ p ∣ a/p - 1).

1. From `origin/run/giuga` (accepted by the checker): for composite a,
   IsStrongGiuga a ↔ P(a) (`strong_iff_local`), via power sums over ZMod p
   (`FiniteField.sum_pow_units`) and periodicity of S modulo each prime factor p.
2. P(a) gives Squarefree a (`squarefree_of_local`: p² ∣ a would give p ∣ a/p and p ∣ a/p - 1).
3. P(a) gives p - 1 ∣ a - 1 for every prime p ∣ a.
4. Korselt (`AgohGiuga.korselts_criterion`, proved in AgohGiuga.lean, no sorry) turns 2 and 3 into IsCarmichael a.

## Plan

Copy the lemmas of `GiugaSol` that `strong_iff_local` needs (sum_range_eq_sum_zmod, sum_pow_zmod,
sum_range_mul, cast_giuga_sum, dvd_giuga_iff, squarefree_of_local, dvd_of_squarefree, strong_iff_local)
into `Solution.lean`, drop the sum-condition half, and close the target with Korselt.
Decision: no skeleton phase beyond a single build, since every lemma is copied verbatim from an accepted proof.

## Status

`Solution.lean` proves `strong_giuga_is_carmichael` with no `sorry`; `#print axioms` gave `propext`, `Classical.choice`, `Quot.sound`.
Built in about 12 s. Submitted with a `submit(giugacarmichael):` commit.
Verdict: `comparator/giugacarmichael` = success ("Your solution is okay!") on commit f60772e, first submission.
