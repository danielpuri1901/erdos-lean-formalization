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
- `omega` is incomplete: it reported a "possible counterexample" for a true bounded goal with several `/ 3` and `% 3` terms (a077408). Fix: `subst` the definitions, then `interval_cases` on the small variables, then `omega`.
- Kernel evaluation of a reverse-and-add trajectory costs about quadratic time: base 3 with `decide +kernel` took 10 s for 200 steps and 60 s for 1000. Shrinking the recursion fuel did not help. Fix: prove soundness of a structural-recursion checker (`check_sound` in the a077408 sweep) and keep N modest.
- Digit arguments go fastest with `dig n i := n / 3^i % 3`, Mathlib's `Nat.getD_digits`, `Nat.digits_length_le_iff` and `Nat.lt_digits_length_iff`, with the carry casework stated on abstract `ℕ → ℕ` functions so `omega` sees plain atoms (a077408).
- Add a `.gitignore` for compiled C binaries before `git add -A` in `sweep/<id>/` (a077408 committed binaries twice).
