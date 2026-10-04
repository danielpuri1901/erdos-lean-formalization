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

## From the 16 sweep sessions (2026-10-04)

- `Finset.sum_le_sum_of_subset` on a sum of `Nat` gave "typeclass instance problem is stuck CanonicallyOrderedAdd"; pass the summand: `Finset.sum_le_sum_of_subset (f := fun i : Nat => i) hsub`.
- `push_neg` is deprecated in this Mathlib (warning); `push Not at h` works.
- Parity of `sigma 1 n` with no factorization: cast the divisor sum to `ZMod 2` and use `Finset.sum_involution` with `d ↦ m / d` on odd divisors (`ZMod.natCast_eq_zero_iff_even`, `ZMod.natCast_eq_one_iff_odd`).
- `decide` proves `∀ y, y < 17 → sigma 1 y ≠ y + 5` directly; `decide +kernel` handles `∀ x < 300, sigma 1 x % x ≠ 5` in a few seconds.
- Tooling: a foreground Bash loop of long searches hit the 600 s tool limit and lost about 10 minutes; start every search over a minute in the background with its own `timeout`.
- Search code: an abundancy filter `σ(n) > 3n` in doubles drops σ(x) = 3x + 5 near 10^19; give every float test the same relative slack as the pruning tests.
- `rcases h with rfl | h` can leave the old hypothesis visible under the reused name after the `rfl` substitution, which gives a type mismatch; give the new hypothesis a fresh name (`hm₁`, not `he₁`).
- `Finite.exists_le_maximal (p := fun I : Finset V => ...) (a := ∅)` gives a maximal independent set or a maximal matching in one line; `Finset.card_mul_le_card_mul` does double counting.
- `pkill -f <pattern>` also kills the shell running it when the pattern appears in its own command line; use `pgrep -a` and then `kill <pid>`.
- When a branch-and-bound counts distinct sets with an exclusion mask, compute the pruning bound from coverage without the mask; otherwise it undercounts. Check counts against brute force first.
- `omega` is incomplete: it reported a "possible counterexample" for a true bounded goal with several `/ 3` and `% 3` terms (a077408). Fix: `subst` the definitions, then `interval_cases` on the small variables, then `omega`.
- Kernel evaluation of a reverse-and-add trajectory costs about quadratic time: base 3 with `decide +kernel` took 10 s for 200 steps and 60 s for 1000. Shrinking the recursion fuel did not help. Fix: prove soundness of a structural-recursion checker (`check_sound` in the a077408 sweep) and keep N modest.
- Digit arguments go fastest with `dig n i := n / 3^i % 3`, Mathlib's `Nat.getD_digits`, `Nat.digits_length_le_iff` and `Nat.lt_digits_length_iff`, with the carry casework stated on abstract `ℕ → ℕ` functions so `omega` sees plain atoms (a077408).
- Add a `.gitignore` for compiled C binaries before `git add -A` in `sweep/<id>/` (a077408 committed binaries twice).
- `pkill -f PATTERN` / `pgrep -f PATTERN` also matches the bash command that runs it (exit 144 kills your own shell); put jobs in a script and kill by PID.
- formal-conjectures `Prop` defs such as `IsZeroForcingSet` block `Decidable` synthesis; `unfold` them first, then `decide +kernel` works (the closure iterate reduces in the kernel).
- `decide +kernel` over zero forcing closures on `Fin 10` ran out of memory (13.5 GB) even for 84 sets; `Fin 6` with all 64 subsets takes seconds. Keep concrete-graph checks to about 6 vertices.
- `SimpleGraph` fields are classes now: `symm := ⟨fun _ _ h => Or.symm h⟩`, `loopless := ⟨by decide⟩`; define adjacency as a separate def and give `instance : DecidableRel adj := fun _ _ => instDecidableOr`.
- `connected_iff_exists_forall_reachable` needs `(G := g)` to use `.mpr`; for `card ≠ 0` from a vertex use `(Fintype.card_pos_iff.mpr ⟨w⟩).ne'`.
- No `/usr/bin/time` in the container; time runs with `date +%s` differences.
- `pkill -f <pattern>` also matched the Bash tool's own shell command line and killed it (exit 144); kill by PID from `pgrep` instead.
- `Finset.toList` is noncomputable, so `decide` cannot run a def that uses it; prove the fold only depends on membership and bridge to a list version (`best_congr`, `valueAux_eq_valL` in the catchup sweep `Solution.lean`).
- State a Finset/list bridge as `R.val = ↑l`, not as `⟨↑l, hl⟩` with `hl : l.Nodup`: the latter made `simp` fail with "not type-correct under implicit transparency".
- `rw [f]` on a well-founded `def` unfolds one step through its equation lemma; that is enough for an induction-on-card bridge.
- `decide +kernel` on an unmemoised game tree: about 43 thousand nodes took about 30 s; the kernel gives no memoisation across transpositions.
- `push_cast` in a goal (not hypotheses) can rewrite `↑(l.sum)` into `(l.map Nat.cast).sum`, so `omega` sees two atoms; use `simp only [Nat.cast_zero, Nat.cast_one]` plus `linarith` instead.
- `omega` treats `q + 1 + 1` and `q + 2` inside a product as different atoms; state helper inequalities in exactly the form `rcases` produced.
- `Nat.pos_pow_of_pos` no longer exists; use `by positivity`. `push_neg` is deprecated; use `not_lt.mp`.
- `norm_num` evaluates `Nat.digits 10 <literal>` and `n ∣ <literal>`, so `⟨by norm_num, by norm_num, by norm_num⟩` proves membership in a 0/1-multiple set; 98 such cases built in about 15 s.
- Mathlib has `Nat.nine_dvd_iff`, `Nat.eleven_dvd_iff` (alternating sum over ℤ), `Nat.base_pow_length_digits_le`, `Nat.digits_def'`, `Nat.ofDigits_digits`: enough for digit-sum lower bounds.
- wowii198a: `SimpleGraph.dist_comm` is ambiguous with `_root_.dist_comm` under `open SimpleGraph`; write `SimpleGraph.dist_comm`, and prefer `have e : G.dist a b = k := by rw [SimpleGraph.dist_comm]; exact h` over `rw [dist_comm] at h` (it rewrites the wrong occurrence).
- wowii198a: after `set m := q.getVert 1 with hm`, new facts such as `dist_le (q.drop 1)` still mention `q.getVert 1`; `rw [← hm] at this` before `omega`, or omega treats them as different atoms.
- wowii198a: `split_ifs at heq` fails on an unreduced `(fun w => if ..) a = ..`; run `dsimp only at heq` first. Close the Fin 2 branches with `first | omega | exact absurd heq (by decide)`.
- wowii198a: names in this Mathlib: `ENat.natCast_toNat` (not `coe_toNat`), `Finset.card_insert_of_notMem`, `List.IsChain` (not `Chain'`), `Walk.cons_tail_support`, `push Not` (not `push_neg`), `Set.mem_ofPred_eq` (not `mem_setOf_eq`).
- wowii198a: to turn a list into a walk, prove `∀ l ≠ [], l.IsChain G.Adj → ∃ a c (p : G.Walk a c), p.support = l` by recursion on `a :: b :: t`; then `List.count_eq_one_of_mem` gives `IsHamiltonian`.
- wowii40: `Nat.sSup_mem` cannot infer the set from a goal stated with a named `sSup` definition; pass `(s := {n | ...})` and then `change ... = G.largestInducedBipartiteSubgraphSize at h`.
- wowii40: renamed lemmas: `Finset.filter_card_add_filter_neg_card_eq_card` is `Finset.card_filter_add_card_filter_not`; `Finset.card_univ_diff` is deprecated for `Finset.card_univ_sdiff`.
- wowii40: an induced star is acyclic via `isAcyclic_iff_forall_adj_isBridge`, `isBridge_iff`, `deleteEdges_adj` (an endpoint other than the centre is isolated after deleting the edge); `IsAcyclic.induce` gives induced subgraphs of forests.
- wowii40: the problem file's "tight" meant f = ceil((p+b+1)/2), i.e. 2f-b-p ∈ {1,2}, not 2f-b-p = 1; check the meaning of reported counts before chasing a mismatch.
- wowii40: for exhaustive graph searches without geng, vertex augmentation plus a canonical code (invariant-sorted cells, twin pruning) generates all 274,668 graphs on 9 vertices in 19 s; extend only parents with small slack (Δslack ≥ -2 per vertex).
- wowii40: the Bash tool blocks `sleep N; cmd`; wait for background jobs with Monitor and an until-loop.
- wowii40: `git add -A` in a sweep folder commits compiled C binaries; put a .gitignore for them in the folder first.
- `pkill -f`/`pgrep -f PATTERN` also matches the tool's own bash command line and kills it (exit 144); use a bracket pattern like `pgrep -f "[.]/g61"`.
- `cases p` on a `SimpleGraph.Walk`: name binders with `| @cons _ w _ h q =>` (not `rename_i`); in a nested `nil` case the endpoint is unified, so use the outer name (`v`), not `w`.
- `simp` rewrites `decide (x ∉ I)` to `!decide (x ∈ I)`; simp the induction hypothesis and the goal together (`simp [...] at ih ⊢`) before `omega`.
- Renames in this Mathlib: `Finset.card_univ_diff` → `Finset.card_univ_sdiff`, `push_neg` → `push Not`, `card_insert_of_notMem`.
- `exact_mod_cast` failed to move `⌈x⌉ ≤ ((k : ℕ) : ℤ)` into ℝ; use `(Int.cast_le (R := ℝ)).mpr h` and then `rw [Int.cast_natCast]`.
- Acyclicity of induced subgraphs: `IsAcyclic.anti` with `isAcyclic_starGraph`, or `isAcyclic_iff_forall_adj_isBridge` + `isBridge_iff` + `not_reachable_of_neighborSet_left_eq_empty` (degree-one endpoint). Distances: `exists_dist_eq_diam`, `Connected.exists_path_of_dist`, `Connected.dist_triangle`, `dist_eq_one_iff_adj`, `dist_le`.
- With `open SimpleGraph`, `dist_self` and `dist_comm` are ambiguous with the metric-space lemmas; write `SimpleGraph.dist_self`, `SimpleGraph.dist_comm`.
- `G.loopless` is now a `Std.Irrefl G.Adj` instance, not a function; use `G.irrefl h` to refute `G.Adj v v`.
- `choose!` on `fun i (hi : i ≤ c) => ...` keeps a dependent function; first state `have : ∀ i, i ≤ c → ∃ w, ...` and put `Nonempty α` in context, then `choose!`.
- To check a sweep theorem has exactly the imported statement, use `universe u in example : type_of% @orig.{u} = type_of% @mine.{u} := rfl` (without fixing the universe the two `Type*` universes differ and `rfl` fails).
- eq677: `simp only [Magma.op]` makes no progress on a `letI` instance; use an `@[reducible] def` magma, state goals as `@Equation677 V (myMagma ..)`, and unfold with `dsimp only [myMagma, Magma.op]`.
- eq677: after unfolding module expressions (`a • x + ...`), the `module` tactic closes them; `ring_nf; abel` did not.
- eq677: `noncomm_ring` cannot use hypotheses such as `b * b⁻¹ = 1`; derive `∀ x, c * (b * x) = x` and alternate `rw [show _ = _ by noncomm_ring, ecb]` steps.
- eq677: `IsUnit.mul_right_eq_zero` cancels a unit left factor in a non-commutative ring.
- eq677: `pkill -f <script>` inside a Bash call also matches that call's own command line and kills the shell; find PIDs with `ps -eo pid,comm,args` and `kill` them.
- (minmodulus) `decide +kernel` on `∀ a b c d : ZMod 11, ... → f [a,b,c,d] = true` failed with "failed to synthesize Decidable"; write a Bool checker over `List.range N` instead and bridge with `ZMod.val_lt` and `ZMod.natCast_zmod_val` (see `allQuads` in the minmodulus `Solution.lean`; 14641 quadruples × 256 inner tests took about 25 s).
- (minmodulus) After `set A' := A.erase a₀`, `simpa using hTA' h` no longer sees `mem_erase`; use `(mem_erase.mp (hTA' h)).1 rfl`.
- (minmodulus) `simp [Nat.log_eq_iff]` does not evaluate `Nat.log 2 3`; use `Nat.log_eq_of_pow_le_of_lt_pow (by norm_num) (by norm_num)`.
- (minmodulus) `push_neg` is deprecated in this Mathlib; write `push Not`.
- (minmodulus) An integer-vector witness lemma (`m = (1 + v).toNat`, `v ≥ -1`, `∑ v = 0`, `∑ v a * a = 0`) made every invalidity proof a short `simp`/`linear_combination`; prefer it over hand-built `ℕ`-valued multisets with nested `if`s.
- With `open SimpleGraph Finset`, `disjoint_left` is ambiguous; write `Finset.disjoint_left`.
- `Finset.coe_subtype` does not exist; to unpack `a ∈ ↑(s.subtype p)` use `simp only [mem_coe, Finset.mem_subtype]`.
- `(Real.lt_sqrt h).mpr (by nlinarith)` leaves the radicand as a metavariable and `nlinarith` fails; state the result type with `have hlt : x < √y := ...` first.
- `exact_mod_cast` on facts that contain big `∑` terms timed out (it pushes casts into the sums); state the final algebra as a lemma over plain ℕ variables and pass the sums as arguments.
- To check that a new theorem states exactly the imported conjecture, give it the type `type_of% @Imported.name.{u}` and the proof `@new_name.{u}`.
- `interval_cases A <;> interval_cases m <;> omega` closes concrete polynomial inequalities with literal powers (120 cases in a few seconds).
- (wowii133) `G.loopless` and `G.symm` are `Std.Irrefl`/`Std.Symm` instances, not functions: use `(G.irrefl h).elim` and `h.symm`.
- (wowii133) `∑ _v ∈ Finset.univ, (1 : ℝ)` gets a stuck `Fintype ?m`; write `(Finset.univ : Finset α)`.
- (wowii133) Deprecated names in this Mathlib: `Walk.support_eq_cons` → `p.cons_tail_support.symm`, `ENat.coe_ne_top` → `ENat.natCast_ne_top`, `push_neg` → `push Not`.
- (wowii133) Geodesic arguments: `(p.take i).append (q.append (p.drop j))` with `Walk.take_length`, `Walk.drop_length`, `G.dist_le` and `omega` gives "no shortcut" lemmas in a few lines; `p.getVert 0 = u` is not `rfl`, so retype walks with `Walk.copy p.getVert_zero.symm rfl`.
- (wowii133) `isInducedPath` goals over an explicit list close with `fin_cases i <;> fin_cases j <;> simp [...]`; for `x :: y :: L` split indices with `rcases i with _ | _ | i`.
- (wowii133) Foreground `sleep` is blocked in this harness; start long searches in the background and check their output files.
- Directory names with dots need guillemets too: `import FormalConjectures.Arxiv.«2607.05739».TanArctanSum`.
- Mathlib names the `Zsqrtd`/`GaussianInt` product lemmas `Zsqrtd.re_mul` and `Zsqrtd.im_mul`, not `mul_re` and `mul_im`.
- One long `decide +kernel` run of a fuel-recursive big-integer checker scales about like fuel^2.5 (2000 in 5 s, 4000 in 30 s, 10000 in 300 s and 7.6 GB).
  The cost is the run length, not the number size.
  Fix: a checker that returns its final state (`runFrom`), chunks of 1250 indices with the boundary values as Python-written `def`s, and a chain of soundness lemmas.
  Each chunk takes 10 to 17 s even at n = 50000, and lake builds the chunk modules in parallel.
- Put expensive kernel checks in submodules (`Solution/X.lean`, imported by `Solution.lean`), so that edits to `Solution.lean` do not rerun them.
- In generated proofs, do not name the chunk results `h1 ... hN` when a hypothesis is also called `h5`: the later `have` shadows it.
- `pkill -f <pattern>` matches the Bash command that runs it if the pattern appears in that command line, and kills your own shell. Kill by PID instead.
- `Int.dvd_iff_emod_eq_zero` holds with no side condition, including divisor 0, so a Boolean `b % a != 0` is a sound test for `¬ a ∣ b`.
- a000224: `decide +kernel` over nested `∀ u < 32, ∀ v < 3721, ...` hit "(kernel) deep recursion"; enumerate a small cofactor instead (`d = 4u(u-1)/v < 121`).
- a000224: a Prop-valued bounded `∀` with `/` and several `→` antecedents failed to synthesize `Decidable`; a `Bool` checker plus `∀ u < 32, ∀ d < 121, chk u d = true := by decide +kernel` ran in about 2 s.
- a000224: `zify [h1, h2, ...] at hk` (with the `1 ≤ x` facts for every Nat subtraction) cleanly turns a Nat divisibility equation into an Int one for `linear_combination`/`nlinarith`.
- a000224: names: `Prod.pow_fst`/`Prod.pow_snd` (not `fst_pow`), `ZMod.val_injective n` takes `n` explicitly, `ZMod.chineseRemainder` gives the CRT ring equiv; `a n = #squares in ZMod n` bridge is `A224Sweep.a_eq_card_zmod`.
- a000224: segmented C sieve starting at 0 looped forever dividing `rem[0] = 0` by p; start each prime's multiples at `max(p, ...)`.
- (dean3) Inside `Set.InjOn p.getVert {i | i ≤ p.length}` arguments, `(show m ≤ p.length by omega)` works; `by simp; omega` fails with "simp made no progress". `h ▸ hai` with `h : a = p.getVert i` failed to compute a motive; use `rw [← h] at hai`.
- (dean3) Path segment `v_i … v_j` of a path `p`: `(p.drop i).take (j - i)`, with `Walk.take_length`, `Walk.drop_length`, `Walk.take_getVert`, `Walk.drop_getVert`, `IsPath.drop`, `IsPath.take`; a fan cycle is `Walk.cons h (Walk.cons h' seg).reverse` plus `Walk.cons_isCycle_iff`.
