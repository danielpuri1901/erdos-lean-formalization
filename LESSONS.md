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
- (wowii133) `G.loopless` and `G.symm` are `Std.Irrefl`/`Std.Symm` instances, not functions: use `(G.irrefl h).elim` and `h.symm`.
- (wowii133) `∑ _v ∈ Finset.univ, (1 : ℝ)` gets a stuck `Fintype ?m`; write `(Finset.univ : Finset α)`.
- (wowii133) Deprecated names in this Mathlib: `Walk.support_eq_cons` → `p.cons_tail_support.symm`, `ENat.coe_ne_top` → `ENat.natCast_ne_top`, `push_neg` → `push Not`.
- (wowii133) Geodesic arguments: `(p.take i).append (q.append (p.drop j))` with `Walk.take_length`, `Walk.drop_length`, `G.dist_le` and `omega` gives "no shortcut" lemmas in a few lines; `p.getVert 0 = u` is not `rfl`, so retype walks with `Walk.copy p.getVert_zero.symm rfl`.
- (wowii133) `isInducedPath` goals over an explicit list close with `fin_cases i <;> fin_cases j <;> simp [...]`; for `x :: y :: L` split indices with `rcases i with _ | _ | i`.
- (wowii133) Foreground `sleep` is blocked in this harness; start long searches in the background and check their output files.
