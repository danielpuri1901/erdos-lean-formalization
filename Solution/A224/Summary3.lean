import Solution.A224.Summary2
import Solution.A224.P3Q

/-! a000224 deep attempt, theorem S'': structure of any counterexample, now also excluding `p^3 * q`.
Every `n > 1` at which the biconditional fails is odd, composite, not a prime power, not a product of two
primes, and not of the form `p^2 * q` or `p^3 * q` with `p`, `q` prime. -/

namespace A224Deep
open OeisA224

/-- S''. Structure of a counterexample. -/
theorem counterexample_structure'' {n : ℕ} (hn : 1 < n)
    (h : ¬ ((n.Prime ∧ n ≠ 2) ↔ n ^ 2 ≡ 1 [MOD a n * (a n - 1)])) :
    Odd n ∧ ¬ n.Prime ∧ ¬ IsPrimePow n ∧ (¬ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ n = p * q) ∧
      (¬ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ n = p ^ 2 * q) ∧
      ¬ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ n = p ^ 3 * q := by
  obtain ⟨hodd, hnp, hpp, hsemi, hsq⟩ := counterexample_structure' hn h
  refine ⟨hodd, hnp, hpp, hsemi, hsq, ?_⟩
  rintro ⟨p, q, hp, hq, rfl⟩
  have oddne2 : ∀ m : ℕ, Odd m → m ≠ 2 := by
    rintro m hm rfl
    exact absurd hm (by decide)
  obtain ⟨hp3o, hqo⟩ := Nat.odd_mul.mp hodd
  have hpo : Odd p := (Nat.odd_mul.mp (by rwa [pow_succ] at hp3o)).2
  have hp2 : p ≠ 2 := oddne2 p hpo
  have hq2 : q ≠ 2 := oddne2 q hqo
  by_cases hpq : p = q
  · subst hpq
    exact hpp ((isPrimePow_nat_iff _).mpr ⟨p, 4, hp, by norm_num, by ring⟩)
  · exact h (conjecture_cube_mul_prime hp hq hp2 hq2 hpq)

/-- The conjecture holds for every `n > 1` that is even, prime, a prime power, a product of two primes,
or of the form `p^2 * q` or `p^3 * q` with `p`, `q` prime. -/
theorem conjecture_of_structure'' {n : ℕ} (hn : 1 < n)
    (hs : Even n ∨ n.Prime ∨ IsPrimePow n ∨ (∃ p q : ℕ, p.Prime ∧ q.Prime ∧ n = p * q) ∨
      (∃ p q : ℕ, p.Prime ∧ q.Prime ∧ n = p ^ 2 * q) ∨ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ n = p ^ 3 * q) :
    (n.Prime ∧ n ≠ 2) ↔ n ^ 2 ≡ 1 [MOD a n * (a n - 1)] := by
  by_contra hc
  obtain ⟨hodd, hnp, hpp, hsemi, hsq, hcube⟩ := counterexample_structure'' hn hc
  rcases hs with he | hp | hpp' | hpq | hsq' | hcube'
  · exact (Nat.not_even_iff_odd.mpr hodd) he
  · exact hnp hp
  · exact hpp hpp'
  · exact hsemi hpq
  · exact hsq hsq'
  · exact hcube hcube'

end A224Deep
