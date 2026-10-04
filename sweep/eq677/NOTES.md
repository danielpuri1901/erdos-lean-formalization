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

## Phase A: reproduction (sweep/eq677/bt.c)

C backtracking over full tables, rows forced to be permutations (sound: L_y is bijective in a
finite 677 magma), with propagation "if y◇(x◇((y◇x)◇y)) is determined except the last product,
force it to x". No symmetry breaking, labeled counts:

| n | nodes | labeled 677 models | failing 255 |
|---|-------|--------------------|-------------|
| 1 | 1 | 1 | 0 |
| 2 | 7 | 0 | 0 |
| 3 | 49 | 0 | 0 |
| 4 | 1392 | 0 | 0 |
| 5 | 112730 | 6 (one iso class: 120/6 = 20 = |AGL(1,5)|, the Z_5 model 2x+4y) | 0 |
| 6 | 50854259 | 0 | 0 |

Matches the problem file (orders 2-4 empty) and extends it: order 5 and order 6 are now
exhaustive (order 6 has no 677 model at all). Not a proof; computer only.

## Phase B: structured counterexample searches (all found nothing)

1. Translation-invariant models x◇y = x·f(x⁻¹y) over a group H, f a permutation of H
   (sweep/eq677/ti.c, groups from groups.py), exhaustive in f:
   C5..C13 (models only at C5: 1, C11: 4), C2², C2³, C3², C2×C4, D6, D8, Q8, D10, A4, D12, C2×C6.
   All 677 models found satisfy 255.
2. Affine models x◇y = Ax + By + c over F_p^k with A, B arbitrary k×k matrices
   (non-commuting allowed) and c any vector (sweep/eq677/matlin.py). B runs over rational canonical
   forms (conjugation is an isomorphism); A solved from the linear equation BA + B²AB = I; then
   A + B²A² + B³ = 0 checked; then 255 checked for the linear part and for every c in
   ker(B²A+B²+B+I). Exhaustive for:
   k=1: p = 2,3,5,7,11,13; k=2: p = 2,3,5,7,11; k=3: p = 2,3,5,7,11,13;
   k=4: p = 2,3 (complete), p=5 (all B except 5 with solution space of dim > 6);
   k=5: p = 2 (complete), p=3 (all B except 2 with dim > 8); k=6: p=2 (all B except 2 with dim > 12).
   677 solutions found exist at orders 5,7,9,11,13,16,25,49,81,121,125,343,625,1331,2197;
   every one satisfies 255 (linear part and all admissible constants).

## Phase C: proved special case (affine over commutative rings)

Plain proof. Let R be a commutative ring and x◇y = a x + b y + c. Expanding,
y◇(x◇((y◇x)◇y)) = (ab + ab³) x + (a + a²b² + b³) y + K c with K = ab² + b² + b + 1, and
((x◇x)◇x)◇x = T x + H c with T = a³ + a²b + ab + b, H = a² + a + 1.
677 at (x,y) = (0,0), (1,0), (0,1) gives K c = 0, g1 = 0, g2 = 0 where g1 = ab + ab³ − 1,
g2 = a + a²b² + b³. Integer certificates (found by bounded-degree linear algebra, ideal.py,
ideal2.py, then checked by Lean's `ring`):
  T − 1 = (1 − b − ab² − a² − a³b) g1 + (−a + ab + a² + a²b²) g2,
  H     = (−a + ab + a² + a²b²) K + (−1 − 2a − ab − a²b) g1.
Hence T = 1 and H c = 0, i.e. 255 holds.
Lean: `Solution.lean`, `Eq677Sweep.affine_eq677_imp_eq255` (axioms: propext, Quot.sound only).
This covers every affine model over every Z_n (so the problem file's 501 linear Z_n models
and any larger n), and over every commutative ring, finite or not.

## Phase C (cont.): non-commuting affine models (paper analysis, partly computer-checked)

Over any ring with B invertible (automatic for a finite magma, since L_y is x ↦ Bx + const),
677's linear relations g1: BA + B²AB = 1, g2: A + B²A² + B³ = 0 give (derived by hand, each
step re-checked):
- AB = B⁻² − B⁻¹A,  AB⁻¹ = B⁻² − BA,  A² = −B⁻²A − B;
- computing A²B in two ways yields (★) q(B)·(B(B²+1)A − 1) = 0 with q(t) = t³ − t − 1.
So if q(B) is invertible, A = (B³+B)⁻¹ commutes with B and the commutative certificate gives 255.
Computer: every 677 solution (A, B) found in the F_p^k search above has AB = BA.
Non-commuting solutions therefore need an eigenvalue λ of B with q(λ) = 0.
Block analysis (B diagonalizable, eigenvalues λ and μ = −1/λ, λ² ≠ −1): A's diagonal blocks are
forced to α_λ = 1/(λ³+λ); off-diagonal blocks E (λ←μ), F (μ←λ) need q(λ) = 0 (resp. q(μ) = 0) and
EF = s_λ I, FE = s_μ I with s_b = −(α_b + b²α_b² + b³)/b². In Q(λ) (λ³ = λ+1):
s_λ − s_μ = −λ − λ², norm −1 (a unit, so never 0 in any characteristic), N(s_λ) = −11/25,
N(s_μ) = 19/25 (never both 0). Hence no such 2-eigenvalue non-commuting model exists in any
characteristic (numfield.py; block2.py confirms numerically for all p < 200 with q split-root in F_p).
Not covered: λ² = −1 (e.g. char 5, λ = 2), non-semisimple B, several interacting eigenvalue pairs,
coefficient rings that are not fields (Z_{p^k}).
