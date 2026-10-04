import FormalConjectures.Arxiv.«2607.05739».TanArctanSum
import Solution.TanArctanCheck

/-! Sweep results for `tanarctan` (see `sweep/tanarctan/NOTES.md`). -/

namespace TanArctanSweep

open Arxiv.«2607.05739»

/-- Reduction: `x_n` is an integer exactly when `|A_n| = gcd(A_n, B_n)`, i.e. when `A_n` is as small
as the content of `Z_n` allows. -/
theorem isIntegerValue_iff_gcd_eq_natAbs (n : Nat) :
    IsIntegerValue n ↔ Int.gcd (A n) (B n) = (A n).natAbs :=
  Int.gcd_eq_natAbs_left_iff_dvd.symm

/-- The conjecture of Amdeberhan-Medina-Moll on the finite range `5 ≤ n ≤ 10000`. -/
theorem tan_arctan_sum_not_integer_of_le_10000 :
    ∀ n : Nat, 5 ≤ n → n ≤ 10000 → ¬ IsIntegerValue n :=
  fun n h5 hN => not_isIntegerValue_of_check 9996 check_to_10000 n h5 (by omega)

end TanArctanSweep
