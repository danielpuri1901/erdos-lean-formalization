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
- a000224: `decide +kernel` over nested `∀ u < 32, ∀ v < 3721, ...` hit "(kernel) deep recursion"; enumerate a small cofactor instead (`d = 4u(u-1)/v < 121`).
- a000224: a Prop-valued bounded `∀` with `/` and several `→` antecedents failed to synthesize `Decidable`; a `Bool` checker plus `∀ u < 32, ∀ d < 121, chk u d = true := by decide +kernel` ran in about 2 s.
- a000224: `zify [h1, h2, ...] at hk` (with the `1 ≤ x` facts for every Nat subtraction) cleanly turns a Nat divisibility equation into an Int one for `linear_combination`/`nlinarith`.
- a000224: names: `Prod.pow_fst`/`Prod.pow_snd` (not `fst_pow`), `ZMod.val_injective n` takes `n` explicitly, `ZMod.chineseRemainder` gives the CRT ring equiv; `a n = #squares in ZMod n` bridge is `A224Sweep.a_eq_card_zmod`.
- a000224: segmented C sieve starting at 0 looped forever dividing `rem[0] = 0` by p; start each prime's multiples at `max(p, ...)`.
