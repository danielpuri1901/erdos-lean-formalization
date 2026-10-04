# gaussexact notes

## Argument

Let K = ⌊r²⌋₊ (r ≥ 0). For integers m, n: m²+n² ≤ r² iff m²+n² ≤ K. So N r = L K, the number of
(a, b) ∈ ℤ² with a²+b² ≤ K, and ⌊r²/d⌋ = K / d (Nat division) for d ≥ 1 (`Int.floor_div_natCast`).
The tsum terms vanish for i > K, so the tsum is a sum over range (K+1).

1. L K = 1 + Σ_{n<K} R(n+1), R n = #{z ∈ ℤ[i] : N z = n} (fibres of the norm; R 0 = 1).
2. Jacobi: R n = 4 D n for n ≥ 1, D n = Σ_{d ∣ n} χ₄ d. Strong induction on n with p = minFac n, n = p m:
   - D(p m) = (1 + χ p) D m − [p ∣ m] χ p D(m/p)  (split divisors of p m by p ∣ d).
   - p = 2: π = 1+i; every z with 2 ∣ N z has π ∣ z, and w ↦ π w is a bijection onto them: R(2m) = R m.
   - p ≡ 3: p prime in ℤ[i] (Mathlib), p ∣ N z ⇒ p ∣ z, so R(p m) = [p ∣ m] R(m/p).
   - p ≡ 1: p = a²+b² (Mathlib), π = a+bi prime (norm prime). Sets A = {π ∣ z}, B = {π̄ ∣ z} cover,
     A ∩ B = {p ∣ z} (π̄ ∤ π as p odd), |A| = |B| = R m, so R(p m) + [p ∣ m] R(m/p) = 2 R m.
3. Σ_{n<K} D(n+1) = Σ_{d<M} χ d (K/d) for M > K (induction on K, `Nat.succ_div`).
4. Σ_{d<4J} χ d f d = Σ_{i<J} (f(4i+1) − f(4i+3)).

## Plan / state

Skeleton with sorry first, then fill. All in `Solution.lean` (no heavy kernel checks; the only
`decide` calls are R 0 = 1 and R 1 = 4 on 1×1 and 3×3 boxes).

Decision: Jacobi's two-squares formula is not in Mathlib, so it is proved here through `GaussianInt`
(prime of norm p is irreducible hence prime in the UFD; `GaussianInt.prime_of_nat_prime_of_mod_four_eq_three`;
`Nat.Prime.sq_add_sq`), without valuations: one prime factor at a time, with inclusion-exclusion for p ≡ 1.

State: `lake build Solution Challenge` passes; `gauss_circle_exact_form` has no sorry and
`#print axioms` gives [propext, Classical.choice, Quot.sound]; `example : type_of% @GaussCircleProblem.exact_form_floor
:= @gauss_circle_exact_form` checks. Submitted with a `submit(gaussexact):` commit.
The checker is paused today (per the user), so no verdict was polled; the status of
`comparator/gaussexact` on the submit commit is unknown at the end of this session.

Submit commit: 3e1126f (`submit(gaussexact): ...`), pushed to `run/gaussexact` at 19:39 UTC.
Verdict not polled (checker paused today). Next session: check `comparator/gaussexact` on 3e1126f.
