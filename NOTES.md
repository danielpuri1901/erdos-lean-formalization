# intcomplexity: complexity (3^n) = 3n

## Argument (checked by hand)

Key lemma `cube_le`: `Reachable m k → m^3 ≤ 3^k`, by induction on `Reachable`.
- one: `1 ≤ 3`.
- mul: `(m n)^3 = m^3 n^3 ≤ 3^a 3^b = 3^(a+b)`.
- add: `Reachable.dec` gives `m, n, a, b ≥ 1`.
  - `m, n ≥ 2`: `m + n ≤ m n`, so `(m+n)^3 ≤ (m n)^3 ≤ 3^(a+b)`.
  - `m = 1` (symmetric for `n = 1`), lemma `one_add_case`:
    - `n = 1`: `8 ≤ 9 = 3^2 ≤ 3^(a+b)` since `a + b ≥ 2`.
    - `n = 2`: `8 ≤ 3^b` forces `b ≥ 2`, so `27 = 3^3 ≤ 3^(a+b)`.
    - `n ≥ 3`: `(n+1)^3 ≤ 3 n^3 ≤ 3 · 3^b ≤ 3^a 3^b`.
Main: `Reachable (3^n) (3n)` is `Reachable.pow 3 n`.
If `Reachable (3^n) k` then `3^(3n) = (3^n)^3 ≤ 3^k`, so `3n ≤ k` (`Nat.pow_le_pow_iff_right`).
Then `Reachable.complexity_eq` gives `complexity (3^n) = 3n`.
`answer(True)` is `True`, so the iff closes with `iff_of_true`.

## Plan
1. Skeleton in `Solution.lean` with `sorry`s, build.
2. Fill `one_add_case`, `add_case`, `cube_le`, main theorem.
No kernel computation is needed.
