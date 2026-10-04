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

/-- Key relation (★) for non-commuting affine models: in any ring, if `B` is a unit and
`BA + B²AB = 1`, `A + B²A² + B³ = 0` (the linear part of Equation 677), then
`q(B) (B(B²+1)A - 1) = 0` with `q(t) = t³ - t - 1`. -/
theorem star_relation {R : Type} [Ring R] (A : R) (B : Rˣ)
    (g1 : (B : R) * A + (B : R) * B * A * B = 1)
    (g2 : A + (B : R) * B * A * A + (B : R) * B * B = 0) :
    ((B : R) ^ 3 - B - 1) * ((B : R) ^ 3 * A + B * A - 1) = 0 := by
  set b : R := (B : R) with hbdef
  set c : R := ((B⁻¹ : Rˣ) : R) with hcdef
  have hbc : b * c = 1 := B.mul_inv
  have hcb : c * b = 1 := B.inv_mul
  have ecb : ∀ x : R, c * (b * x) = x := fun x => by rw [← mul_assoc, hcb, one_mul]
  have ebc : ∀ x : R, b * (c * x) = x := fun x => by rw [← mul_assoc, hbc, one_mul]
  -- r0 : A + bAb = b⁻¹
  have r0 : A + b * A * b = c := by
    have : c * (b * A + b * b * A * b) = c := by rw [g1, mul_one]
    rw [← this, mul_add, ecb, show b * b * A * b = b * (b * A * b) by noncomm_ring, ecb]
  -- r1 : A b = b⁻² - b⁻¹ A
  have r1 : A * b = c * c - c * A := by
    have : c * (A + b * A * b) = c * c := by rw [r0]
    rw [mul_add, show b * A * b = b * (A * b) by noncomm_ring, ecb] at this
    rw [← this]; noncomm_ring
  -- r2 : A b⁻¹ = b⁻² - b A
  have r2 : A * c = c * c - b * A := by
    have : (A + b * A * b) * c = c * c := by rw [r0]
    rw [add_mul, show b * A * b * c = b * A * (b * c) by noncomm_ring, hbc, mul_one] at this
    rw [← this]; noncomm_ring
  -- r3 : A² = -b⁻²A - b
  have r3 : A * A = -(c * c * A) - b := by
    have h : b * (b * (A * A)) = -A - b * b * b := by
      rw [← sub_eq_zero, ← g2]; noncomm_ring
    have : c * (c * (b * (b * (A * A)))) = c * (c * (-A - b * b * b)) := by rw [h]
    rw [ecb, ecb] at this
    rw [this, show b * b * b = b * (b * b) by noncomm_ring, mul_sub, mul_sub, ecb, ecb]
    noncomm_ring
  -- Compute A²b in two ways.
  have way1 : A * (A * b) = c * c * c - c + b * b * A - c * c * A - c * A - b * b := by
    rw [r1, show A * (c * c - c * A) = (A * c) * c - (A * c) * A by noncomm_ring, r2,
      show (c * c - b * A) * c - (c * c - b * A) * A
        = c * c * c - b * (A * c) - c * c * A + b * (A * A) by noncomm_ring, r2, r3]
    rw [show b * (c * c - b * A) = b * (c * c) - b * b * A by noncomm_ring, ebc,
      show b * (-(c * c * A) - b) = -(b * (c * (c * A))) - b * b by noncomm_ring, ebc]
    noncomm_ring
  have way2 : (A * A) * b = -(c * c * c * c) + c * c * c * A - b * b := by
    rw [r3, show (-(c * c * A) - b) * b = -(c * c * (A * b)) - b * b by noncomm_ring, r1]
    noncomm_ring
  have key : c * c * c + c * c * c * c - c + (b * b - c * c * c - c * c - c) * A = 0 := by
    have h := way1
    rw [← mul_assoc, way2] at h
    rw [← sub_eq_zero] at h
    rw [← neg_eq_zero, ← h]; noncomm_ring
  -- Multiply by b⁴ on the left.
  have key4 : b * (b * (b * (b * (c * c * c + c * c * c * c - c
      + (b * b - c * c * c - c * c - c) * A)))) = 0 := by
    rw [key]; simp
  have expand : b * (b * (b * (b * (c * c * c + c * c * c * c - c
      + (b * b - c * c * c - c * c - c) * A))))
      = b * (b * (b * (b * (c * (c * (c * 1)))))) + b * (b * (b * (b * (c * (c * (c * (c * 1)))))))
        - b * (b * (b * (b * (c * 1))))
        + (b * (b * (b * (b * (b * (b * A)))))) - b * (b * (b * (b * (c * (c * (c * A))))))
        - b * (b * (b * (b * (c * (c * A))))) - b * (b * (b * (b * (c * A)))) := by
    noncomm_ring
  rw [expand] at key4
  simp only [ebc] at key4
  rw [← key4]
  noncomm_ring

/-- Relation (★★): under the hypotheses of `star_relation`, `q(B) o(B) = 0` with
`o(t) = t⁸ + 2t⁶ + t⁴ + t² + t + 1`. So `B` is annihilated by `q · o`. -/
theorem star_star_relation {R : Type} [Ring R] (A : R) (B : Rˣ)
    (g1 : (B : R) * A + (B : R) * B * A * B = 1)
    (g2 : A + (B : R) * B * A * A + (B : R) * B * B = 0) :
    ((B : R) ^ 3 - B - 1) * ((B : R) ^ 8 + 2 * (B : R) ^ 6 + (B : R) ^ 4 + (B : R) ^ 2 + B + 1)
      = 0 := by
  have S0 := star_relation A B g1 g2
  set b : R := (B : R) with hbdef
  set c : R := ((B⁻¹ : Rˣ) : R) with hcdef
  have hbc : b * c = 1 := B.mul_inv
  have hcb : c * b = 1 := B.inv_mul
  have ecb : ∀ x : R, c * (b * x) = x := fun x => by rw [← mul_assoc, hcb, one_mul]
  have ebc : ∀ x : R, b * (c * x) = x := fun x => by rw [← mul_assoc, hbc, one_mul]
  -- A² = -b⁻²A - b (as in `star_relation`)
  have r3 : A * A = -(c * (c * A)) - b := by
    have h : b * (b * (A * A)) = -A - b * b * b := by
      rw [← sub_eq_zero, ← g2]; noncomm_ring
    have : c * (c * (b * (b * (A * A)))) = c * (c * (-A - b * b * b)) := by rw [h]
    rw [ecb, ecb] at this
    rw [this, show b * b * b = b * (b * b) by noncomm_ring, mul_sub, mul_sub, ecb, ecb]
    noncomm_ring
  set q : R := b ^ 3 - b - 1 with hqdef
  -- q (b³ + b) A = q
  have hq : q * ((b ^ 3 + b) * A) = q := by
    have : q * ((b ^ 3 + b) * A) - q = 0 := by rw [← S0]; noncomm_ring
    exact sub_eq_zero.mp this
  -- Right-multiply (★) by A and reduce A².
  have S1 : q * (-(b * A) - c * A - A - b ^ 4 - b ^ 2) = 0 := by
    have e : (b ^ 3 * A + b * A - 1) * A = -(b * A) - c * A - A - b ^ 4 - b ^ 2 := by
      rw [show (b ^ 3 * A + b * A - 1) * A = b * (b * (b * (A * A))) + b * (A * A) - A by
        noncomm_ring, r3]
      rw [show b * (b * (b * (-(c * (c * A)) - b))) = -(b * (b * (b * (c * (c * A))))) - b ^ 4 by
        noncomm_ring, ebc, ebc]
      rw [show b * (-(c * (c * A)) - b) = -(b * (c * (c * A))) - b ^ 2 by noncomm_ring, ebc]
      noncomm_ring
    rw [← e, ← mul_assoc, S0, zero_mul]
  -- Left-multiply by b.
  have S2 : q * (-((b ^ 2 + b + 1) * A) - b ^ 5 - b ^ 3) = 0 := by
    have h : b * (q * (-(b * A) - c * A - A - b ^ 4 - b ^ 2)) = 0 := by rw [S1, mul_zero]
    rw [show b * (q * (-(b * A) - c * A - A - b ^ 4 - b ^ 2))
        = q * (-(b * (b * A)) - b * (c * A) - b * A - b ^ 5 - b ^ 3) by
      rw [hqdef]; noncomm_ring, ebc] at h
    rw [← h]; noncomm_ring
  -- Left-multiply by b³ + b and use hq.
  have h : (b ^ 3 + b) * (q * (-((b ^ 2 + b + 1) * A) - b ^ 5 - b ^ 3)) = 0 := by
    rw [S2, mul_zero]
  rw [show (b ^ 3 + b) * (q * (-((b ^ 2 + b + 1) * A) - b ^ 5 - b ^ 3))
      = -((b ^ 2 + b + 1) * (q * ((b ^ 3 + b) * A))) - (b ^ 3 + b) * q * (b ^ 5 + b ^ 3) by
    rw [hqdef]; noncomm_ring, hq] at h
  rw [← neg_eq_zero, ← h, hqdef]
  noncomm_ring

/-- If moreover `q(B)` is a unit, then `A = u(B)` with
`u(t) = -t - t³ + t⁴ - 2t⁵ + t⁶ - t⁷` (so `A` commutes with `B`) and the linear part of
Equation 255 holds: `A³ + A²B + AB + B = 1`. -/
theorem linear_eq255_of_q_unit {R : Type} [Ring R] (A : R) (B : Rˣ)
    (g1 : (B : R) * A + (B : R) * B * A * B = 1)
    (g2 : A + (B : R) * B * A * A + (B : R) * B * B = 0)
    (hq : IsUnit ((B : R) ^ 3 - B - 1)) :
    A = -(B : R) - (B : R) ^ 3 + (B : R) ^ 4 - 2 * (B : R) ^ 5 + (B : R) ^ 6 - (B : R) ^ 7 ∧
    A ^ 3 + A ^ 2 * B + A * B + B = 1 := by
  have S := star_relation A B g1 g2
  have SS := star_star_relation A B g1 g2
  set b : R := (B : R) with hbdef
  have ho : b ^ 8 + 2 * b ^ 6 + b ^ 4 + b ^ 2 + b + 1 = 0 := hq.mul_right_eq_zero.mp SS
  have h1 : (b ^ 3 + b) * A = 1 := by
    have := hq.mul_right_eq_zero.mp S
    rw [← sub_eq_zero, ← this]; noncomm_ring
  have bez : (-b - b ^ 3 + b ^ 4 - 2 * b ^ 5 + b ^ 6 - b ^ 7) * (b ^ 3 + b)
      + (1 - b + b ^ 2) * (b ^ 8 + 2 * b ^ 6 + b ^ 4 + b ^ 2 + b + 1) = 1 := by noncomm_ring
  have hA : A = -b - b ^ 3 + b ^ 4 - 2 * b ^ 5 + b ^ 6 - b ^ 7 := by
    calc A = ((-b - b ^ 3 + b ^ 4 - 2 * b ^ 5 + b ^ 6 - b ^ 7) * (b ^ 3 + b)
          + (1 - b + b ^ 2) * (b ^ 8 + 2 * b ^ 6 + b ^ 4 + b ^ 2 + b + 1)) * A := by
            rw [bez, one_mul]
      _ = (-b - b ^ 3 + b ^ 4 - 2 * b ^ 5 + b ^ 6 - b ^ 7) * ((b ^ 3 + b) * A)
          + (1 - b + b ^ 2) * ((b ^ 8 + 2 * b ^ 6 + b ^ 4 + b ^ 2 + b + 1) * A) := by
            noncomm_ring
      _ = -b - b ^ 3 + b ^ 4 - 2 * b ^ 5 + b ^ 6 - b ^ 7 := by
            rw [h1, ho, zero_mul, mul_zero, add_zero, mul_one]
  refine ⟨hA, ?_⟩
  have key : (-b - b ^ 3 + b ^ 4 - 2 * b ^ 5 + b ^ 6 - b ^ 7) ^ 3
      + (-b - b ^ 3 + b ^ 4 - 2 * b ^ 5 + b ^ 6 - b ^ 7) ^ 2 * b
      + (-b - b ^ 3 + b ^ 4 - 2 * b ^ 5 + b ^ 6 - b ^ 7) * b + b - 1
      = (-(1) + 2 * b - 2 * b ^ 2 + 2 * b ^ 4 - 4 * b ^ 5 + 5 * b ^ 6 - 8 * b ^ 7 + 10 * b ^ 8 - 12 * b ^ 9 + 10 * b ^ 10 - 7 * b ^ 11 + 3 * b ^ 12 - b ^ 13) * (b ^ 8 + 2 * b ^ 6 + b ^ 4 + b ^ 2 + b + 1) := by noncomm_ring
  rw [ho, mul_zero, sub_eq_zero] at key
  rw [hA]; exact key

/-- The affine magma `x ◇ y = A x + B y + c` on an abelian group, with `A`, `B` arbitrary
(possibly non-commuting) additive endomorphisms. -/
@[reducible] def endAffineMagma (V : Type) [AddCommGroup V] (A B : Module.End ℤ V) (c : V) :
    Magma V :=
  ⟨fun x y => A x + B y + c⟩

/-- Affine models with non-commuting coefficients: if `B` and `q(B) = B³ - B - 1` are invertible,
then `677 → 255`. (On a finite group `B` is automatically invertible under 677.) -/
theorem endAffine_eq677_imp_eq255 (V : Type) [AddCommGroup V] (A B : Module.End ℤ V) (c : V)
    (hB : IsUnit B) (hq : IsUnit (B ^ 3 - B - 1)) :
    @Equation677 V (endAffineMagma V A B c) → @Equation255 V (endAffineMagma V A B c) := by
  intro h
  have expand : ∀ u v : V, @Magma.op V (endAffineMagma V A B c) v
      (@Magma.op V (endAffineMagma V A B c) u
        (@Magma.op V (endAffineMagma V A B c) (@Magma.op V (endAffineMagma V A B c) v u) v)) =
      (B * A + B * B * A * B) u + (A + B * B * A * A + B * B * B) v
        + (B * B * A + B * B + B + 1) c := by
    intro u v
    dsimp only [endAffineMagma, Magma.op]
    simp only [LinearMap.add_apply, Module.End.mul_apply, Module.End.one_apply, map_add]
    abel
  have hK : (B * B * A + B * B + B + 1) c = 0 := by
    have := h 0 0; rw [expand] at this; simpa using this.symm
  have hg1 : B * A + B * B * A * B = 1 := by
    ext v; have := h v 0; rw [expand, hK] at this; simpa using this.symm
  have hg2 : A + B * B * A * A + B * B * B = 0 := by
    ext v; have := h 0 v; rw [expand, hK] at this; simpa using this.symm
  obtain ⟨B', rfl⟩ := hB
  obtain ⟨hA, hT⟩ := linear_eq255_of_q_unit A B' hg1 hg2 hq
  have ho := hq.mul_right_eq_zero.mp (star_star_relation A B' hg1 hg2)
  have h255 : ∀ x : V, @Magma.op V (endAffineMagma V A B' c)
      (@Magma.op V (endAffineMagma V A B' c) (@Magma.op V (endAffineMagma V A B' c) x x) x) x
      = (A ^ 3 + A ^ 2 * B' + A * B' + B') x + (A ^ 2 + A + (1 : Module.End ℤ V)) c := by
    intro x
    dsimp only [endAffineMagma, Magma.op]
    simp only [LinearMap.add_apply, Module.End.mul_apply, Module.End.one_apply, map_add, pow_succ,
      pow_zero, one_mul]
    abel
  -- `H = C0 K + C1 g1` with `A = u(B)` and `g1 = -v·o`: an identity of polynomials in `B`.
  have hH : (A ^ 2 + A + 1 : Module.End ℤ V)
      = (-A + A * B' + A ^ 2 + A ^ 2 * B' ^ 2) * (B' * B' * A + B' * B' + B' + 1)
        - (-1 - 2 * A - A * B' - A ^ 2 * B') * (1 - B' + B' ^ 2)
          * (B' ^ 8 + 2 * B' ^ 6 + B' ^ 4 + B' ^ 2 + B' + 1) := by
    rw [hA]; noncomm_ring
  intro x
  rw [h255, hT, hH, ho, mul_zero, sub_zero, Module.End.mul_apply, hK, map_zero, add_zero,
    Module.End.one_apply]

end Eq677Sweep
