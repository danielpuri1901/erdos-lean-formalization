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

/-- The affine magma `x ◇ y = a • x + b • y + c` on a module over a commutative ring. -/
@[reducible] def moduleAffineMagma (R V : Type) [CommRing R] [AddCommGroup V] [Module R V]
    (a b : R) (c : V) : Magma V :=
  ⟨fun x y => a • x + b • y + c⟩

/-- Affine models `x ◇ y = a • x + b • y + c` on any module over a commutative ring satisfy
`677 → 255`. With `R = ℤ[X, Y]` acting through two commuting endomorphisms `A`, `B`, this covers
every affine model `x ◇ y = A x + B y + c` on an abelian group with `A B = B A`. -/
theorem moduleAffine_eq677_imp_eq255 (R V : Type) [CommRing R] [AddCommGroup V] [Module R V]
    (a b : R) (c : V) :
    @Equation677 V (moduleAffineMagma R V a b c) → @Equation255 V (moduleAffineMagma R V a b c) := by
  intro h x
  -- Expanded, `y ◇ (x ◇ ((y ◇ x) ◇ y)) = (g1 + 1) • x + g2 • y + K • c`.
  have expand : ∀ u v : V, @Magma.op V (moduleAffineMagma R V a b c) v
      (@Magma.op V (moduleAffineMagma R V a b c) u
        (@Magma.op V (moduleAffineMagma R V a b c)
          (@Magma.op V (moduleAffineMagma R V a b c) v u) v)) =
      (a * b + a * b ^ 3) • u + (a + a ^ 2 * b ^ 2 + b ^ 3) • v
        + (a * b ^ 2 + b ^ 2 + b + 1) • c := by
    intro u v
    dsimp only [moduleAffineMagma, Magma.op]
    module
  have hK : (a * b ^ 2 + b ^ 2 + b + 1) • c = 0 := by
    have := h 0 0; rw [expand] at this; simpa using this.symm
  have hg1 : ∀ u : V, (a * b + a * b ^ 3 - 1) • u = 0 := by
    intro u; have := h u 0; rw [expand, hK] at this
    rw [sub_smul, one_smul]; simp only [smul_zero, add_zero] at this; rw [← this, sub_self]
  have hg2 : ∀ u : V, (a + a ^ 2 * b ^ 2 + b ^ 3) • u = 0 := by
    intro u; have := h 0 u; rw [expand, hK] at this; simpa using this.symm
  -- `T - 1 = P g1 + Q g2` and `H = C0 K + C1 g1` in `R`.
  have hT : a ^ 3 + a ^ 2 * b + a * b + b
      = 1 + (1 - b - a * b ^ 2 - a ^ 2 - a ^ 3 * b) * (a * b + a * b ^ 3 - 1)
        + (-a + a * b + a ^ 2 + a ^ 2 * b ^ 2) * (a + a ^ 2 * b ^ 2 + b ^ 3) := by ring
  have hH : a ^ 2 + a + 1
      = (-a + a * b + a ^ 2 + a ^ 2 * b ^ 2) * (a * b ^ 2 + b ^ 2 + b + 1)
        + (-1 - 2 * a - a * b - a ^ 2 * b) * (a * b + a * b ^ 3 - 1) := by ring
  have h255 : @Magma.op V (moduleAffineMagma R V a b c)
      (@Magma.op V (moduleAffineMagma R V a b c) (@Magma.op V (moduleAffineMagma R V a b c) x x) x) x
      = (a ^ 3 + a ^ 2 * b + a * b + b) • x + (a ^ 2 + a + 1) • c := by
    dsimp only [moduleAffineMagma, Magma.op]
    module
  rw [h255, hT, hH]
  simp only [add_smul, one_smul, mul_smul, hg1, hg2, hK, smul_zero, add_zero]

end Eq677Sweep
