result: partial
claim: Paper proof (not formalized) that conjecture198a holds for every connected graph. The only step not
  re-derived independently is the Chvátal–Erdős theorem (κ >= α ⇒ Hamiltonian), used only for
  self-centered graphs of diameter 2 (Theorem B2). Its classical proof is written out below from memory.
  Elementary, fully written parts: Theorem A (non-self-centered graphs), B1 (D=1), B3 (self-centered,
  D>=5 impossible), B4 (D=3 impossible), B5 (D=4 impossible).
lean: none (Solution.lean only imports the problem module; a sorry-skeleton may follow, see below)
computed: exhaustive over ALL labeled graphs n=2..8 (C, check.c): 0 counterexamples; 4,351,887 labeled
  graphs on 8 vertices satisfy the hypothesis. Claim A (all layers from a peripheral vertex are cliques
  when not self-centered) 0 violations n<=8. Self-centered D>=3 graphs: layer α-sum lemma 0 failures n<=8
  (layer.c); random G(n,p) n=10..16 (sc.c) none with b<=D+2; D=2 sanity (d2.c) n<=7.
next idea: Formalize. Order: (1) Lemma 1 in the weak form "two non-adjacent vertices at equal distance from
  u, plus a geodesic from u of length ecc(u), give an induced bipartite set of size ecc(u)+2" (parity of
  dist(u,.) as the 2-colouring); (2) Lemma 3 (all BFS layers cliques ⇒ Ham path), by downward induction on
  layers building a List with Chain' G.Adj and Nodup, then a Walk; (3) Theorem A; (4) the distance lemmas
  B3–B5 (pure dist reasoning); (5) Chvátal–Erdős (longest cycle argument) for D=2.
dead ends: blind random G(n,p) search never hits the hypothesis for D>=3 (b is far too large); random
  graphs are useless as counterexample candidates. Simulated annealing toward self-centered D in {3,4}
  with small layer sums never succeeded (and B4/B5 now explain why).
confidence: medium because every step is short and elementary and was re-read adversarially once, and all
  intermediate claims were confirmed exhaustively for n<=8, but no second person or Lean has checked it,
  and Chvátal–Erdős is used from memory.

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
  So the only sub-cases left after B3 are D=3 (all k(u) in {1,2}) and D=4 (all k(u)=2). Both are closed below.

Theorem B4 (proved on paper). No self-centered graph with D=3 has b <= 5.
  By B3 every root u has exactly one non-clique layer, at k(u) in {1,2}.
  Case I: some root u has k(u)=1 (L_1 has α=2 with p,q non-adjacent; L_2, L_3 cliques).
    Let Y = vertices of L_1 with a neighbour in L_2 (Y nonempty: parents of L_2).
    I-a: |L_3| >= 2. For x in L_2 and c != c' in L_3, S = {u,p,q,x,c,c'} has 6 vertices. In G[S] the
      only edge inside a parity class (parity of dist(u,.)) is cc'. If x is not adjacent to both c and c',
      one of c,c' has degree 1 in G[S], so cc' lies on no cycle and G[S] is bipartite: b >= 6, contradiction.
      So every x in L_2 is adjacent to all of L_3, and L_2 ∪ L_3 is a clique. Then y in Y has
      dist(y,u)=1, dist(y,L_1)<=2 (via u), dist(y, L_2 ∪ L_3)<=2 (via its L_2-neighbour): ecc(y)<=2. Contradiction.
    I-b: L_3 = {d}. Let x0 in L_2 be a neighbour of d and y0 in L_1 a neighbour of x0. Then dist(y0,u)=1,
      dist(y0,L_1)<=2, dist(y0,L_2)<=2 (L_2 clique), dist(y0,d)<=2: ecc(y0)<=2. Contradiction. (No b needed.)
  Case II: every root has k=2. Fix u: L_1, L_3 cliques, α(L_2)=2.
    (II.1) For d in L_3: u is in M_3(d) (layer 3 from d), which is a clique (k(d)=2); u has no neighbour in
      L_2, so no x in L_2 has dist(x,d)=3. Hence dist(L_2, L_3) <= 2 pointwise.
    (II.2) For x in L_2: dist(x,u)=2, dist(x,L_1)<=2 (parent, L_1 clique), dist(x,L_3)<=2 by II.1.
      ecc(x)=3 gives x' in L_2 with dist(x,x')=3.
    (II.3) If such x, x' both have L_3-neighbours c, c', then c != c', c~c', parents x1 != x1' in L_1 are adjacent,
      and x,x1,x1',x',c',c is an induced 6-cycle (every chord would give dist(x,x')<=2 or join layers 1 and 3).
      b >= 6, contradiction.
    (II.4) Take d in L_3, x0 in L_2 adjacent to d, and y in L_2 with dist(x0,y)=3. By II.3, y has no
      L_3-neighbour. By II.1, for every z in L_3, dist(y,z)=2, so y and z have a common neighbour m_z, which lies
      in L_2 (adjacent to y: layers 1,2; adjacent to z: layers 2,3).
    (II.5) Let a' be a neighbour of y in L_1. N(y) is a clique (k(y)=2) containing a' and every m_z, so
      dist(a',z) <= 2 for all z in L_3. Also dist(a',u)=1, dist(a',L_1)<=1, dist(a',L_2)<=2. ecc(a')<=2. Contradiction.

Theorem B5 (proved on paper). No self-centered graph with D=4 has b <= 6.
  By B3 every root has k=2. Fix u: L_1, L_3, L_4 cliques, α(L_2)=2.
  (1) Some z in L_2 has no neighbour in L_3: take w in L_3; dist(w,L_4)<=2, dist(w,L_3)<=1, dist(w,L_1)<=3,
      dist(w,u)=3, so ecc(w)=4 needs z in L_2 with dist(w,z)=4; z cannot have an L_3-neighbour (L_3 clique).
  (2) For d in L_4: M_4(d) is a clique containing u (k(d)=2), so every vertex at distance 4 from d is in
      {u} ∪ L_1. Hence dist(z,d)<=3; and dist(z,d)>=3 since z has no L_3-neighbour. So dist(z,d)=3, and a
      geodesic z-m-c-d has m in L_2 (m~z puts m in L_1 ∪ L_2; dist(m,d)=2 puts m in L_2 ∪ L_3 ∪ L_4).
  (3) Let z1 in L_1 be a neighbour of z. N(z) is a clique (k(z)=2), so z1 ~ m and dist(z1,d) <= 3 for every
      d in L_4. With dist(z1,u)=1, dist(z1,L_1)<=1, dist(z1,L_2)<=2, dist(z1,L_3)<=3: ecc(z1)<=3 < 4. Contradiction.

Summary of the paper proof: a counterexample must be self-centered (Theorem A), with D >= 2 (B1),
D not in {3,4} (B4, B5) and D <= 2 (B3 with B4, B5): so D = 2, which B2 settles using Chvátal–Erdős.
So the conjecture is TRUE on paper, conditional only on the Chvátal–Erdős theorem (from memory, unverified)
in the case "self-centered, diameter 2". Every other step is elementary and written above.

Independent computer checks of intermediate claims (exhaustive, labeled graphs):
- `layer.c`: every self-centered graph with D>=3 has a root whose layer α-sum is >= D+3, n<=8
  (n=6: 60, n=7: 5400, n=8: 567840 graphs; 0 failures). This is stronger than B3+B4+B5 need.
- `d2.c`: every self-centered D=2 graph with b<=4 has α<=3 and no cut vertex, n<=7
  (3, 102, 2730, 83037 graphs for n=4..7; 0 failures).
- `anneal.c` (simulated annealing toward self-centered D in {3,4} with all layer sums <= D+2, n=7..11,
  3 seeds): never reached such a graph.

## Chvátal–Erdős (from memory, unverified; classical proof reproduced for the reviewer)
Claim: κ(H) >= α(H), |H| >= 3 ⇒ H Hamiltonian. Here κ(H)>=3 so H is 2-connected and has a cycle.
Take a longest cycle C; suppose v not on C; K = component of H - V(C) containing v; N = N(K) ∩ V(C).
No two consecutive vertices of C are both in N (else reroute through K: longer cycle), so V(C) \ N is
nonempty and N separates K from it: |N| >= κ. The successors c^+ (c in N, fixed orientation) are not in
N, so not adjacent to K; two successors c_i^+ ~ c_j^+ would give the longer cycle
c_i -(K)- c_j -(backwards)- c_i^+ - c_j^+ -(forwards)- c_i. So {v} ∪ {c^+} is independent of size
|N|+1 >= κ+1 > α. Contradiction. Applied in B2 to H = G + universal vertex.

## Decisions
- Lean: the full proof is long (BFS layers, walks, Ham path construction, real arithmetic). With about
  35 minutes left after the paper proof I judged a complete formalization impossible in the box, and chose
  a careful write-up plus exhaustive checks of every intermediate claim instead.
- Counts are for labeled graphs; I did not reproduce the iso-class count 516 (labeled exhaustive is stronger).
