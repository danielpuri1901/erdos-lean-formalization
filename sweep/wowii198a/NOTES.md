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

