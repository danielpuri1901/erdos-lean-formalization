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

### Correction and completion of the non-commuting analysis (paper proof, computer-checked ingredients)

Λ = Z⟨A, B, B⁻¹⟩ / (g1, g2). Rewriting rules valid in Λ (each derived by one multiplication by B⁻¹):
  AB = B⁻² − B⁻¹A,  AB⁻¹ = B⁻² − BA,  A² = −B⁻²A − B.
rewrite.py (independent code, Laurent polynomials over Q) confirms:
  (★)  (AA)B − A(AB) = −B⁻⁴ q(B) (B(B²+1)A − 1), so q(B)(B(B²+1)A − 1) = 0, q = t³ − t − 1;
  (★★) B(B²+1)·(★')·A + (1 + B + B⁻¹)·(★') = −B⁻¹ q(B) o(B), so q(B) o(B) = 0,
       where (★') = −q + qB(B²+1)A and o = t⁸ + 2t⁶ + t⁴ + t² + t + 1 (the commutative octic).
Norms in Z[λ], λ³ = λ + 1, μ = −1/λ (numfield.py, norms.py):
  N(o(λ)) = 11, N(o(μ)) = 19, N(q(μ)) = −5, N(λ² + 1) = 5, disc(q) = −23.
exceptional.py lists, for p ∈ {5, 11, 19, 23}, each q-root λ ∈ F̄_p and q'(λ), o(λ), q(μ), o(μ), λ²+1.

Theorem (paper). Let V be a finite-dimensional vector space over a field F, A, B ∈ End(V), c ∈ V,
and x◇y = Ax + By + c satisfy 677. Then AB = BA, and hence (by the Lean module theorem with
R = F[A, B] commutative) the magma satisfies 255.
Proof. B is invertible (B(A + BAB) = I). Pass to F̄ and split V = ⊕ V_ν (generalized eigenspaces of B).
(1) From AB + B⁻¹A = B⁻² (block form, Sylvester): the block A_{νλ}: V_λ → V_ν is 0 unless ν = λ or
    νλ = −1; if λ² ≠ −1 then A_{λλ} = (B_λ³ + B_λ)⁻¹, a polynomial in B_λ.
(2) Let λ be an eigenvalue with q(λ) = 0 and μ = −1/λ.
    (a) λ² = −1 forces char 5, λ = 2 (q(λ) = −2λ − 1 when λ² = −1). Then μ = λ, so V_2 is
        A-invariant; λ is a simple root of q·o (q'(2) = 1, o(2) = 2 mod 5), so by (★★) B = 2 on V_2;
        g1 on V_2 reads 10A = I, impossible. So V_2 = 0.
    (b) μ not an eigenvalue: V_λ is A-invariant and A commutes with B on it by (1).
    (c) μ an eigenvalue: q(μ)o(μ) = 0 by (★★). q(μ) = 0 only in char 5 (where it is case (a));
        o(μ) = 0 only in char 19 (λ = 6, μ = 3). There λ is a simple root of q·o, so B = λ on V_λ;
        (1) gives A_λλ = α, A_μμ = (B_μ³+B_μ)⁻¹, F := A_{μλ} has image in ker(B_μ − μ);
        the (μ,λ) block of g2 gives (1 + μ²(α + α'))F = −q(μ)F = 0 so F = 0; then the (λ,λ) block of g2
        gives c_λ := α + λ²α² + λ³ = 0, but c_λ = −λ² s_λ with N(s_λ) = −11/25, nonzero mod 19.
        So this case is empty.
(3) So V = (⊕ over q-root eigenvalues V_λ) ⊕ W, all A-invariant, A commutes with B on each V_λ,
    and q(B) is invertible on W, where (★) gives B(B²+1)A = I, so A = (B³+B)⁻¹ commutes with B.
Status: each step proved on paper; the norm values and exceptional-prime table are computer output;
(★), (★★) checked by rewrite.py. Not formalized. Confidence medium-high.
Not covered: affine models on abelian groups that are not elementary abelian (e.g. Z_{p²}^k) with
non-commuting A, B (commuting ones are covered by the Lean theorem).

Search support: char-5 Jordan blocks at eigenvalue 2 (char5.py): only even block sizes admit a
solution of g1; for k ≤ 4 none satisfies g2 (as the proof predicts).

## Phase B (cont.): cocycle extensions (ext.py, extc.c, batch.py)

(x,a)◇(y,b) = (x◇y, αa + βb + θ(x,y)) over a 677 base M, fiber F_p, (α,β) a commutative linear
677 solution mod p, θ: M×M → F_p arbitrary. 677 is linear in θ; 255 failure is a linear functional.
- Level 1: bases = all linear Z_q models, q ∈ {5,7,11,13}; fibers = all (p, α, β), p ∈ {5,7,11,13}:
  72 cases (Python) and the same in C; cocycle spaces often exceed coboundaries (genuinely new
  677 models, e.g. order 35, 55, 77, 65), but every cocycle satisfies 255.
- Level 2: random non-trivial extensions of order ≤ 70 as bases, extended again by every fiber:
  every cocycle satisfies 255 (see batch.log).
