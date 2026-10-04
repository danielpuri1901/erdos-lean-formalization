# NOTES: txgraffiti3 disproof

## Argument
G = the cubic graph on Fin 48 from `data/txgraffiti3/counterexample.edgelist` (credit: ipitchford/txgraffiti-order48-successor).
- 3-regular: `decide`.
- saturationNumber G ≤ 15: M = {{2i,2i+1} : i < 15} is a matching of G, and every edge of G has an endpoint < 30
  (checked by `decide`), so every edge meets M: M is maximal. `Nat.sInf_le`.
- indepDominationNumber G ≥ 16: the set of sizes is nonempty (explicit 16-vertex independent dominating set),
  so `Nat.sInf_mem` gives an IDS D of size i(G). If i(G) ≤ 15, D contradicts the certificate below.
- conjecture with r = 3 gives i(G) ≤ μ*(G) ≤ 15, contradiction.

## Certificate for "no IDS with ≤ 15 vertices"
State (k, d, x): budget k, dominated mask d (bit v set iff v ∈ N[S]), excluded mask x.
P k d x : no T ⊆ [0,48) with |T| ≤ k, T independent, T ∩ (d ∪ x) = ∅, d ∪ N[T] ⊇ [0,48).
- bound leaf: #undominated > 4k (each vertex dominates at most 4) ⇒ P.
- branch node u (u undominated): T must contain some t ∈ N[u]; take the first one in the list N[u];
  children w ∈ N[u] in order, skipping w ∈ d ∪ x, child state (k-1, d ∪ N[w], x ∪ {earlier eligible w}).
Search with min-branching pick + exclusion: 124,512 nodes (63,479 branch nodes, 61,033 bound leaves).
Lowest-index pick would need 874K nodes, so the picks come from the certificate, not from the checker.

## Decisions
- Vertex sets are Nat bitmasks (kernel GMP ops). Adjacency is defined from a table of closed-neighbourhood masks.
- Certificate = one big Nat per chunk, read 6 bits at a time in preorder: value u < 48 = branch on u,
  value 48 = bound leaf, value 49 = frontier state proved in another chunk (lookup in a list of verified states).
- Chunks of about 10K nodes in separate modules `Solution/TxCert/*.lean` so each kernel run stays small.
- Proof over Nat vertices (< 48) and convert from Finset (Fin 48) at the end.
