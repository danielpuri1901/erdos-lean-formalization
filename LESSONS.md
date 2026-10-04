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
- With `open SimpleGraph`, `dist_self` and `dist_comm` are ambiguous with the metric-space lemmas; write `SimpleGraph.dist_self`, `SimpleGraph.dist_comm`.
- `G.loopless` is now a `Std.Irrefl G.Adj` instance, not a function; use `G.irrefl h` to refute `G.Adj v v`.
- `choose!` on `fun i (hi : i ≤ c) => ...` keeps a dependent function; first state `have : ∀ i, i ≤ c → ∃ w, ...` and put `Nonempty α` in context, then `choose!`.
- To check a sweep theorem has exactly the imported statement, use `universe u in example : type_of% @orig.{u} = type_of% @mine.{u} := rfl` (without fixing the universe the two `Type*` universes differ and `rfl` fails).
