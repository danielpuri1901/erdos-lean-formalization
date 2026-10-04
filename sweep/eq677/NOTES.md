# eq677 sweep notes

start: 1791105215 (date -u +%s), 2026-10-04 09:13 UTC

## Phase A: statement

Lean source: `FormalConjectures/Other/EquationalTheories_677_255.lean`, theorem
`Finite.Equation677_implies_Equation255`:

    answer(sorry) ↔ ∀ (G : Type) (_ : Magma G), Finite G → Equation677 G → Equation255 G

Definitions (read from the Lean source):
- `class Magma (α : Type) where op : α → α → α`, written `x ◇ y` (local class, no axioms).
- `Equation677 G := ∀ x y : G, x = y ◇ (x ◇ ((y ◇ x) ◇ y))`
- `Equation255 G := ∀ x : G, x = ((x ◇ x) ◇ x) ◇ x`

In words: must every finite magma satisfying x = y(x((yx)y)) also satisfy x = ((xx)x)x?
To answer "no" one exhibits a finite magma with 677 and not 255 (`Fin n` with a table suffices,
since `G : Type`). To answer "yes" one proves the ∀ statement.

Edge cases:
- Empty `G`: both equations hold vacuously; `Finite` holds. No trivial counterexample.
- One element: both hold. No subtraction/division/sInf in the statement.
- Hypotheses are satisfiable (order 1, and nontrivially e.g. Z_5 with x◇y = 2x+4y).

statement check: matches. The Lean statement says exactly what the docstring says
(answer ↔ "677 ⇒ 255 for all finite magmas"). Universe is `Type`, which is no restriction
for finite models. No gap found.

## Basic consequences of 677 (proved on paper)

- 677 says y ◇ (something) = x for every x, so each left multiplication L_y : x ↦ y ◇ x is surjective;
  in a finite magma L_y is a bijection (each row of the table is a permutation).
- Writing R_y for right multiplication, 677 reads x = L_y L_x R_y L_y (x), i.e.
  x ◇ ((y◇x)◇y) = L_y⁻¹(x).

## Linear / affine models (derived on paper; used for search)

Over an abelian group V with endomorphisms A, B (possibly non-commuting matrices) and c ∈ V,
x ◇ y = A x + B y + c:
- 677  ⇔  BA + B²AB = I,  A + B²A² + B³ = 0,  (B²A + B² + B + I) c = 0.
- 255  ⇔  A³ + A²B + AB + B = I  and  (A² + A + I) c = 0.
So a counterexample could come either from the linear part (non-commuting A, B) or from a
constant c in ker(B²A+B²+B+I) \ ker(A²+A+I).

Translation-invariant models over a group H: x ◇ y = x · f(x⁻¹ y) with f : H → H arbitrary.
Left translations are automorphisms, so it suffices to check y = e:
- 677 ⇔ ∀x: x = f( x⁻¹ · ... ) (computed in code, see search code).
- 255 ⇔ check at x = e only.
