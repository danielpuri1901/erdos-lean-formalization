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
- (minmodulus) `decide +kernel` on `∀ a b c d : ZMod 11, ... → f [a,b,c,d] = true` failed with "failed to synthesize Decidable"; write a Bool checker over `List.range N` instead and bridge with `ZMod.val_lt` and `ZMod.natCast_zmod_val` (see `allQuads` in the minmodulus `Solution.lean`; 14641 quadruples × 256 inner tests took about 25 s).
- (minmodulus) After `set A' := A.erase a₀`, `simpa using hTA' h` no longer sees `mem_erase`; use `(mem_erase.mp (hTA' h)).1 rfl`.
- (minmodulus) `simp [Nat.log_eq_iff]` does not evaluate `Nat.log 2 3`; use `Nat.log_eq_of_pow_le_of_lt_pow (by norm_num) (by norm_num)`.
- (minmodulus) `push_neg` is deprecated in this Mathlib; write `push Not`.
- (minmodulus) An integer-vector witness lemma (`m = (1 + v).toNat`, `v ≥ -1`, `∑ v = 0`, `∑ v a * a = 0`) made every invalidity proof a short `simp`/`linear_combination`; prefer it over hand-built `ℕ`-valued multisets with nested `if`s.
