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
- wowii198a: `SimpleGraph.dist_comm` is ambiguous with `_root_.dist_comm` under `open SimpleGraph`; write `SimpleGraph.dist_comm`, and prefer `have e : G.dist a b = k := by rw [SimpleGraph.dist_comm]; exact h` over `rw [dist_comm] at h` (it rewrites the wrong occurrence).
- wowii198a: after `set m := q.getVert 1 with hm`, new facts such as `dist_le (q.drop 1)` still mention `q.getVert 1`; `rw [← hm] at this` before `omega`, or omega treats them as different atoms.
- wowii198a: `split_ifs at heq` fails on an unreduced `(fun w => if ..) a = ..`; run `dsimp only at heq` first. Close the Fin 2 branches with `first | omega | exact absurd heq (by decide)`.
- wowii198a: names in this Mathlib: `ENat.natCast_toNat` (not `coe_toNat`), `Finset.card_insert_of_notMem`, `List.IsChain` (not `Chain'`), `Walk.cons_tail_support`, `push Not` (not `push_neg`), `Set.mem_ofPred_eq` (not `mem_setOf_eq`).
- wowii198a: to turn a list into a walk, prove `∀ l ≠ [], l.IsChain G.Adj → ∃ a c (p : G.Walk a c), p.support = l` by recursion on `a :: b :: t`; then `List.count_eq_one_of_mem` gives `IsHamiltonian`.
