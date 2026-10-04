# Lessons

Read this before you write Lean.
Add one line for each problem that cost you time, with the fix.

- Build with `export PATH=/opt/lean/bin:$PATH && lake build Solution`.
  Never run `lake update` or `lake exe cache get`: the packages are prebuilt.
- The first import of a formal-conjectures module compiles it, which takes minutes; start that build early.
- File names that are numbers need guillemets in the import: `import FormalConjectures.OEIS.«77408»`.
- formal-conjectures files use the Lean module system; a plain `import` of the module is enough in `Solution.lean`.
- `ℕ` needs Mathlib notation in scope; `Nat` always works.
- Use `decide +kernel` for finite checks.
  `native_decide` is banned.
- One `decide +kernel` over about 280 thousand cases used 5.5 GB; split large checks into chunks of about 10 thousand cases.
- A `noncomputable` definition built from `sInf` cannot be evaluated by `decide`.
  Prove a bridge lemma to a computable version first, as `dom_num_eq_computable` does in `FormalConjecturesForMathlib/Combinatorics/SimpleGraph/Domination.lean`.
- A theorem restated under the name of an imported declaration clashes; pick a new name.
- wowii40: `Nat.sSup_mem` cannot infer the set from a goal stated with a named `sSup` definition; pass `(s := {n | ...})` and then `change ... = G.largestInducedBipartiteSubgraphSize at h`.
- wowii40: renamed lemmas: `Finset.filter_card_add_filter_neg_card_eq_card` is `Finset.card_filter_add_card_filter_not`; `Finset.card_univ_diff` is deprecated for `Finset.card_univ_sdiff`.
- wowii40: an induced star is acyclic via `isAcyclic_iff_forall_adj_isBridge`, `isBridge_iff`, `deleteEdges_adj` (an endpoint other than the centre is isolated after deleting the edge); `IsAcyclic.induce` gives induced subgraphs of forests.
- wowii40: the problem file's "tight" meant f = ceil((p+b+1)/2), i.e. 2f-b-p ∈ {1,2}, not 2f-b-p = 1; check the meaning of reported counts before chasing a mismatch.
- wowii40: for exhaustive graph searches without geng, vertex augmentation plus a canonical code (invariant-sorted cells, twin pruning) generates all 274,668 graphs on 9 vertices in 19 s; extend only parents with small slack (Δslack ≥ -2 per vertex).
- wowii40: the Bash tool blocks `sleep N; cmd`; wait for background jobs with Monitor and an until-loop.
- wowii40: `git add -A` in a sweep folder commits compiled C binaries; put a .gitignore for them in the folder first.
