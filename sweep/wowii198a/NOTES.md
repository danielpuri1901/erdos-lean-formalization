# wowii198a sweep notes

start: 1791105072 (date -u +%s)

## Phase A: statement

Lean (`conjecture198a`): `α` a Fintype with DecidableEq and Nontrivial (so n = |α| ≥ 2).
For `G : SimpleGraph α` with `G.Connected` and `b G ≤ 2 + averageEccentricity G`
there exist `a b : α` and a walk `p : G.Walk a b` with `p.IsHamiltonian`.

Definitions as read from the Lean source:
- `b G : ℝ := (largestInducedBipartiteSubgraphSize G : ℝ)`, where
  `largestInducedBipartiteSubgraphSize G := sSup {n | ∃ s : Finset α, (G.induce s).IsBipartite ∧ s.card = n}`
  (FormalConjecturesForMathlib/Combinatorics/SimpleGraph/Induced.lean). The set is nonempty (∅) and
  bounded by `card α`, so the sSup is a genuine max. A bridge lemma to a computable version exists:
  `largestInducedBipartiteSubgraphSize_eq_computable`.
- `averageEccentricity G : ℝ := (∑ v, (G.eccent v).toNat) / card α`
  (FormalConjecturesForMathlib/Combinatorics/SimpleGraph/Eccentricity.lean). `eccent v : ℕ∞`; for a
  connected finite graph it is finite, so `toNat` is the true eccentricity. card α ≥ 2 > 0, no division by 0.
- `Walk.IsHamiltonian p := ∀ a, p.support.count a = 1` (Mathlib): every vertex occurs exactly once
  in the support, i.e. a Hamiltonian path (not cycle).
- Name check: inside the theorem `∃ a b : α` binds a vertex `b` only in the conclusion; `hb` uses `SimpleGraph.b`.

Edge cases:
- empty type / one vertex: excluded by `Nontrivial`.
- disconnected graphs: excluded by `h` (and there `toNat ⊤ = 0` would be junk, but irrelevant).
- sSup: the set always contains 0 and is bounded by n, so no junk value.
- division: card α ≥ 2.

Red team:
- b(G) ≥ 2 always (any two vertices induce a bipartite graph). b(G) ≥ diam+1 (a geodesic is an induced path).
  avgEcc ≤ diam. So the hypothesis forces diam+1 ≤ b ≤ 2+avgEcc ≤ 2+diam: very restrictive, but satisfiable
  (K_n: b=2, avgEcc=1; C_5: b=4, avgEcc=2). Not vacuous, not trivially false.
- statement check: matches (Lean statement = docstring = Graffiti claim).

## Phase B: computation (all exact, C, labeled graphs; `sweep/wowii198a/check.c`, `sc.c`)

- `./check exh n 1` enumerates ALL labeled graphs on n vertices (2^(n(n-1)/2)), keeps connected ones,
  computes eccentricities by BFS, b exactly (hypothesis b <= floor((2n+Σecc)/n) checked by testing all
  subsets of size floor(..)+1 for bipartiteness), and Hamiltonian path by bitmask DP.
  Results (labeled graphs, counts are labeled graphs satisfying the hypothesis):
  - n=2..7: sat = 1, 4, 34, 403, 6736, 142881; counterexamples 0.
  - Claim A (below) verified: 0 violations for n<=7.
  - Every self-centered (all ecc equal) graph satisfying the hypothesis has diam <= 2 for n<=7.
  - n=8: run started in background (`exh8.log`), see report block for the outcome.
  (I did not reproduce the iso-class count 516; my counts are labeled. Decision: labeled exhaustive check
  is strictly stronger for n<=7, so I skipped canonical forms.)
- `./sc n p count seed`: random G(n,p) graphs, keep self-centered ones with diam D >= 3, test b >= D+3.
  n=10, p in {20,25,30,35}%, 200000 samples each: 206+643+1157+1193 self-centered D>=3 graphs, ALL have b >= D+3
  (so none satisfies the hypothesis).

## Phase C: paper argument

Notation: n>=2, G connected, D = diam, e(v) = ecc. For a root u, L_i(u) = {x : dist(u,x)=i}, i=0..e(u).
(F1) every x in L_i, i>=1, has a neighbour in L_{i-1} (so ancestor chains exist);
(F2) every edge joins two vertices in the same layer or in consecutive layers.

Lemma 1 (proved). For every root u: b >= Σ_i α(G[L_i(u)]).
  Pick a maximum independent set I_i in each layer, S = ∪ I_i, colour x in S by parity of dist(u,x).
  An edge inside S is not inside a layer (I_i independent), so by (F2) it joins consecutive layers,
  i.e. different colours. So G[S] is bipartite.
Lemma 2 (proved). b >= α+1 (n>=2, connected), b >= D+1, avgEcc <= D with equality iff self-centered.
Lemma 3 (proved). If some root u has every layer L_i(u) a clique, G has a Hamiltonian path starting at u.
  Induction downward on j: G[L_j ∪ ... ∪ L_e] has a Ham path starting in L_j. j=e: L_e is a clique.
  Step: given a Ham path of G[L_{>=j}] starting at s in L_j, by (F1) pick w in L_{j-1} adjacent to s;
  list L_{j-1} \ {w} in any order, then w, then the path (L_{j-1} is a clique). j=0 gives the claim.

Theorem A (proved on paper). If G is NOT self-centered and satisfies the hypothesis, G has a Ham path.
  avgEcc < D, and b is an integer, so b <= D+1. Take u with e(u)=D. There are D+1 nonempty layers, each
  with α >= 1, and by Lemma 1 their α's sum to <= D+1, so every layer is a clique. Lemma 3 finishes.

So a counterexample must be self-centered (all ecc = D), with b <= D+2, and (Lemma 1 + Lemma 3) every root
must have exactly one layer with α = 2, all other layers cliques. Call that layer index k(u) >= 1.

Theorem B1 (D=1): G complete, trivially traceable.
Theorem B2 (D=2, uses a theorem from memory, unverified): self-centered D=2 with b<=4 gives α <= 3 (Lemma 2).
  A cut vertex w in a diameter-2 graph is adjacent to every other vertex (vertices in different components
  of G-w are at distance 2 only through w), so e(w)=1, contradicting self-centered; hence κ >= 2.
  Chvátal–Erdős (1972, from memory, unverified): κ(H) >= α(H), |H|>=3 ⇒ H Hamiltonian. Apply to H = G + a
  universal vertex: κ(H)=κ(G)+1 >= 3 >= α(G) = α(H), so H has a Ham cycle; deleting the added vertex gives
  a Ham path of G.
Lemma 4 (proved; eccentricity bounds). Root u, w in L_j with L_j a clique, z in L_i:
  (a) i >= j: dist(w,z) <= i-j+1 (ancestor of z in L_j);  (b) i<j, L_i clique: <= j-i+1; i=0: = j;
  (c) any i<j: <= i+j (through u);  (d) i<j, L_{i-1} clique: <= j-i+3.
Theorem B3 (proved). Self-centered, D>=3, b<=D+2, no all-clique root. Then for every root u:
  k(u) >= 3 is impossible (w in L_2: ecc <= max(2, D-1) = D-1 < D);
  k(u) = 1 forces D = 3 (w in L_2: ecc <= max(3, D-1));
  k(u) = 2 forces D <= 4 (w in L_3: ecc <= max(4, D-2)).
  So the only open sub-cases are D=3 (all k(u) in {1,2}) and D=4 (all k(u)=2).
