import Solution.TanArctanCheck

/-! A checker that also returns the final state, so a range can be split into independent chunks. -/

namespace TanArctanSweep

open Arxiv.«2607.05739»

/-- Checks the indices `n, ..., n+fuel-1` from `(a, b) = Z_n`, and returns `Z_{n+fuel}`. -/
def runFrom : Nat → Nat → Int → Int → Bool × Int × Int
  | 0, _, a, b => (true, a, b)
  | fuel + 1, n, a, b =>
    let r := runFrom fuel (n + 1) (a - ((n : Int) + 1) * b) (b + ((n : Int) + 1) * a)
    ((b % a != 0) && r.1, r.2)

/-- Soundness of `runFrom`: the range is clean, and the returned state is `Z_{n+fuel}`. -/
lemma runFrom_sound (fuel : Nat) : ∀ (n : Nat) (a b a' b' : Int),
    runFrom fuel n a b = (true, a', b') → zrec n = (a, b) →
    (∀ m, n ≤ m → m < n + fuel → ¬ (zrec m).1 ∣ (zrec m).2) ∧ zrec (n + fuel) = (a', b') := by
  induction fuel with
  | zero =>
    intro n a b a' b' hr hz
    simp only [runFrom, Prod.mk.injEq, true_and] at hr
    obtain ⟨rfl, rfl⟩ := hr
    exact ⟨fun m h1 h2 => by omega, hz⟩
  | succ fuel ih =>
    intro n a b a' b' hr hz
    simp only [runFrom, Prod.mk.injEq, Bool.and_eq_true, bne_iff_ne, ne_eq] at hr
    obtain ⟨⟨hab, h1⟩, h2⟩ := hr
    have hz' : zrec (n + 1) = (a - ((n : Int) + 1) * b, b + ((n : Int) + 1) * a) := by
      simp [zrec, hz]
    have hr' : runFrom fuel (n + 1) (a - ((n : Int) + 1) * b) (b + ((n : Int) + 1) * a)
        = (true, a', b') := Prod.ext h1 h2
    obtain ⟨ih1, ih2⟩ := ih (n + 1) _ _ a' b' hr' hz'
    refine ⟨fun m hm1 hm2 => ?_, by rw [show n + (fuel + 1) = n + 1 + fuel by omega]; exact ih2⟩
    rcases Nat.eq_or_lt_of_le hm1 with rfl | hlt
    · rw [hz, Int.dvd_iff_emod_eq_zero]
      exact hab
    · exact ih1 m hlt (by omega)

end TanArctanSweep
