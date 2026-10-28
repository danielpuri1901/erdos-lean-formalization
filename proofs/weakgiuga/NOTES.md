# Notes: weakgiuga target (isWeakGiuga_iff_sum_primeFactors)

## Argument

Let n be composite, S = ∑_{0<i<n} i^φ(n), P(n) := ∀ p ∈ n.primeFactors, p ∣ n/p - 1.
The other weak Giuga lemma in AgohGiuga.lean (`isWeakGiuga_iff_prime_dvd`) is `sorry` there, so it is not used.
Lemmas are adapted from the checked strong Giuga proof on `origin/run/giuga`.

1. Power sums. For k ≥ 1, ∑_{x : ZMod p} x^k = if p-1 ∣ k then -1 else 0 (`FiniteField.sum_pow_units` plus 0^k = 0).
2. Periodicity. For p ∣ n, n = p m, k ≠ 0: (∑_{0<i<n} i^k : ZMod p) = m · ∑_{x : ZMod p} x^k.
3. For prime p ∣ n, p - 1 = φ(p) ∣ φ(n) (`Nat.totient_dvd_of_dvd`, `Nat.totient_prime`), and φ(n) ≠ 0 for n ≥ 1.
   So 1 + S ≡ 1 - n/p (mod p), i.e. p ∣ 1 + S ↔ p ∣ n/p - 1 (n/p ≥ 1).
4. P(n) → Squarefree n: p² ∣ n gives p ∣ n/p and p ∣ n/p - 1, so p ∣ 1.
5. Squarefree n and every prime factor divides N → n ∣ N.
6. Weak Giuga ↔ P(n) (composite n): (→) by 3; (←) by 3, 4, 5 (this is where the prime powers are handled: squarefree first).
7. P(n) ↔ ∃ m : ℕ, ∑ 1/p - 1/n = m (n ≥ 2), copied from `local_iff_sum` of the strong proof:
   with N = ∑ n/p - 1, ∑ 1/p - 1/n = N/n and q ∣ N ↔ q ∣ n/q - 1 for each prime factor q.
8. Combine 6 and 7.

## Plan

Skeleton with sorries in Solution.lean (namespace WeakGiugaSol), build, then fill one at a time.
Decision: copy the strong proof's lemmas into Solution.lean rather than import a branch file, so the target is self-contained.

## Status

In progress.
