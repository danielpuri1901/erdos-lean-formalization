# wowii100 notes

start: 1791105214 (date -u +%s)

## Phase A: statement

Lean (`FormalConjectures/WrittenOnTheWallII/GraphConjecture100.lean`, `conjecture100`):
for a finite type `V` with `DecidableEq`, `Nontrivial` (so n >= 2), and a connected
simple graph `G` on `V`,

    (indepNum G : ℝ) ≤ ⌈(maxL + (1/2) * degreeL2Norm Gᶜ) / 2⌉

Definitions, read from the Lean source:
- `G.indepNum` = sSup of sizes of independent finsets (Mathlib).
- `indepNeighborsCard G v = (G.induce (G.neighborSet v)).indepNum`
  (FormalConjecturesForMathlib/Combinatorics/SimpleGraph/Independence.lean).
- `maxL = (univ.image (indepNeighborsCard G)).max' _`: the maximum over v.
- `degreeL2Norm H = Real.sqrt (∑ v, (H.degree v : ℝ)^2)` (Degrees.lean); applied to `Gᶜ`,
  whose degree is n-1-deg_G(v).
- `⌈·⌉` is `Int.ceil` on ℝ, cast back to ℝ.

Own words: alpha(G) <= ceil((m + sqrt(S)/2)/2), m = max_v alpha(G[N(v)]),
S = sum_v (n-1-deg v)^2. Since alpha is an integer, this is equivalent
(Int.le_ceil_iff) to  m + sqrt(S)/2 > 2*alpha - 2.

Edge cases:
- empty type / one vertex: excluded by `Nontrivial`. `max'` is over a nonempty image.
- n >= 2 and connected => every vertex has a neighbour => m >= 1.
- complete graph K_n: alpha = 1, S = 0, m = 1: RHS = ceil(1/2) = 1. Holds, tight.
- No natural subtraction in the Lean statement (degree of Gᶜ is a Mathlib degree, all real).

statement check: matches (docstring and Lean agree; Lean uses the complement, as the
docstring says the WOWII source intends).

Small cases (sweep/wowii100/check.py, own code, exact integer test S > 4 t^2 with
t = 2 alpha - 2 - m):
- all 27,475 labelled connected graphs on 2..6 vertices: 0 failures.
- unlabelled connected counts 1, 2, 6, 21, 112 for n = 2..6 (matches the known counts);
  tight cases (alpha = RHS): 1, 2, 6, 19, 64.
- The problem file's "784 of 12,112 tight for n <= 8" was not re-derived (no nauty/geng
  on the machine, and canonical forms by brute force are too slow for n = 7, 8 in Python).
  Decision: accept the 0-failure part as reproduced up to n = 6, move on.
- 20,000 random connected graphs, n = 7..16 (spanning tree + G(n,p), p in
  {0.1,...,0.9}): 0 failures.

## Phase B / C: the conjecture looks true for a simple reason

The square root of S is large: every vertex of a maximum independent set I has
complement degree >= alpha - 1, so S >= alpha (alpha-1)^2 and sqrt(S)/2 grows like
alpha^{3/2}/2, while the target 2 alpha - 2 - m is linear. A counting argument handles
small alpha too. Decision: skip the counterexample search (Phase B) and spend the time
on the proof, since the paper proof below covers every graph.

### Paper proof

Notation: n = |V| >= 2, G connected. A = alpha(G), I a maximum independent set (|I| = A),
R = V \ I, K = |R|. c(v) = deg_{Gᶜ}(v). m = maxL. S = sum_v c(v)^2.
t = 2A - 2 - m. Goal: m + sqrt(S)/2 > 2A - 2.

If t < 0 the goal holds since sqrt(S) >= 0. Assume t >= 0; the goal follows from S > 4 t^2.

For u in I, w in R let N'(u,w) = 1 if u, w are not adjacent in G, else 0.
D = sum_{u in I} sum_{w in R} N'(u,w).

L1 (proved). For u in I: c(u) >= (A - 1) + sum_{w in R} N'(u,w).
   The Gᶜ-neighbours of u contain I \ {u} (I independent) and the w in R not adjacent
   to u (w != u because w not in I); these two sets are disjoint.
L2 (proved). P := sum_{u in I} c(u) >= A(A-1) + D.   (sum L1 over I)
L3 (proved). For w in R: #{u in I : u ~ w} <= m.
   N(w) ∩ I is independent in G[N(w)], so its size is <= indepNeighborsCard G w <= m.
L4 (proved). D >= K (A - m) when computed as sum over w of (A - #{u in I : u ~ w}),
   i.e. for each w in R: sum_{u in I} N'(u,w) = A - #{u in I : u ~ w} >= A - m.
   (Swap the order of summation: D = sum_{w in R} sum_{u in I} N'(u,w).)
L5 (proved). For u in I: u has a neighbour (connected, n >= 2), it lies in R, so
   sum_{w in R} N'(u,w) <= K - 1. Hence D <= A (K - 1), i.e. A + D <= A K.
L6 (proved). Cauchy–Schwarz: P^2 <= A * S_I, S_I := sum_{u in I} c(u)^2.
L7 (proved). For w in R: c(w) >= sum_{u in I} N'(u,w) (the non-neighbours of w in I are
   Gᶜ-neighbours of w).

Case m >= A. Then t <= A - 2, so A >= 2. By L2, P >= A(A-1), so by L6
S >= S_I >= A (A-1)^2. And A (A-1)^2 > 4 (A-2)^2 >= 4 t^2 for A >= 2
(A = 2: 2 > 0; A = 3: 12 > 4; A >= 4: A (A-1)^2 >= 4 (A-1)^2 > 4 (A-2)^2).

Case m < A. From L4, L5 (as sums over w): sum_{w in R} #{u in I: u ~ w} = A K - D, and
it is <= K m (L3) and >= A (L5). So K m >= A >= 1, hence m >= 1 and K >= 1.
Then
  m P >= m A (A-1) + m D >= m A (A-1) + m K (A - m) >= m A (A-1) + A (A - m)
       = A (m A + A - 2 m) =: A X,  X >= 0,
using m K >= A and A - m >= 0. So m^2 P^2 >= A^2 X^2.
Polynomial lemma (proved): for integers 1 <= m <= A with t = 2A-2-m >= 0,
  A X^2 >= 4 m^2 t^2.
  - A >= 16: A X^2 >= 16 X^2 = 4 (2X)^2 and 2X >= m t >= 0, because
    2X - m t = 2mA + 2A - 4m - 2mA + 2m + m^2 = 2(A - m) + m^2 >= 0.
  - A <= 15: finite check of the 120 pairs (1 <= m <= A <= 15); equality only at
    (A, m) = (4, 2) (checked over A < 3000 in Python as well).
So A m^2 S_I >= m^2 P^2 >= A^2 X^2 >= 4 A m^2 t^2, i.e. S_I >= 4 t^2.
Finally K >= 1 and every w in R has c(w) >= A - m >= 1 (L7 + L4), so
S = S_I + S_R >= S_I + 1 > 4 t^2.

So the conjecture holds for every connected graph with n >= 2.

check.py also verifies every intermediate inequality (L1..L7, the bound m P >= A X)
on all labelled graphs n <= 6 and the random sample: 0 step failures.
