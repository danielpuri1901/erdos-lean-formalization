# Notes: giuga target (isStrongGiuga_iff)

## Argument

Let a be composite, S = ∑_{0<i<a} i^(a-1), P(a) := ∀ p ∈ a.primeFactors, p ∣ a/p - 1.
The weak Giuga lemmas in AgohGiuga.lean are `sorry`, so they are not used; Korselt (`korselts_criterion`) is proved there and is used.

1. Power sums. For k ≥ 1, ∑_{x : ZMod p} x^k = if p-1 ∣ k then -1 else 0 (`FiniteField.sum_pow_units` plus 0^k = 0).
2. Periodicity. For p ∣ a, a = p m: (S : ZMod p) = m · ∑_{x : ZMod p} x^(a-1)
   (Ioo 0 a sums like range a since 0^(a-1)=0; range (p m) splits into m blocks of length p via `Finset.sum_range_add`).
3. Local condition. For prime p ∣ a: p ∣ 1 + S ↔ (p-1 ∣ a-1 ∧ p ∣ a/p - 1).
   If p-1 ∤ a-1 then 1 + S ≡ 1. Otherwise 1 + S ≡ 1 - m.
4. P(a) → Squarefree a: p² ∣ a gives p ∣ a/p and p ∣ a/p - 1, so p ∣ 1.
5. Squarefree a and every prime factor divides N → a ∣ N (`Nat.prod_primeFactors_of_squarefree`, `Finset.prod_primes_dvd`).
6. Strong Giuga ↔ ∀ p ∈ pf, (p-1 ∣ a-1 ∧ p ∣ a/p - 1) by 3, 4, 5.
7. P(a) ↔ ∃ n : ℕ, ∑ 1/p - 1/a = n (a ≥ 2). With N = ∑ a/p - 1 (≥ 0):
   ∑ 1/p - 1/a = N/a. For prime q ∣ a and p ≠ q prime factor, q ∣ a/p.
   So q ∣ N ↔ q ∣ a/q - 1. (→) a squarefree by 4, so a ∣ N by 5. (←) N = n a, so q ∣ N.
8. Combine 6, 7 and Korselt.

## Plan

Skeleton with sorries in Solution.lean, then fill one at a time.
