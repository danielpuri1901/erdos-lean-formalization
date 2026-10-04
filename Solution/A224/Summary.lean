import Solution.A224.Sweep
import Solution.A224.PrimePow

/-! a000224 deep attempt, theorem S: structure of any counterexample to the conjecture.
Every `n > 1` at which the biconditional fails is odd, composite, not a prime power, and not a
product of two primes (so it has at least two distinct prime factors and at least three prime
factors counted with multiplicity). -/

namespace A224Deep
open OeisA224

/-- S. Structure of a counterexample. -/
theorem counterexample_structure {n : ℕ} (hn : 1 < n)
    (h : ¬ ((n.Prime ∧ n ≠ 2) ↔ n ^ 2 ≡ 1 [MOD a n * (a n - 1)])) :
    Odd n ∧ ¬ n.Prime ∧ ¬ IsPrimePow n ∧ ¬ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ n = p * q := by
  have hodd : Odd n := by
    rcases Nat.even_or_odd n with he | ho
    · exact absurd (A224Sweep.conjecture_of_even n hn he) h
    · exact ho
  have oddne2 : ∀ m : ℕ, Odd m → m ≠ 2 := by
    rintro m hm rfl
    exact absurd hm (by decide)
  have hnp : ¬ n.Prime := by
    intro hp
    have hn2 : n ≠ 2 := oddne2 n hodd
    exact h (iff_of_true ⟨hp, hn2⟩ (A224Sweep.modEq_of_odd_prime hp hn2))
  have hpp : ¬ IsPrimePow n := by
    intro hpp
    obtain ⟨p, k, hp, hk, rfl⟩ := (isPrimePow_nat_iff n).mp hpp
    have hp2 : p ≠ 2 := by
      rintro rfl
      have he : Even (2 ^ k) := (Nat.even_pow).mpr ⟨even_two, hk.ne'⟩
      exact (Nat.not_even_iff_odd.mpr hodd) he
    rcases Nat.lt_or_ge k 2 with hk1 | hk2
    · have hk' : k = 1 := by omega
      subst hk'
      rw [pow_one] at hnp
      exact hnp hp
    · exact h (A224Deep.conjecture_prime_pow hp hp2 hk2)
  have hsemi : ¬ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ n = p * q := by
    rintro ⟨p, q, hp, hq, rfl⟩
    obtain ⟨hpo, hqo⟩ := Nat.odd_mul.mp hodd
    have hp2 : p ≠ 2 := oddne2 p hpo
    have hq2 : q ≠ 2 := oddne2 q hqo
    rcases lt_trichotomy p q with hpq | hpq | hqp
    · exact h (A224Sweep.conjecture_semiprime hp hq hp2 hq2 hpq)
    · subst hpq
      have hsq : p * p = p ^ 2 := by ring
      rw [hsq] at h
      exact h (A224Deep.conjecture_prime_pow hp hp2 (le_refl 2))
    · rw [mul_comm p q] at h
      exact h (A224Sweep.conjecture_semiprime hq hp hq2 hp2 hqp)
  exact ⟨hodd, hnp, hpp, hsemi⟩

/-- The conjecture holds for every `n > 1` that is even, prime, a prime power, or a product of two
primes. -/
theorem conjecture_of_structure {n : ℕ} (hn : 1 < n)
    (hs : Even n ∨ n.Prime ∨ IsPrimePow n ∨ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ n = p * q) :
    (n.Prime ∧ n ≠ 2) ↔ n ^ 2 ≡ 1 [MOD a n * (a n - 1)] := by
  by_contra hc
  obtain ⟨hodd, hnp, hpp, hsemi⟩ := counterexample_structure hn hc
  rcases hs with he | hp | hpp' | hpq
  · exact (Nat.not_even_iff_odd.mpr hodd) he
  · exact hnp hp
  · exact hpp hpp'
  · exact hsemi hpq

end A224Deep
