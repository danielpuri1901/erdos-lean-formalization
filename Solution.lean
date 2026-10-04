import FormalConjectures.Wikipedia.GaussCircleProblem

/-! Solution for the gausscircle target. See `TASK.md` and `NOTES.md`.

Gauss's area argument: the half-open unit squares centred at the lattice points of the closed
disc of radius `r` have total area `N r`, contain the disc of radius `r - √2/2` and lie in the
closed disc of radius `r + √2/2`. -/

open MeasureTheory Metric Filter

open scoped EuclideanGeometry Real

namespace GaussCircleSol

/-- Rounding to the nearest lattice point (halves round up). -/
noncomputable def rnd (x : EuclideanSpace ℝ (Fin 2)) : ℤ × ℤ :=
  (⌊x 0 + 1 / 2⌋, ⌊x 1 + 1 / 2⌋)

/-- The lattice point `z` as a point of the plane. -/
noncomputable def pt (z : ℤ × ℤ) : EuclideanSpace ℝ (Fin 2) := !₂[(z.1 : ℝ), (z.2 : ℝ)]

/-- The lattice points of the closed disc of radius `r`. -/
def P (r : ℝ) : Set (ℤ × ℤ) := {z | pt z ∈ closedBall (0 : EuclideanSpace ℝ (Fin 2)) r}

lemma norm_pt_sq (z : ℤ × ℤ) : ‖pt z‖ ^ 2 = (z.1 : ℝ) ^ 2 + (z.2 : ℝ) ^ 2 := by
  simp [EuclideanSpace.real_norm_sq_eq, pt, Fin.sum_univ_two]

lemma mem_P (r : ℝ) (z : ℤ × ℤ) : z ∈ P r ↔ ‖pt z‖ ≤ r := by
  simp [P]

lemma N_eq (r : ℝ) : GaussCircleProblem.N r = (P r).ncard := by
  rfl

lemma dist_rnd_le (x : EuclideanSpace ℝ (Fin 2)) : ‖x - pt (rnd x)‖ ≤ √2 / 2 := by
  have h0 := Int.floor_le (x 0 + 1 / 2)
  have h0' := Int.lt_floor_add_one (x 0 + 1 / 2)
  have h1 := Int.floor_le (x 1 + 1 / 2)
  have h1' := Int.lt_floor_add_one (x 1 + 1 / 2)
  have hs : √2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  rw [EuclideanSpace.norm_eq, Real.sqrt_le_iff]
  refine ⟨by positivity, ?_⟩
  simp only [Fin.sum_univ_two, Real.norm_eq_abs, sq_abs, rnd, pt, PiLp.sub_apply,
    Matrix.cons_val_zero, Matrix.cons_val_one]
  nlinarith

lemma measurableSet_fibre (z : ℤ × ℤ) : MeasurableSet (rnd ⁻¹' {z}) := by
  have hm : Measurable rnd := by
    unfold rnd
    fun_prop
  exact hm (measurableSet_singleton z)

lemma volume_fibre (z : ℤ × ℤ) : volume (rnd ⁻¹' {z}) = 1 := by
  have hset : rnd ⁻¹' {z} = WithLp.ofLp ⁻¹'
      Set.pi Set.univ (fun i => Set.Ico (![(z.1 : ℝ), z.2] i - 1 / 2)
        (![(z.1 : ℝ), z.2] i + 1 / 2)) := by
    ext x
    simp only [Set.mem_preimage, Set.mem_singleton_iff, Set.mem_univ_pi, Set.mem_Ico,
      Fin.forall_fin_two, Matrix.cons_val_zero, Matrix.cons_val_one, rnd, Prod.ext_iff,
      Int.floor_eq_iff]
    constructor
    · rintro ⟨⟨a, b⟩, ⟨c, d⟩⟩
      refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩⟩ <;> simp <;> linarith
    · rintro ⟨⟨a, b⟩, ⟨c, d⟩⟩
      refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩⟩ <;> simp at * <;> linarith
  rw [hset, (PiLp.volume_preserving_ofLp (Fin 2)).measure_preimage
    (MeasurableSet.univ_pi (fun _ => measurableSet_Ico)).nullMeasurableSet, Real.volume_pi_Ico]
  norm_num

lemma P_finite (r : ℝ) : (P r).Finite := by
  apply ((Set.finite_Icc (-⌈r⌉) ⌈r⌉).prod (Set.finite_Icc (-⌈r⌉) ⌈r⌉)).subset
  rintro ⟨m, n⟩ hz
  have h1 : ‖pt (m, n)‖ ≤ r := (mem_P r _).mp hz
  have h2 := norm_pt_sq (m, n)
  have h3 := norm_nonneg (pt (m, n))
  have hc := Int.le_ceil r
  have hm : |(m : ℝ)| ≤ ‖pt (m, n)‖ := abs_le_of_sq_le_sq' (by simp at h2; nlinarith) h3 |> abs_le.mpr
  have hn : |(n : ℝ)| ≤ ‖pt (m, n)‖ := abs_le_of_sq_le_sq' (by simp at h2; nlinarith) h3 |> abs_le.mpr
  rw [abs_le] at hm hn
  simp only [Set.mem_prod, Set.mem_Icc]
  refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩⟩
  · have : ((-⌈r⌉ : ℤ) : ℝ) ≤ m := by push_cast; linarith
    exact_mod_cast this
  · have : (m : ℝ) ≤ ((⌈r⌉ : ℤ) : ℝ) := by linarith
    exact_mod_cast this
  · have : ((-⌈r⌉ : ℤ) : ℝ) ≤ n := by push_cast; linarith
    exact_mod_cast this
  · have : (n : ℝ) ≤ ((⌈r⌉ : ℤ) : ℝ) := by linarith
    exact_mod_cast this

lemma volume_preimage_P (r : ℝ) : volume (rnd ⁻¹' P r) = (P r).ncard := by
  have hf := P_finite r
  obtain ⟨F, hF⟩ := hf.exists_finset_coe
  rw [← hF, Set.ncard_coe_finset,
    ← sum_measure_preimage_singleton _ (fun z _ => measurableSet_fibre z)]
  simp [volume_fibre]

lemma ball_subset (r : ℝ) : ball (0 : EuclideanSpace ℝ (Fin 2)) (r - √2 / 2) ⊆ rnd ⁻¹' P r := by
  intro x hx
  rw [mem_ball_zero_iff] at hx
  rw [Set.mem_preimage, mem_P]
  have h1 := dist_rnd_le x
  have h2 := norm_sub_norm_le (pt (rnd x)) x
  rw [norm_sub_rev] at h2
  linarith

lemma subset_closedBall (r : ℝ) :
    rnd ⁻¹' P r ⊆ closedBall (0 : EuclideanSpace ℝ (Fin 2)) (r + √2 / 2) := by
  intro x hx
  rw [Set.mem_preimage, mem_P] at hx
  rw [mem_closedBall_zero_iff]
  have h1 := dist_rnd_le x
  have h2 := norm_sub_norm_le x (pt (rnd x))
  linarith

lemma card_le (r : ℝ) (hr : 0 ≤ r) : ((P r).ncard : ℝ) ≤ π * (r + √2 / 2) ^ 2 := by
  have h := measure_mono (μ := volume) (subset_closedBall r)
  rw [volume_preimage_P, EuclideanSpace.volume_closedBall_fin_two,
    ← ENNReal.ofReal_pow (by positivity), ← ENNReal.ofReal_mul (by positivity),
    ← ENNReal.ofReal_natCast, ENNReal.ofReal_le_ofReal_iff (by positivity)] at h
  linarith

lemma le_card (r : ℝ) (hr : √2 / 2 ≤ r) : π * (r - √2 / 2) ^ 2 ≤ (P r).ncard := by
  have h := measure_mono (μ := volume) (ball_subset r)
  rw [volume_preimage_P, EuclideanSpace.volume_ball_fin_two,
    ← ENNReal.ofReal_pow (by linarith), ← ENNReal.ofReal_mul (by positivity),
    ← ENNReal.ofReal_natCast, ENNReal.ofReal_le_ofReal_iff (by positivity)] at h
  linarith

end GaussCircleSol

theorem gauss_circle_error_le : type_of% @GaussCircleProblem.error_le := by
  filter_upwards [eventually_ge_atTop (1 : ℝ)] with r hr
  have hs : √2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hs1 : 1 ≤ √2 := by
    rw [show (1 : ℝ) = √1 by simp]
    exact Real.sqrt_le_sqrt (by norm_num)
  have hs2 : √2 ≤ 2 := by nlinarith
  have h1 := GaussCircleSol.card_le r (by linarith)
  have h2 := GaussCircleSol.le_card r (by linarith)
  have hπ := Real.pi_pos
  have hk : 0 ≤ π * (√2 * r - 1 / 2) := mul_nonneg hπ.le (by nlinarith)
  have e1 : π * (r + √2 / 2) ^ 2 = π * r ^ 2 + π * (√2 * r) + π / 2 := by
    ring_nf; rw [hs]; ring
  have e2 : π * (r - √2 / 2) ^ 2 = π * r ^ 2 - π * (√2 * r) + π / 2 := by
    ring_nf; rw [hs]; ring
  have e3 : 2 * √2 * π * r = 2 * (π * (√2 * r)) := by ring
  show |((GaussCircleSol.P r).ncard : ℝ) - π * r ^ 2| ≤ 2 * √2 * π * r
  rw [abs_le, e3]
  constructor
  · linarith
  · linarith
