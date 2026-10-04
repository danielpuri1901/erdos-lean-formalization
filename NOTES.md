# Notes: dihedral Leinster target

Goal: `dihedral_leinster_iff : type_of% @LeinsterGroup.dihedral_is_leinster_iff_odd_perfect`, i.e.
for `n : ℕ` with `[NeZero n]`: `IsLeinster (DihedralGroup n) ↔ Nat.Perfect n ∧ Odd n`,
where `IsLeinster G := ∑ H : {H : Subgroup G // H.Normal}, Nat.card H = 2 * Fintype.card G`
(classical `Fintype` on the subtype). `Fintype.card (DihedralGroup n) = 2 * n` (`DihedralGroup.card`).

## Argument (checked by hand, including n = 1, 2)

Mathlib conventions: `r i * r j = r (i+j)`, `r i * sr j = sr (j-i)`, `sr i * r j = sr (i+j)`,
`sr i * sr j = r (j-i)`, `(sr i)⁻¹ = sr i`.

* `R := zpowers (r 1)`; `g ∈ R ↔ ∃ i, g = r i`; `Nat.card R = n` (`orderOf_r_one`).
* `K d := zpowers (r ((n/d : ℕ) : ZMod n))`. For `d ∣ n`: `Nat.card (K d) = d`
  (`orderOf_r`: `n / gcd n ((n/d) % n) = n / (n/d) = d`). `K d ≤ R`.
* Every subgroup `H ≤ R` is normal: conjugating `r i` gives `r i` or `r (-i) = (r i)⁻¹`.
* Uniqueness: `H ≤ R`, `d := Nat.card H` ⇒ `d ∣ n` and `H = K d`.
  For `r i ∈ H`, `(r i)^d = 1` so `i * d = 0`, so `n ∣ i.val * d`, `n = d * (n/d)` ⇒ `n/d ∣ i.val`,
  so `r i ∈ K d`. Then `H ≤ K d`, equal cards ⇒ equal.
* n odd: a normal `H` with a reflection `sr i` contains `sr i * (r j * sr i * r j⁻¹) = r (-2j)`
  for every `j`; 2 is invertible mod n (`2 * ((n+1)/2) = n+1`), so all rotations, hence all of G.
  So normal subgroups = `insert ⊤ (n.divisors.image K)`; `K` injective on divisors (cards),
  `⊤` not in the image (card 2n > d). Sum = `2n + σ(n)`. Leinster ⇔ `σ(n) = 2n` ⇔ perfect.
* n even: the extra normal subgroup `Q := ker φ`, `φ : D_n →* Multiplicative (ZMod 2)`,
  `φ (r i) = cast i`, `φ (sr i) = cast i + 1` (a hom because 2 ∣ n). φ surjective ⇒ index 2 ⇒
  `Nat.card Q = n`. `sr 1 ∈ Q`, so `Q ∉ insert ⊤ (image K)` (`sr 0 ∉ Q`, `Q ⊄ R`).
  Sum ≥ `n + 2n + σ(n) ≥ 3n + (n + 1) > 4n` (`1 ≠ n` both divisors since n ≥ 2). So not Leinster.
* n = 1: D_1 ≅ C_2, sum = 1 + 2 = 3 ≠ 4, 1 not perfect: consistent (odd branch: σ(1) = 1 ≠ 2).
  n = 2: Klein four, sum = 1 + 3·2 + 4 = 11 ≠ 8: consistent (even branch).

## Plan

Single file `Solution.lean` (no heavy kernel checks). Lemmas, in order:
`mem_R`, `card_R`, `card_K`, `K_le_R`, `normal_of_le_R`, `eq_K_of_le_R`, `dvd_of_le_R`,
`eq_top_of_normal_of_odd`, `normals_odd` (Finset characterisation), `sum_odd`,
`phi`, `card_Q`, `sum_even_gt`, main theorem.

## Status

- All lemmas of the plan proved in `Solution.lean`; `lake build Solution` passes with no warnings.
- `#print axioms dihedral_leinster_iff`: `propext`, `Classical.choice`, `Quot.sound`.
- `type_of% @dihedral_leinster_iff = type_of% @LeinsterGroup.dihedral_is_leinster_iff_odd_perfect` by `rfl`.
- No `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by`, `unsafe` in `Solution.lean`.
- No kernel-heavy steps: only small `decide` checks over `ZMod 2`; the build of `Solution` takes about 10 s.

## Submission state (2026-10-04)

- Submit commit: `4717d112ed9fc5d5e26f6821dc12ea9090fe9b6d` (`submit(dihedral): ...`), pushed to `run/dihedral`.
- The checker is paused today, so per instruction the `comparator/dihedral` status was not polled.
  No verdict is known yet. Next session: read
  `gh api repos/danielpuri1901/erdos-lean-formalization/commits/4717d112ed9fc5d5e26f6821dc12ea9090fe9b6d/status`
  and, on failure, fix and resubmit.
- What is proved: the full theorem `dihedral_leinster_iff`, with no gaps (see Status above).
  What is missing: only the external checker verdict.
- Work time: about 25 minutes, within the 30 minute budget.
