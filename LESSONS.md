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
- `pkill -f`/`pgrep -f PATTERN` also matches the tool's own bash command line and kills it (exit 144); use a bracket pattern like `pgrep -f "[.]/g61"`.
- `cases p` on a `SimpleGraph.Walk`: name binders with `| @cons _ w _ h q =>` (not `rename_i`); in a nested `nil` case the endpoint is unified, so use the outer name (`v`), not `w`.
- `simp` rewrites `decide (x ∉ I)` to `!decide (x ∈ I)`; simp the induction hypothesis and the goal together (`simp [...] at ih ⊢`) before `omega`.
- Renames in this Mathlib: `Finset.card_univ_diff` → `Finset.card_univ_sdiff`, `push_neg` → `push Not`, `card_insert_of_notMem`.
- `exact_mod_cast` failed to move `⌈x⌉ ≤ ((k : ℕ) : ℤ)` into ℝ; use `(Int.cast_le (R := ℝ)).mpr h` and then `rw [Int.cast_natCast]`.
- Acyclicity of induced subgraphs: `IsAcyclic.anti` with `isAcyclic_starGraph`, or `isAcyclic_iff_forall_adj_isBridge` + `isBridge_iff` + `not_reachable_of_neighborSet_left_eq_empty` (degree-one endpoint). Distances: `exists_dist_eq_diam`, `Connected.exists_path_of_dist`, `Connected.dist_triangle`, `dist_eq_one_iff_adj`, `dist_le`.
