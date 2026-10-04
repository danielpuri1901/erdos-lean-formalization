# Notes: a112970, a(2^n) = n^2/4 + 1

## Argument

Unfolding lemmas from the definition (both hold for every k, including k = 0):
- `a_odd`:  a(2k+1) = a(k).
- `a_even`: a(2k) = a(k) + (if k < 2 then 0 else a(k-2)).

Facts:
1. `a_pow_sub_one`: a(2^m - 1) = 1. Induction: 2^(m+1) - 1 = 2(2^m - 1) + 1, so a_odd; base a(0) = 1.
2. `a_pow_sub_two`: a(2^m - 2) = (m+1)/2 for m >= 1. Two-step induction:
   m = 1: a(0) = 1; m = 2: a(2) = 1.
   m + 1 with m >= 2: 2^(m+1) - 2 = 2(2^m - 1) and 2^m - 1 >= 2, so
   a = a(2^m - 1) + a(2^m - 3) = 1 + a(2^(m-1) - 2) (since 2^m - 3 = 2(2^(m-1) - 2) + 1) = 1 + m/2 = (m+2)/2.
3. `a_pow_succ`: a(2^(n+1)) = a(2^n) + a(2^n - 2) for n >= 1 (a_even with k = 2^n >= 2).
4. Main, induction on n: n = 0: a(1) = 1. n -> n+1 with n >= 1: n^2/4 + 1 + (n+1)/2 = (n+1)^2/4 + 1,
   proved by splitting n = 2j or 2j+1 (`arith_step`). n = 0 -> 1: a(2) = 1.

Python check: all four facts hold for n < 40.

## Plan

All in `Solution.lean`, no kernel computation needed beyond tiny base cases.
