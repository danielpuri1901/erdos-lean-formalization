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
- `Finset.sum_le_sum_of_subset` on a sum of `Nat` gave "typeclass instance problem is stuck CanonicallyOrderedAdd"; pass the summand: `Finset.sum_le_sum_of_subset (f := fun i : Nat => i) hsub`.
- `push_neg` is deprecated in this Mathlib (warning); `push Not at h` works.
- Parity of `sigma 1 n` with no factorization: cast the divisor sum to `ZMod 2` and use `Finset.sum_involution` with `d ↦ m / d` on odd divisors (`ZMod.natCast_eq_zero_iff_even`, `ZMod.natCast_eq_one_iff_odd`).
- `decide` proves `∀ y, y < 17 → sigma 1 y ≠ y + 5` directly; `decide +kernel` handles `∀ x < 300, sigma 1 x % x ≠ 5` in a few seconds.
- Tooling: a foreground Bash loop of long searches hit the 600 s tool limit and lost about 10 minutes; start every search over a minute in the background with its own `timeout`.
- Search code: an abundancy filter `σ(n) > 3n` in doubles drops σ(x) = 3x + 5 near 10^19; give every float test the same relative slack as the pruning tests.
