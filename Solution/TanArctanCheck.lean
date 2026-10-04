import FormalConjectures.Arxiv.«2607.05739».TanArctanSum

/-! Checker for `tanarctan`: `Z_n` by recursion (`zrec`, `zrec_eq`) and a sound Boolean checker. -/

namespace TanArctanSweep

open Arxiv.«2607.05739»

/-- `Z_n = (A_n, B_n)` by plain recursion: `(a + b i)(1 + (n+1) i) = (a - (n+1) b) + (b + (n+1) a) i`. -/
def zrec : Nat → Int × Int
  | 0 => (1, 0)
  | n + 1 => ((zrec n).1 - ((n : Int) + 1) * (zrec n).2, (zrec n).2 + ((n : Int) + 1) * (zrec n).1)

/-- Step 1: `Z_{n+1} = Z_n (1 + (n+1) i)`. -/
lemma gaussProd_succ (n : Nat) :
    gaussProd (n + 1) = gaussProd n * (⟨1, ((n + 1 : Nat) : Int)⟩ : GaussianInt) := by
  unfold gaussProd
  rw [Finset.prod_Icc_succ_top (by omega)]

/-- Step 2: the recursion computes `(A n, B n)`. -/
lemma zrec_eq (n : Nat) : zrec n = (A n, B n) := by
  induction n with
  | zero => simp [zrec, A, B, gaussProd]
  | succ n ih =>
    simp only [zrec, ih, A, B, gaussProd_succ, Zsqrtd.re_mul, Zsqrtd.im_mul]
    push_cast
    ext <;> simp <;> ring

/-- Checks the indices `n, n+1, ..., n+fuel-1`, given `(a, b) = Z_n`: `A_m` must not divide `B_m`. -/
def checkFrom : Nat → Nat → Int → Int → Bool
  | 0, _, _, _ => true
  | fuel + 1, n, a, b =>
    (b % a != 0) && checkFrom fuel (n + 1) (a - ((n : Int) + 1) * b) (b + ((n : Int) + 1) * a)

/-- Step 3: soundness of the checker. -/
lemma checkFrom_sound (fuel : Nat) : ∀ (n : Nat) (a b : Int), checkFrom fuel n a b = true →
    zrec n = (a, b) → ∀ m, n ≤ m → m < n + fuel → ¬ (zrec m).1 ∣ (zrec m).2 := by
  induction fuel with
  | zero => intro n a b _ _ m h1 h2; omega
  | succ fuel ih =>
    intro n a b hc hz m h1 h2
    simp only [checkFrom, Bool.and_eq_true, bne_iff_ne, ne_eq] at hc
    rcases Nat.eq_or_lt_of_le h1 with rfl | hlt
    · rw [hz, Int.dvd_iff_emod_eq_zero]
      exact hc.1
    · have hz' : zrec (n + 1) = (a - ((n : Int) + 1) * b, b + ((n : Int) + 1) * a) := by
        simp [zrec, hz]
      exact ih (n + 1) _ _ hc.2 hz' m hlt (by omega)

/-- The bridge: a successful check from `n = 5` proves the conjecture on `[5, 5 + fuel)`. -/
lemma not_isIntegerValue_of_check (fuel : Nat) (hc : checkFrom fuel 5 190 (-90) = true)
    (n : Nat) (h5 : 5 ≤ n) (hN : n < 5 + fuel) : ¬ IsIntegerValue n := by
  have h := checkFrom_sound fuel 5 190 (-90) hc (by decide) n h5 hN
  rw [zrec_eq] at h
  exact h

-- Step 4 used to be `checkFrom 9996 5 190 (-90) = true` by `decide +kernel` (300 s, 7.6 GB).
-- It is superseded by the chunked runs of `runFrom` (see `Solution.lean`), which cover `5 ≤ n ≤ 50000`.

end TanArctanSweep
