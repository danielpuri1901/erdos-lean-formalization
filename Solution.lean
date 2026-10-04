import FormalConjectures.Other.EquationalTheories_677_255

/-! Sweep work for eq677: Equation 677 → Equation 255 in finite magmas.

Proved special case: every affine magma `x ◇ y = a * x + b * y + c` over a commutative ring
that satisfies Equation 677 also satisfies Equation 255. (This covers all affine models over
`ZMod n`, so no counterexample to the open problem can be of that form.) -/

namespace Eq677Sweep
open EquationalTheories_677_255

/-- The affine magma `x ◇ y = a * x + b * y + c` on a commutative ring. -/
@[reducible] def affineMagma (R : Type) [CommRing R] (a b c : R) : Magma R :=
  ⟨fun x y => a * x + b * y + c⟩

/-- Affine models over a commutative ring cannot separate Equation 677 from Equation 255. -/
theorem affine_eq677_imp_eq255 (R : Type) [CommRing R] (a b c : R) :
    @Equation677 R (affineMagma R a b c) → @Equation255 R (affineMagma R a b c) := by
  intro h x
  -- The three instances of 677 give: K c = 0, g1 + K c = 0, g2 + K c = 0, where
  -- g1 = a b + a b³ - 1, g2 = a + a² b² + b³, K = a b² + b² + b + 1.
  have h00 := h 0 0
  have h10 := h 1 0
  have h01 := h 0 1
  dsimp only [affineMagma, Magma.op] at h00 h10 h01 ⊢
  -- 255 at x reads x = T x + H c with T = a³ + a²b + ab + b, H = a² + a + 1, and
  -- T - 1 = P g1 + Q g2,  H = C0 K + C1 g1  (integer certificates found by linear algebra).
  linear_combination
    ((1 - b - a * b ^ 2 - a ^ 2 - a ^ 3 * b) * x + (-1 - 2 * a - a * b - a ^ 2 * b) * c) * h10
    + ((-a + a * b + a ^ 2 + a ^ 2 * b ^ 2) * x) * h01
    + ((-a + a * b + a ^ 2 + a ^ 2 * b ^ 2)
        - (1 - b - a * b ^ 2 - a ^ 2 - a ^ 3 * b) * x
        - (-a + a * b + a ^ 2 + a ^ 2 * b ^ 2) * x
        - (-1 - 2 * a - a * b - a ^ 2 * b) * c) * h00

end Eq677Sweep
