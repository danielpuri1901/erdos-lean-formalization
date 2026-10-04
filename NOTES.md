# Notes: giuga9 target (a strong Giuga number has at least 9 prime factors)

## Argument

Let a be strong Giuga, S = a.primeFactors.
Library (`Solution/GiugaIff.lean`, copied from `origin/run/giuga`, accepted there):
`GiugaSol.strong_iff_local`: for composite a, strong Giuga ↔ ∀ p ∈ S, (p - 1 ∣ a - 1 ∧ p ∣ a/p - 1);
`GiugaSol.local_iff_sum`: (∀ p ∈ S, p ∣ a/p - 1) ↔ ∃ n : ℕ, ∑ 1/p - 1/a = n.

1. 2 ∉ S. If 2 ∈ S then 2 ∣ a/2 - 1, so a/2 is odd; a/2 ≠ 1 since a = 2 is prime, so a/2 ≥ 3.
   q := minFac (a/2) is an odd prime factor of a, so 2 ∣ q - 1 ∣ a - 1, and 2 ∣ a: contradiction.
2. ∑_{p ∈ S} 1/p ≥ 1. From `local_iff_sum`, ∑ 1/p = n + 1/a with n : ℕ.
   S has an element p with p < a (p ∣ a and a is not prime), so ∑ 1/p ≥ 1/p > 1/a, hence n ≥ 1.
3. Any set S of at most 8 odd primes has ∑ 1/p < 1. With T = {3,5,7,11,13,17,19,23} and
   f p = 1/p - 1/29: an odd prime p ∉ T has p ≥ 29, so f p ≤ 0; f ≥ 0 on T. Then
   ∑_S 1/p = ∑_S f + |S|/29 ≤ ∑_{S ∩ T} f + 8/29 ≤ ∑_T f + 8/29 = ∑_T 1/p = 111429982/111546435 < 1.
   (The congruence condition q ≢ 1 mod p from the sketch in TASK.md is not needed: the first
   8 odd primes already have reciprocal sum below 1. Decision: use this simpler bound.)
4. 2 and 3 give |S| ≥ 9.

## Plan

- `Solution/GiugaIff.lean`: the `run/giuga` `Solution.lean` unchanged (library).
- `Solution.lean`: lemmas `two_not_mem`, `one_le_sum`, `sum_lt_one`, then the theorem.
- Skeleton with `sorry`, build, then fill.

## Status

`Solution.lean` proves `strong_giuga_nine_primes` with no `sorry`; `lake build Solution` passes with no warnings
(about 11 s for `Solution`, 10 s for `Solution.GiugaIff`).
`#print axioms strong_giuga_nine_primes` gives `propext`, `Classical.choice`, `Quot.sound`, and
`example : type_of% @AgohGiuga.agoh_giuga.variants.le_primeFactors_card_of_isStrongGiuga := strong_giuga_nine_primes` checks.
No kernel `decide` is used; the only finite check is `interval_cases p` for p < 29.
