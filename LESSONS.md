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
- With `open SimpleGraph Finset`, `disjoint_left` is ambiguous; write `Finset.disjoint_left`.
- `Finset.coe_subtype` does not exist; to unpack `a ∈ ↑(s.subtype p)` use `simp only [mem_coe, Finset.mem_subtype]`.
- `(Real.lt_sqrt h).mpr (by nlinarith)` leaves the radicand as a metavariable and `nlinarith` fails; state the result type with `have hlt : x < √y := ...` first.
- `exact_mod_cast` on facts that contain big `∑` terms timed out (it pushes casts into the sums); state the final algebra as a lemma over plain ℕ variables and pass the sums as arguments.
- To check that a new theorem states exactly the imported conjecture, give it the type `type_of% @Imported.name.{u}` and the proof `@new_name.{u}`.
- `interval_cases A <;> interval_cases m <;> omega` closes concrete polynomial inequalities with literal powers (120 cases in a few seconds).
