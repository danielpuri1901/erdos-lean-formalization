# claudecycles2: no Hamiltonian arc decomposition of the cube digraph for m = 2

## Argument (finite check)

Vertices `V = Fin 3 → ZMod 2`, 8 of them; `bumpAt b v` flips coordinate `b`.

1. Each `σ c` sends `v` to `bumpAt (f c v) v` for some `f c : V → Fin 3` (`choose` on `cubeAdj`).
2. At each `v`, the three values `f 0 v, f 1 v, f 2 v` are distinct: if `f c v = f c' v = b` then
   `σ c v = σ c' v = bumpAt b v` and the `∃!` for `(v, b)` forces `c = c'`.
3. Each `σ c` is a cycle with full support, so every `y` is reached from `0` as `(σ c ^ i) 0`
   with `i < 8` (`SameCycle.exists_pow_eq_of_mem_support`, card of cycle support ≤ 8).
4. Model on `Fin 8`: `enc : V → Fin 8`, `flipT b n` a table, `step t n = flipT (t n) n` for a
   direction table `t : Fin 8 → Fin 3`; `orb t k x` lists the first `k` points of the orbit;
   `Ham t := ∀ y, y ∈ orb t 8 0`. With `t = f c ∘ vtx`, `enc ∘ σ c = step t ∘ enc`, so step 3 gives `Ham t`.
5. Kernel check (`decide +kernel`, nested `∀ aᵢ : Fin 3`): no three tables that are pointwise
   distinct are all `Ham`. Only 12 tables are `Ham` (the 12 directed Hamiltonian cycles of Q3),
   so the search is 6561 + 12·256 small evaluations.

(Human proof for reference: the three undirected cycles have complementary perfect matchings forming
a 1-factorization with no parallel class; the dir-0 edges of the two matchings missing dir 1 and
dir 2 must intersect. Not used in Lean.)

## Plan
- `Solution/Check.lean`: model + kernel check.
- `Solution.lean`: bridge and main theorem.

## State (2026-10-04, 19:24 UTC)

- Submitted as commit `9701f6678bfa92589cec0b8df57677f29a0dac62` (`submit(claudecycles2): ...`).
  The checker is paused today, so I did not poll for a verdict. No verdict yet.
- `lake build Solution` passes locally with no `sorry` and no warnings.
  `#print axioms cube_no_decomposition_m2` gives `[propext, Classical.choice, Quot.sound]`.
  `example : type_of% @ClaudesCycles.cube_hamiltonian_arc_decomposition_impossible_m2 := cube_no_decomposition_m2` checks.
- Cost: `Solution/Check.lean` builds in about 64 s; peak about 2.3 GB anon memory, plus about 6.6 GB of shared, file-backed `.olean` mappings that every module importing Mathlib has.
  `Solution.lean` builds in about 9 s.
- What changed from the plan: `Ham` became the Bool `hamB` (the orbit of 0 visits all 8 vertices).
  This counts Hamiltonian paths from 0, so 54 tables pass, not 12; the triple check still holds.
  `check1` is split into 27 theorems `check1_abc` by the first three table entries, to keep each kernel check small.
- If the checker fails on memory: split `Solution/Check.lean` into several modules (by `a0`), or switch the model to Nat codes with `Nat.xor`.
