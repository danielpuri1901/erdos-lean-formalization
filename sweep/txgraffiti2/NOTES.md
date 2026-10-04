# txgraffiti2 sweep notes

```
result: partial
claim: (1) For every connected finite graph G (no degree bound) with n >= 2,
  Z(G) <= n - 1; hence Z(G) <= α(G) + 1 whenever n <= α(G) + 2.
  (2) The K4 exclusion is necessary: K4 is connected, maxDegree K4 <= 3 and α(K4)+1 = 2 < 3 = Z(K4).
  (3) The bound is attained by a cubic graph other than K4: the triangular prism K3□K2
  meets every hypothesis and has Z = 3 = α + 1.
lean: Solution.lean (builds, no sorry; axioms only propext, Classical.choice, Quot.sound):
  Txg2.zf_le_card, Txg2.bound_of_certificate, Txg2.step_mono, Txg2.closure_mono,
  Txg2.erase_forcing, Txg2.zf_le_card_sub_one, Txg2.bound_of_card_le_indepNum_add_two,
  Txg2.K4_violates, Txg2.prism_tight (+ helper lemmas K4_*, prism_*).
computed: Z(G) <= α(G)+1 holds (K4 the only exception) for EVERY connected subcubic graph
  on n <= 17 vertices (exhaustive generator bfsgen.c, validated against known class counts
  for n <= 8) and every connected cubic graph on n <= 18; random cubic graphs n = 12..30
  (2e6 each), random subcubic n = 9..28, 575 structured graphs (generalized Petersen m <= 32,
  Möbius ladders, cages, snarks J3..J15, truncations), hill-climbing n = 12..20.
  Best Z − α found anywhere is 1 (tight); never 2.
next idea: Minimal-counterexample reduction. Data say no tight graph (Z = α+1) has a
  vertex of degree <= 2 lying in every maximum independent set (labelled n <= 8 exhaustive,
  random to n = 18); conversely such a vertex would give a counterexample by bridging two
  copies (needs the edge-spread lemma |Z(G) − Z(G−e)| <= 1). Proving "a minimal
  counterexample is cubic and 3-connected" via deletion of a degree-<=2 vertex plus this
  essential-vertex dichotomy looks like the most promising structural route; then attack
  cubic graphs with α near n/3 (they contain many triangles/diamonds) separately.
dead ends: Brooks (α >= n/3) + any bound of the form Z <= n/3 + c fails (K3,3, Petersen, and
  a cubic n=16 graph with Z = 8). Random sampling at n >= 22 finds no tight graphs, so
  random search for counterexamples at large n is hopeless; high-Z tight graphs come only
  from hill-climbing and all have α = Z − 1. Lean: kernel `decide` over zero forcing
  closures on Fin 10 (Petersen) runs out of memory (> 13 GB) even split into 84/126-set
  chunks; Fin 6 is fine. Exhaustive cubic n = 20 (est. 1.5e9 labellings) did not finish in 25 min.
confidence: high because every Lean claim builds with no sorry and only standard axioms,
  and the exhaustive generator reproduces the known class counts 1,1,2,5(+K4),10,29,64,194;
  the full conjecture is NOT claimed.
```


start: 1791105004 (date -u +%s)

## Phase A: understanding

Statement (own words): V finite with decidable equality, G a simple graph on V,
G connected (so V nonempty), maxDegree G <= 3, and "if G = ⊤ then card V ≠ 4"
(i.e. G is not K4).  Then zeroForcingNumber G <= indepNum G + 1.

Definitions, read from `FormalConjectures/Arxiv/2507.17780/2.lean`:
- `zeroForcingStep G S = S ∪ {w ∉ S | ∃ v ∈ S, Adj v w ∧ ∀ u, Adj v u → u ∉ S → u = w}`
  (simultaneous colour-change rule: every black v with exactly one white neighbour w forces w).
- `zeroForcingClosure G S = (zeroForcingStep G)^[card V] S`.
  The step is inflationary; if it does not stabilise it adds >= 1 vertex, so card V
  iterations reach the true closure. Matches the standard definition.
- `IsZeroForcingSet G S := zeroForcingClosure G S = univ`.
- `zeroForcingNumber G = sInf {k | ∃ S, S.card = k ∧ IsZeroForcingSet G S}`;
  univ is forcing, so the set is nonempty and sInf is a true minimum.
- `G.indepNum` (Mathlib) = sSup {n | ∃ s, G.IsNIndepSet n s}, bounded by card V.
- `G.maxDegree` (Mathlib) = max of degrees (0 for empty V; irrelevant since connected).

Edge cases:
- empty V: excluded by `Connected` (needs Nonempty).
- K1: Z=1, α=1. K2: Z=1, α=1. K3 (= ⊤ with card 3, allowed): Z=2, α=1, 2<=2 tight.
- K4: Z=3, α=1 — excluded by `_hNotK4` exactly (⊤ with card 4 is K4; ⊤ on 4 vertices has max degree 3).
- No ℕ subtraction/division. sInf over a nonempty set; sSup over a bounded set.
- Hypotheses are satisfiable (e.g. paths), so not vacuous.
- Monotonicity: superset of a forcing set is forcing (closure is monotone in S), so
  Z <= k iff some k-set forces. Used in the search code.

statement check: matches (Lean = docstring = standard Z(G) <= α(G)+1 for connected
subcubic G ≠ K4).

Reproduction (own code):
- `zf.c` (bitmask C; closure by repeated forcing, α by branching) mode `all n`: all
  labelled connected subcubic graphs on n vertices.
- `check.py` (independent Python; follows the Lean definitions literally: step iterated
  card V times, Z by increasing k, α by brute force), labelled + isomorphism classes.
- Results (labelled count / tight Z=α+1 / failures):
  n=1: 1/0/0, n=2: 1/0/0, n=3: 4/1/0, n=4: 38/0/1 (the 1 failure is K4),
  n=5: 472/30/0, n=6: 7540/340/0 — Python and C agree exactly.
  C only: n=7: 150930 labelled, 630 tight, 0 failures.
- Isomorphism classes (Python, n<=6): 1,1,2,6,10,29; 6 at n=4 includes K4, so 5 without.
  Matches the problem file's 1,1,2,5,10,29.

## Phase B: counterexample search (all code in this directory)

Tools (both checked against the Python reference `check.py` and on known graphs:
Petersen Z=5 α=4, K3,3 Z=4 α=3, cube Q3 Z=4 α=4, prism Z=3 α=2):
- `zf.c`: bitmask C. Tests "some (α+1)-set forces" (monotonicity: Z <= k iff some
  k-set forces), exact Z, random (sub)cubic graphs, hill-climbing, graph6 input.
- `bfsgen.c`: exhaustive generator of connected subcubic graphs up to isomorphism
  *with repetitions*. Every connected graph has a BFS labelling from a max-degree root
  with each sibling group sorted by nonincreasing degree; the generator emits exactly
  such labellings (parent(w) = min N(w), nondecreasing). Validated: isomorphism-class
  counts of its output (Python canonical forms) are 1,1,2,5(+K4),10,29,64,194 for
  n=1..8, and cubic 2,5 for n=6,8 — all match known counts / the problem file.
- `fam.py` + `g6.py`: structured families as graph6.

Results (Z <= α+1 checked for every graph; K4 is the only failure ever seen):
- Exhaustive, all connected subcubic graphs (labellings generated / failures):
  n=8: 1306/0, n=9: 5756/0, n=10: 26545/0, n=11: 124136/0, n=12: 600739/0,
  n=13: 2964755/0, n=14: 15052264/0, n=15: 78039866/0  (n=16, cubic n=18: see below)
- Exhaustive cubic only: n=4..16: 1, 5, 50, 639, 9609, 167234, 3311918 labellings, 0 failures
  (n=4 the 1 is K4, skipped).
- Labelled exhaustive (`zf all n`), every labelled connected subcubic graph:
  n<=7 (150930 at n=7) and n=8: 3675000 graphs, 28560 tight, 0 failures.
- Random cubic (configuration model, seed 7): 2,000,000 samples each at
  n=12,14,16,18,20,22,24,26,28,30: 0 failures (tight counts 14868, 2121, 104, 7, 2, 0, ...).
  n>=32 runs hit the 40 s timeout before printing; treat as not run.
- Random subcubic (random cubic, each edge deleted with prob p, kept if connected;
  odd n: one degree-2 vertex): p in {0.05,0.1,0.2,0.3} x n in {11..16,18,..,28},
  ~1e5–3e5 samples each; and p in {0,0.03,0.08,0.15,0.25} x n=9..18, 4e5 samples each:
  0 failures.
- Structured families (575 graphs): GP(m,k) for 3<=m<=32, Möbius ladders 2m<=64,
  Heawood, McGee, Tutte 8-cage, F26A, Franklin, Frucht, Dyck, Gray, Pappus, Desargues,
  Nauru, flower snarks J3..J15, truncations of 14 named cubic graphs and of 270 random
  cubic graphs (claw-free cubic graphs): 0 failures. (The one "FAIL" was K4 = Möbius
  ladder on 4 vertices.) Tight ones: prism, Petersen, K3,3, Möbius ladder V8,
  GP(7,2), GP(7,3). No truncation was tight.
- Hill-climbing over cubic graphs (double-edge swaps, objective Z−α, exact Z):
  n=12..20: best Z−α = 1 everywhere. Tight graphs with large Z exist, e.g.
  n=16, Z=8, α=7 (6 triangles), n=18 Z=8 α=7, n=20 Z=9 α=8 (Python re-check of
  n=16, 18 agrees). Edge lists in `tight_climb.txt`.

Gadget observation (paper argument, uses the edge-spread fact |Z(G)−Z(G−e)| <= 1,
from memory, unverified): if a connected subcubic H ≠ K4 had Z(H) = α(H)+1 and a
vertex u of degree <= 2 lying in every maximum independent set, then two copies of H
joined by the edge u–u' would have α = 2α(H)−1 and Z >= 2Z(H)−1 = 2α(H)+1, so
Z−α >= 2: a counterexample. Search for such H: none among all labelled graphs n<=8 and
none in the random subcubic runs above (counter `ess=0`). So the conjecture implies
"no tight graph has an essential vertex of degree <= 2"; this is consistent with data.

Later Phase B results:
- Exhaustive all connected subcubic n=16: 414,762,605 labellings, 0 failures (354 s).
- Exhaustive cubic n=18: 73,564,450 labellings, 0 failures (159 s).
- `climb2` (objective 4(Z−α)+Z, pushes Z up): n=14 found Z=7, α=6 (Z = n/2);
  n=16 Z=8, α=7. Every high-Z graph found had α = Z−1 exactly.

## Phase C: proof attempt

Decision: the full conjecture is out of reach in this session (open since 2017; no
proof idea survived — see below). I formalized what I can prove completely:

Paper arguments (all proved on paper, all formalized in `Solution.lean`):
1. (certificate) If S is forcing and I independent with |S| <= |I|+1 then Z <= α+1.
   Proof: Z <= |S| (sInf), |I| <= α.
2. (Z <= n−1) If G connected, n >= 2: pick an edge vw (first edge of a walk between
   two distinct vertices). In S = V∖{w}, v is black and w is its only white neighbour,
   so one step gives V; V is fixed by the step, so card V >= 1 iterations give V.
3. (special case) If n <= α+2 then Z <= α+1: for n >= 2 use (2); for n = 1, Z <= |V| = 1.
4. (K4 sharpness) K4 is connected with maxDegree 3, every forcing set of K4 has >= 3
   vertices and every independent set <= 1 vertex (both by `decide +kernel` over all 16
   subsets, the definitions reduce in the kernel), so α+1 = 2 < 3 = Z.

Ideas considered for the full statement (status):
- Brooks: α >= n/3 for connected subcubic G ≠ K4 (known, from memory). Then
  Z <= n/3 + 1 would suffice, but it is false (K3,3: Z=4 > 3; Petersen: Z=5 > 4.33;
  climb found cubic n=16 with Z=8). Dead end.
- Z <= (n+2)/2 for connected subcubic (Amos–Caro–Davila–Pepper, from memory,
  unverified) gives the conjecture whenever α >= n/2 (e.g. bipartite). Not formalized:
  I do not remember that proof.
- Gadget reduction (Phase B): a tight graph with an essential vertex of degree <= 2
  would give a counterexample via a bridge. Plausible, depends on edge spread lemma.

Final Phase B additions:
- Exhaustive all connected subcubic n=17, split in 3 parts by a counter at depth 5
  (split checked at n=13: 989021+891228+1084506 = 2964755 = unsplit count):
  parts 842,430,025 + 624,264,296 + 783,589,574 = 2,250,283,895 labellings, 0 failures.
- Exhaustive cubic n=20 started with a 25-minute limit; not expected to finish
  (estimate ~1.5e9 labellings). Not claimed.

Lean decisions:
- Petersen tightness was attempted first; the kernel `decide` over its zero forcing
  closures ran out of memory (killed at 13.5 GB), even after reducing to four-element
  sets via `closure_mono` and splitting into 84 + 126 sets. Replaced by the 6-vertex prism,
  which proves the same qualitative fact (bound attained by a cubic graph ≠ K4).
- `#print axioms` on bound_of_card_le_indepNum_add_two, K4_violates, prism_tight:
  [propext, Classical.choice, Quot.sound] only.

end: 1791106916 (about 32 minutes after start)
