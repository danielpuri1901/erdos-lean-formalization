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
