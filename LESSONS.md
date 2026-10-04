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
- `pkill -f <pattern>` also matched the Bash tool's own shell command line and killed it (exit 144); kill by PID from `pgrep` instead.
- `Finset.toList` is noncomputable, so `decide` cannot run a def that uses it; prove the fold only depends on membership and bridge to a list version (`best_congr`, `valueAux_eq_valL` in the catchup sweep `Solution.lean`).
- State a Finset/list bridge as `R.val = ↑l`, not as `⟨↑l, hl⟩` with `hl : l.Nodup`: the latter made `simp` fail with "not type-correct under implicit transparency".
- `rw [f]` on a well-founded `def` unfolds one step through its equation lemma; that is enough for an induction-on-card bridge.
- `decide +kernel` on an unmemoised game tree: about 43 thousand nodes took about 30 s; the kernel gives no memoisation across transpositions.
