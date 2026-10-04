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
- eq677: `simp only [Magma.op]` makes no progress on a `letI` instance; use an `@[reducible] def` magma, state goals as `@Equation677 V (myMagma ..)`, and unfold with `dsimp only [myMagma, Magma.op]`.
- eq677: after unfolding module expressions (`a • x + ...`), the `module` tactic closes them; `ring_nf; abel` did not.
- eq677: `noncomm_ring` cannot use hypotheses such as `b * b⁻¹ = 1`; derive `∀ x, c * (b * x) = x` and alternate `rw [show _ = _ by noncomm_ring, ecb]` steps.
- eq677: `IsUnit.mul_right_eq_zero` cancels a unit left factor in a non-commutative ring.
- eq677: `pkill -f <script>` inside a Bash call also matches that call's own command line and kills the shell; find PIDs with `ps -eo pid,comm,args` and `kill` them.
