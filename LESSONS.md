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
- Directory names with dots need guillemets too: `import FormalConjectures.Arxiv.«2607.05739».TanArctanSum`.
- Mathlib names the `Zsqrtd`/`GaussianInt` product lemmas `Zsqrtd.re_mul` and `Zsqrtd.im_mul`, not `mul_re` and `mul_im`.
- `decide +kernel` on a fuel-recursive big-integer checker (`checkFrom fuel n a b`) scales about like N^2.5: N = 2000 in 5 s, 4000 in 30 s, 10000 in 300 s.
  Plan the range from that, and put the expensive lemma in a submodule (`Solution/X.lean`, imported by `Solution.lean`) so that edits to `Solution.lean` do not rerun it.
- `Int.dvd_iff_emod_eq_zero` holds with no side condition, including divisor 0, so a Boolean `b % a != 0` is a sound test for `¬ a ∣ b`.
