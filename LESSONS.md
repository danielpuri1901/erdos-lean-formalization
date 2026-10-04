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
- `pkill -f PATTERN` / `pgrep -f PATTERN` also matches the bash command that runs it (exit 144 kills your own shell); put jobs in a script and kill by PID.
- formal-conjectures `Prop` defs such as `IsZeroForcingSet` block `Decidable` synthesis; `unfold` them first, then `decide +kernel` works (the closure iterate reduces in the kernel).
- `decide +kernel` over zero forcing closures on `Fin 10` ran out of memory (13.5 GB) even for 84 sets; `Fin 6` with all 64 subsets takes seconds. Keep concrete-graph checks to about 6 vertices.
- `SimpleGraph` fields are classes now: `symm := ⟨fun _ _ h => Or.symm h⟩`, `loopless := ⟨by decide⟩`; define adjacency as a separate def and give `instance : DecidableRel adj := fun _ _ => instDecidableOr`.
- `connected_iff_exists_forall_reachable` needs `(G := g)` to use `.mpr`; for `card ≠ 0` from a vertex use `(Fintype.card_pos_iff.mpr ⟨w⟩).ne'`.
- No `/usr/bin/time` in the container; time runs with `date +%s` differences.
