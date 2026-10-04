# gausscircle notes

## Argument (Gauss, area version)

Work in `E2 := EuclideanSpace ℝ (Fin 2)` with `volume`.
Let `P r := {(m, n) : ℤ × ℤ | !₂[m, n] ∈ closedBall 0 r}`, so `N r = (P r).ncard`.

- Rounding map `rnd x := (⌊x 0 + 1/2⌋, ⌊x 1 + 1/2⌋) : ℤ × ℤ` and `φ z := !₂[z.1, z.2]`.
- Each coordinate of `x - φ (rnd x)` has absolute value at most 1/2, so `‖x - φ (rnd x)‖ ≤ √2/2`.
- The fibre `rnd ⁻¹' {z}` is a half-open unit square; it is measurable with volume 1
  (transport by `EuclideanSpace.volume_preserving_measurableEquiv` to `Fin 2 → ℝ`, then `Real.volume_pi_Ico`).
- `P r` is finite, and `volume (rnd ⁻¹' P r) = card (P r)` by `MeasureTheory.sum_measure_preimage_singleton`.
- `ball 0 (r - √2/2) ⊆ rnd ⁻¹' P r ⊆ closedBall 0 (r + √2/2)` by the triangle inequality.
- `volume_ball_fin_two` / `volume_closedBall_fin_two` give `π ρ²`.
- Hence `π (r - √2/2)² ≤ N r ≤ π (r + √2/2)²` for `r ≥ √2/2`,
  so `|N r - π r²| ≤ π (√2 r + 1/2) ≤ 2 √2 π r` for `r ≥ 1`.

## Plan

1. Skeleton in `Solution.lean`: lemmas stated with `sorry`, build passes.
2. Fill: norm of `φ`, rounding distance, fibre volume and measurability, finiteness,
   preimage volume, the two inclusions, the two volume bounds, final algebra.

## Decisions

- Area argument (not columns): Mathlib already has the volume of a disc in `EuclideanSpace ℝ (Fin 2)`.

## Status

- All lemmas proved; `lake build Solution` passes with no warnings.
- `#print axioms gauss_circle_error_le`: `propext`, `Classical.choice`, `Quot.sound`.
- `type_of% @gauss_circle_error_le = type_of% @GaussCircleProblem.error_le` checks by `rfl`.
- Submitted as `60cbba7`; `comparator/gausscircle` reported success ("Your solution is okay!") at 18:48 UTC, about 22 minutes of work.
