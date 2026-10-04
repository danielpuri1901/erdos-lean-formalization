import Solution.A224.Summary3
import Solution.A224.P4Q

/-! a000224 deep attempt, theorem S''': structure of any counterexample, now also excluding `p^e * q` for
every `e` (the clauses `p * q`, `p^2 * q`, `p^3 * q` are kept for continuity). -/

namespace A224Deep
open OeisA224


/-- S'''. Structure of a counterexample: also not `p^e * q` for any `e`. -/
theorem counterexample_structure''' {n : ℕ} (hn : 1 < n)
    (h : ¬ ((n.Prime ∧ n ≠ 2) ↔ n ^ 2 ≡ 1 [MOD a n * (a n - 1)])) :
    Odd n ∧ ¬ n.Prime ∧ ¬ IsPrimePow n ∧ (¬ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ n = p * q) ∧
      (¬ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ n = p ^ 2 * q) ∧
      (¬ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ n = p ^ 3 * q) ∧
      ¬ ∃ p q e : ℕ, p.Prime ∧ q.Prime ∧ n = p ^ e * q := by
  obtain ⟨hodd, hnp, hpp, hsemi, hsq, hcube⟩ := counterexample_structure'' hn h
  refine ⟨hodd, hnp, hpp, hsemi, hsq, hcube, ?_⟩
  rintro ⟨p, q, e, hp, hq, rfl⟩
  rcases Nat.lt_or_ge e 4 with he | he
  · interval_cases e
    · exact hnp (by simpa using hq)
    · exact hsemi ⟨p, q, hp, hq, by ring⟩
    · exact hsq ⟨p, q, hp, hq, rfl⟩
    · exact hcube ⟨p, q, hp, hq, rfl⟩
  · have oddne2 : ∀ m : ℕ, Odd m → m ≠ 2 := by
      rintro m hm rfl
      exact absurd hm (by decide)
    obtain ⟨hpeo, hqo⟩ := Nat.odd_mul.mp hodd
    have hpo : Odd p := by
      obtain ⟨e', rfl⟩ : ∃ e', e = e' + 1 := ⟨e - 1, by omega⟩
      rw [pow_succ] at hpeo
      exact (Nat.odd_mul.mp hpeo).2
    have hp2 : p ≠ 2 := oddne2 p hpo
    have hq2 : q ≠ 2 := oddne2 q hqo
    by_cases hpq : p = q
    · subst hpq
      exact hpp ((isPrimePow_nat_iff _).mpr ⟨p, e + 1, hp, by omega, by ring⟩)
    · exact h (conjecture_pow_mul_prime hp hq hp2 hq2 hpq he)

/-- The conjecture holds for every `n > 1` that is even, prime, a prime power, or of the form
`p^e * q` with `p`, `q` prime and any `e` (this includes `p * q`, `p^2 * q`, `p^3 * q`). -/
theorem conjecture_of_structure''' {n : ℕ} (hn : 1 < n)
    (hs : Even n ∨ n.Prime ∨ IsPrimePow n ∨ ∃ p q e : ℕ, p.Prime ∧ q.Prime ∧ n = p ^ e * q) :
    (n.Prime ∧ n ≠ 2) ↔ n ^ 2 ≡ 1 [MOD a n * (a n - 1)] := by
  by_contra hc
  obtain ⟨hodd, hnp, hpp, -, -, -, hpow⟩ := counterexample_structure''' hn hc
  rcases hs with he | hp | hpp' | hpow'
  · exact (Nat.not_even_iff_odd.mpr hodd) he
  · exact hnp hp
  · exact hpp hpp'
  · exact hpow hpow'


end A224Deep
