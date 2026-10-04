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
- `rcases h with rfl | h` can leave the old hypothesis visible under the reused name after the `rfl` substitution, which gives a type mismatch; give the new hypothesis a fresh name (`hm₁`, not `he₁`).
- `Finite.exists_le_maximal (p := fun I : Finset V => ...) (a := ∅)` gives a maximal independent set or a maximal matching in one line; `Finset.card_mul_le_card_mul` does double counting.
- `pkill -f <pattern>` also kills the shell running it when the pattern appears in its own command line; use `pgrep -a` and then `kill <pid>`.
- When a branch-and-bound counts distinct sets with an exclusion mask, compute the pruning bound from coverage without the mask; otherwise it undercounts. Check counts against brute force first.
