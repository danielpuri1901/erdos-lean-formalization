# Deep attempt: catchup

start: 1791108800 (date -u +%s); hard stop at 1791123200 (start + 4 h)

## 1. Target

Imported statement (`FormalConjectures.Paper.CatchUpConjecture`, namespace `CatchUp`):

```lean
theorem value_of_even_mul_succ_self_div_two
    (N : ℕ) (h_even : Even (N * (N + 1) / 2)) :
    value (.Icc 1 N) = .draw
```

`value S = valueAux S 0 0 true`; `valueAux R s_me s_opp first` is the minimax recursion
(see `problems/catchup.md` and the stage 1 notes `sweep/catchup/NOTES.md`).

### Working reformulation (gap form)

Write g = s_opp − s_me ≥ 0 for the lead the mover faces. Define
```
gv R g = if R = ∅ then (if g = 0 then draw else loss)
         else if ∑R < g then loss
         else best over x ∈ R of (if g ≤ x then (gv (R.erase x) (x − g)).neg else gv (R.erase x) (g − x))
```
Claim L1: for s ≤ t, `valueAux R s t false = gv R (t − s)`, and `valueAux R s s true = gv R 0`
(at s = t every pick x ≥ 0 satisfies s + x ≥ t, so the first-move flag changes nothing).
Hence `value S = gv S 0`. No hypothesis 0 ∉ R is needed.

Parity: `gv R g = draw` forces `∑R + g` even (stage 1 proved the s,t form in Lean:
`CatchUpSweep.valueAux_draw_even`).

### Stage 1 Lean results (Solution.lean, namespace CatchUpSweep, no sorry)
- `valueAux_eq_valL` (bridge to a computable list version `valL`), `value_Icc_eq_valL`.
- `catchup_draw_le_8`: the target for every N ≤ 8.
- `value_ne_draw_of_odd`: converse (odd total ⇒ not a draw), all N.

## 2. Route

The only known structure strong enough to carry an induction is the **pairs conjecture**
(stage 1, computed only, 0 violations in 75,024 pair-unions inside {1..24}):

  (P) Let R be a disjoint union of k pairs {a, a+1} (a ≥ 1).
      Then gv R 0 = draw if k is even, and gv R 1 = draw if k is odd.
  (P3) The same for R = {1,2,3} ∪ (k pairs with a ≥ 4): gv R 0 = draw for k even.

(P) + (P3) ⇒ target: {1..4m} = 2m pairs; {1..4m+3} = {1,2,3} ∪ 2m pairs.

Route (lemma list, status in brackets):

1. L1 gap reformulation `valueAux_eq_gv`, `value_eq_gv`. [proved in Lean: `Solution/Gap.lean`, attempt 1]
2. L2 reduction: (P) ∧ (P3) ⇒ target, stated in Lean with (P),(P3) as hypotheses. [proved in Lean: `Solution/Reduction.lean` `catchup_of_pairsConj`, attempt 3]
3. L3 (P) "≤ draw" half for k even, g = 0, from the k−1 case: partner reply.
   [proved on paper in stage 1, not reviewed; Lean: open]
4. L4 (P) "≤ draw" half for k odd, g = 1: mover takes a+1 → reply a, ties, k−1 even pairs at gap 0;
   mover takes a (smaller) → reply rule r6 (attempt 2) works in all 29,581 cases inside {1..20}, landing in T2/T4,
   which are computed-only and do not close. [reduced to T2, T4 (computed only)]
5. L5 (P) "≥ draw" halves (mover has a good pick). No fixed rule works. [open, key]
6. L6 a closed strategy family F ⊇ pairs positions on which an induction closes L4 and L5. [BLOCKED after attempt 2: no small family exists; see D5]
7. L7 certificates: `value (Icc 1 N) = draw` for N = 11, 12 [proved in Lean, attempt 4: `catchup_draw_11`, `catchup_draw_12`] and 15, 16 [proved in Lean, attempt 7: `catchup_draw_15`, `catchup_draw_16`].
8. L8 (Lean record of the partial argument) partner-reply lemmas `pairs_le_draw_of_gap_one`, `pairs_le_draw_of_gap_zero`, `pairsConj_le_halves`. [proved in Lean, attempt 6]
9. L9 `hard_of_T2_T4`: rule r6 in Lean, so that T2 ∧ T4 ⇒ the hard-case claim. [proved in Lean, attempt 8]
10. L10 the "≥ draw" halves GE: ∀ A, PairStarts A → (Even card → gv (pairUnion A) 0 ≠ loss) ∧ (Odd card → gv (pairUnion A) 1 ≠ loss). [open; computed inside {1..24}; attempt 9: no simple pick rule exists]
11. L11 final assembly in Lean: GE ∧ T2 ∧ T4 ⇒ PairsConj; GE ∧ T2 ∧ T4 ∧ PairsConj3 ⇒ target; `catchup_draw_le_16`, `catchup_draw_iff_le_16`. [proved in Lean, attempt 10]

The key step is L6. Decision: before any attempt on L4/L5, one worker searches computationally for F
(it tells soonest whether this route can work). In parallel one worker does L1 in Lean (needed by
every route). If L6 does not materialise by attempt 5, switch the Lean effort to extending the
verified range (N = 11, 12 via a kernel-checked strategy certificate), which is the fallback record.

Decisions (manager):
- D1. No web search, no literature. Everything "from memory" is unverified and unused.
- D2. A disproof is out of reach: the conjecture is verified to N = 28 (stage 1, C), the next even
  totals are N = 31, 32, which need a 17 GB table. Not pursued.
- D3. Lean work goes in `Solution/Gap.lean` (L1), `Solution/Reduction.lean` (L2), imported from
  `Solution.lean`; stage 1 code stays untouched.

- D4 (after attempt 1). Fallback record = kernel-checked strategy certificates. Manager computed the minimal
  certificate sizes (`deep/catchup/certsize.py`): a "≥ draw" certificate is a tree that fixes the mover's pick and
  branches over all opponent picks; a "≤ draw" certificate branches over all mover picks and fixes the replies.
  Sizes for ({1..N}, 0): N=7: 88/137 nodes, N=8: 189/285, N=11: 2,097/3,129, N=12: 4,937/7,442 (ge/le).
  These are tiny compared with the 43 K nodes `decide +kernel` handled in 30 s in stage 1, so Lean proofs of
  the target for N = 11, 12 (and probably 15, 16) are within reach. Design:
  `Cert`/`CertList` mutual inductive (`pick x c`, `all cs`, `leaf`), Bool checkers `chkGe`/`chkLe` on sorted
  lists in gap form, soundness `chkGe l g c = true → gvL n l g ≠ loss`, `chkLe … → gvL n l g ≠ win` by mutual
  structural induction, bridge `gv R g = gvL n l g` (copy of stage 1's `valueAux_eq_valL`), certificates
  generated by a program and checked by `decide +kernel`; for large N split the root's children into one
  module each (parallel build) and combine with a "value from children" lemma.

## 3. Facts

From stage 1 (`sweep/catchup/*.c`, see NOTES.md):
- F1. value {1..N} for N = 0..28 (exact C search, `catchup.c`, `run23_29.log`): draw exactly for
  N ∈ {0,3,4,7,8,11,12,15,16,19,20,23,24,27,28}; N = 9,10,14,18 are losses for P1, the other odd-total N are wins.
- F2. Pairs conjecture (P): 0 violations over all 75,024 pair-unions inside {1..24} (`pairs2.c`, `pairs2_24.log`);
  (P3): all 3,383 sets {1,2,3} ∪ pairs inside {1..22} (`triple.c`). Independent Python recheck inside {1..14}.
- F3. Hard case of L4: the reply a+1 (lead 2) secures ≥ draw in 29,274 of 29,581 cases inside {1..20} (`gmoves.c`);
  all shown failures contain the pairs {2,3},{4,5}.
- F4. v(Q, 2) = win for exactly 24 even pair-unions Q inside {1..18}, all containing {2,3},{4,5} (`g2ex.c`).
- F5. Fixed rules for the mover in a pairs position fail in about 1 % of positions inside {1..20} (`grule.c`).
- F6. General positions: 24–43 % of (R, g) with R ⊆ {1..14}, g ≥ 1 are not parity-best (`parity.c`).
- F8. (attempt 2) Rule r6 closes the hard case computationally inside {1..20}; T2 (v(Q,2) ≠ W, Q even pair-union without {2,3}) and
  T4 (v({3} ∪ Q', 4) = D, Q' odd pair-union inside {4..}) hold inside {1..20}; `deep/catchup/fam/`.
- F9. (manager) Minimal certificate tree sizes (ge/le nodes) for ({1..N},0): N=11: 2,097/3,129; N=12: 4,937/7,442;
  N=15: 80,269/119,525; N=16: 212,094/316,289 (`deep/catchup/certsize.py`).
- F7. Kernel evaluation without memoisation: N = 8 (43 K nodes) takes 30 s; N = 11 needs 15 M nodes.

## 4. Attempts

### Attempt 1 — L1 gap reformulation in Lean — result: proved-in-lean (4 min)
Worker (opus) defined `CatchUpDeep.gv` (mirrors `valueAux` with `R.attach.toList`) and proved
`valueAux_eq_gv` (s ≤ t → valueAux R s t false = gv R (t − s)), `valueAux_first_eq_gv`,
`value_eq_gv : value S = gv S 0`, plus helpers `gv_eq`, `gv_empty`, `gv_of_sum_lt`,
`best_eq_win_iff`, `best_eq_loss_iff`, `gv_eq_win_iff`.
Tried: strong induction on card, `rw [valueAux, gv]`, `congr 1; apply List.map_congr_left`, omega.
Blocked: nothing; one fix: omega needs `Finset.card_pos.mpr ⟨x, hx⟩` for `(R.erase x).card < n`.
Manager check: `lake build Solution` exit 0; grep for sorry/admit/axiom/native_decide/implemented_by/unsafe
finds only the `#print axioms` lines; axioms of `value_eq_gv`: propext, Classical.choice, Quot.sound.
Files: `Solution/Gap.lean`, `Solution.lean` (import line only).

### Manager computation (between attempts 1 and 2), `deep/catchup/gv.py` (independent Python gap solver)
- Sanity N = 0..14: DWWDDWWDDLLDDWL, agrees with F1.
- v({2,3,4,5}, 2) = W (confirms the base case of F4 by hand and by code: mover takes 4, lead 2;
  opponent at ({2,3,5}, 2) loses every reply).
- Equal-sum pairs (R = union of pairs {a, c−a} with a common sum c, g = 0 for even total, g = 1 for odd):
  121 of 632 such sets inside {1..14} are NOT draws (already {1,3} at g = 0, {1,4} at g = 1). Dead end.

### Attempt 2 — computational search for a closed family F (L6) — result: partial (8 min); L6 marked BLOCKED
Worker (opus), `deep/catchup/fam/` (solver `fam.c` checked against a Python reference on all of {1..10}, g ≤ 11, 0 mismatches).
Findings:
- (P) re-verified: 0 violations in 1,596 / 4,180 / 10,945 pair-unions inside {1..16} / {1..18} / {1..20}. (P3): 189 / 493 / 1,292 sets, all D.
- Hard case L4 has an explicit reply rule **r6** with 0 failures in all 29,581 hard-case positions inside {1..20}:
  mover (k odd, gap 1) takes the smaller a of {a,a+1}. If {2,3} is a pair of R and a ≥ 4: reply 2 (still behind,
  gap a−3), then a+1: lead 4, mover faces T4 = ({3} ∪ Q', 4) with Q' the k−2 remaining pairs inside {4..}.
  Otherwise reply a+1: mover faces T2 = (Q, 2) with Q the k−1 remaining pairs, no pair {2,3}.
  Plain a+1 fails 66 / 155 / 307 times (M = 16/18/20); every failure contains pairs {2,3},{4,5} and has a ≥ 6; the pre-pick 2 is the only pre-pick that always repairs it.
- T2: v(Q,2) ≤ D for every even pair-union Q without {2,3} inside {1..20} (4,180 sets: L 59, D 4,121, W 0).
  T4: v({3} ∪ Q', 4) = D for every odd pair-union Q' inside {4..20} (1,292/1,292); the k-even version of T4 is not D.
- But T2 and T4 do NOT close: 3,735 of 7,470 (T2) and 1,236 of 2,608 (T4) mover turns have no reply back into
  {pairs k even g=0, pairs k odd g=1, T2, T4} (M = 16). Their replies need pairs at gap 3 and pairs ∪ {s} shapes, and
  pairs at gap 3 have 45 W exceptions spread over 6 low patterns inside {1..18}; more at g ≥ 4.
- Parity-best table for pair-unions by gap (M = 20): only (g=0, k even) and (g=1, k odd) are 100 %; g=2 k even 98.2 %, g=3 k odd 93.5 %.
- "≥ D" half: requiring every opponent turn to land in the family fails for 797/797 (k even, g=0) and 784/799 (k odd, g=1) members at M = 16.
- Greedy closure of the "≤ D" certificate from the 232 pairs positions inside {1..12}: 1,866 members (355 of them L positions), singleton counts 0..5. No small family.
Manager check: `deep/catchup/r6check.py` (independent Python): hard cases inside {1..14}: 1,145; r1 fails 23; r6 fails 0; T2: 233 sets, 0 W; T4: 72 sets, all D. Agrees.
Files: `deep/catchup/fam/*` (hard.txt, gaps.txt, single.txt, closure.txt, logs).

**Decision D5 (manager).** The route through a small closed family is blocked: the "≤ D" side needs a family that grows
without a visible pattern (1,866 members inside {1..12}) and the "≥ D" side has no family at all. The pairs conjecture
(P) stays computed-only, but it is now reduced (on paper, with computation) to: T2, T4, the "≥ D" halves, and the
closure of T2/T4. No route to a full proof is left that I believe in within this run. The remaining time goes to the
strongest Lean record: the conjecture for N = 11, 12, 15, 16 by kernel-checked strategy certificates (D4), on top of the
reduction `catchup_of_pairsConj` (attempt 3). One more mathematical item is kept open for the write-up: whether the
Catch-Up value profile of {1..N} itself (F1 and the stage 1 gap profile) has a closed form.

### Attempt 3 — L2 reduction in Lean — result: proved-in-lean (2 min)
Worker (opus) wrote `Solution/Reduction.lean`: `PairStarts A := 0 ∉ A ∧ ∀ a ∈ A, a+1 ∉ A`,
`pairUnion A := A ∪ A.image (·+1)`, `PairsConj`, `PairsConj3` (as Props, open), `even_tri_iff`
(Even (N(N+1)/2) ↔ N%4 = 0 ∨ N%4 = 3), `Icc_eq_pairUnion_of_mod4_eq_0`, `Icc_eq_three_union_pairUnion`, and
`catchup_of_pairsConj : PairsConj → PairsConj3 → ∀ N, Even (N*(N+1)/2) → value (Icc 1 N) = .draw`.
Tried: N = 4q+r with interval_cases; set equalities by ext + parity split + omega. Blocked: nothing.
Manager check: build exit 0, no banned words, axioms propext/Classical.choice/Quot.sound; definitions read and match (P),(P3).
Files: `Solution/Reduction.lean`, `Solution.lean` (import line).

### Attempt 4 — certificate apparatus (`Solution/Cert.lean`) + N = 11, 12 — result: proved-in-lean (8 min)
Worker (opus): `gvL` (fuel list copy of `gv`), `gv_eq_gvL`, `value_Icc_eq_gvL`; `Cert`/`CertList` mutual inductive;
`chkGe`/`chkLe`/`chkLeList` (mutual structural recursion, Bool); `chkGe_sound : chkGe l g c = true → gvL n l g ≠ loss`,
`chkLe_sound : … → gvL n l g ≠ win` (induction on the fuel, cases on the certificate); `value_Icc_eq_draw_of_certs`.
`Solution/Cert11.lean`, `Solution/Cert12.lean`: generated minimal certificates (`deep/catchup/cert/gen.py`) and
`catchup_draw_11 : value (Icc 1 11) = .draw`, `catchup_draw_12 : value (Icc 1 12) = .draw` by `decide +kernel`.
Timings: kernel 3.3 s (N=11, both sides), 3.65 + 4.18 s (N=12); module builds 28 s / 75 s; about 0.65 ms per node.
Deviation (semantics unchanged): leaf cases use `l.isEmpty`; memberships use `decide (x ∈ l)`.
Manager check: `lake build Solution` exit 0 (8942 jobs); no banned words; `#print axioms` for both theorems: propext,
Classical.choice, Quot.sound; the root statements are checked at `List.range' 1 N`, gap 0, and chained through
`value_Icc_eq_gvL` and `gvL_eq_draw_of_certs`. Files: `Solution/Cert.lean`, `Solution/Cert11.lean`, `Solution/Cert12.lean`,
`deep/catchup/cert/gen.py`.
### Attempt 6 — partner-reply lemmas in Lean (`Solution/Pairs.lean`) — result: proved-in-lean (3 min)
Worker (opus): `mem_pairUnion`, `pairUnion_erase_erase` (removing a whole pair), `pairStarts_erase`, `zero_notMem_pairUnion`,
`gv_ne_loss_of_move` (one good move gives ≠ loss), `pairs_le_draw_of_gap_one` (L3: partner reply at gap 0),
`pairs_le_draw_of_gap_zero` (easy half of L4 + hard case as hypothesis), and
`pairsConj_le_halves : (∀ A odd, gv (pairUnion A) 1 ≠ loss) → (hard-case claim) → ∀ A, (Even → gv … 0 ≠ win) ∧ (Odd → gv … 1 ≠ win)`
by `Finset.strongInduction`. Tried: the paper proofs line by line. Blocked: nothing.
Manager check: `lake build Solution.Pairs` exit 0, no banned words, axioms propext/Classical.choice/Quot.sound, statements as specified.
Files: `Solution/Pairs.lean`; `Solution.lean` gets `import Solution.Pairs`.
### Attempt 8 — Lean: the hard-case claim follows from T2 and T4 — result: proved-in-lean (2 min)
Worker (opus), `Solution/Hard.lean`: `T2 : Prop := ∀ B, PairStarts B → Even B.card → 2 ∉ B → gv (pairUnion B) 2 ≠ win`,
`T4 : Prop := ∀ B, PairStarts B → Odd B.card → (∀ b ∈ B, 4 ≤ b) → gv (insert 3 (pairUnion B)) 4 ≠ win`,
`r6_set_eq` (set identity for the r6 landing), `hard_of_T2_T4 : T2 → T4 → ∀ A, PairStarts A → Odd A.card → ∀ a ∈ A, gv ((pairUnion A).erase a) (a−1) ≠ loss`,
`pairsConj_le_halves_of_T2_T4 : (∀ A odd, gv (pairUnion A) 1 ≠ loss) → T2 → T4 → ∀ A, (Even → gv … 0 ≠ win) ∧ (Odd → gv … 1 ≠ win)`.
Tried: the r6 case split, two `gv_ne_loss_of_move` steps. Blocked: nothing.
Manager check: `lake build Solution.Hard` exit 0, no banned words, axioms propext/Classical.choice/Quot.sound, T2/T4 read and match F8.
Files: `Solution/Hard.lean`; `Solution.lean` gets `import Solution.Hard`.
### Attempt 9 — computational search for a pick rule for the "≥ draw" half of (P) — result: partial (negative), 30 min
Worker (opus), `deep/catchup/gerule/` (solver `gr.c`, sanity table 0 mismatches at M = 20, 22; (P) 0 violations at M = 20, 22).
- Good-pick sets G(R) for all 10,945 (M=20) and 28,656 (M=22) pair-unions at the right gap. k even: |G| ≥ 2 always;
  k odd: 275 positions (M=20) / 522 (M=22) have a unique good pick.
- Rule a₁+1 (larger element of the lowest pair) fails 31/5,472 (k even) and 87/5,473 (k odd) at M=20; 68/14,327 and
  192/14,329 at M=22. NO exception contains the pair {2,3}; all have a₁ ≥ 5 and k ∈ {3,4,5,(6)}. Smallest: [6,8,10] G={9,10,11},
  [7,10,12] G={13}, [5,7,9,14] G={7,8,9,10}.
- Best refinement (rule B: if k ≥ 3 and a₃ ≤ 2a₁−2 take a₂+1 when a₂ = a₁+2 else a₃+1; else a₁+1): 3+3 failures at M=20,
  9+13 at M=22 — failures grow with M. For k = 3 the exceptions are exactly {a₃ ≤ 2a₁−2} minus 5 holes; the zone is not
  monotone in a₃ (a₁=11, a₂=15: a₃ = 17, 18, 20 exceptions, 19 not).
- Greedy decision list over {a_i, a_i+1}: inside {1..20} every position has a good pick in {a₁+1, a₃+1, a₂+1}; inside {1..22}
  three positions need a_k ([11,14,16,18,20] G={19,20,21}, [11,14,17,19,21] G={20,21,22}, [12,15,17,19,21] G={20,21,22}).
  So no rule picking from {a₁+1, a₂+1, a₃+1} is complete, and new families (runs of adjacent pairs [11,13,15,17,19,(21)]) appear with M.
Manager check: `deep/catchup/gecheck.py` (independent): G([7,10,12]) = {13}, G([6,8,10]) = {9,10,11}, G([7,9,12]) = {10,13},
G([5,7,9,14]) = {7,8,9,10}, G([8,10,12,14]) = {11..15}, G([1,5,8]) = {2}: all agree.
Conclusion: GE (L10) has no simple strategy; its exception structure is arithmetic. Recorded as a dead end for fixed rules.
### Attempt 7 — integrate the N = 15, 16 certificates in Lean — result: proved-in-lean (23 min)
Worker (opus): one module per root child (`Solution/Cert15/{Ge2..Ge15,Le1..Le15}.lean`, `Solution/Cert16/{Ge2..Ge16,Le1..Le16}.lean`),
each with the staged `def` and `theorem cert{N}{ge|le}_k_ok : chkGe <position> <gap> cert… = true := by decide +kernel`;
`Solution/CertRoot.lean` (helpers `chkGe_pick_of`, `chkLe_all_of`, `chkLeList_cons_ge`, `chkLeList_nil_of`) assembles the roots
without re-running children; `Solution/Cert15.lean`, `Solution/Cert16.lean` give `catchup_draw_15`, `catchup_draw_16`.
Timings: N=15 438 s wall under contention (Le1, 39 K nodes: 195 s); N=16 children in about 13 min wall as 3–4 serial queues
(Le1, 104 K nodes: 300 s; 56 K: 225 s; 40 K: 185 s); about 3 GB private memory per big module; 4–5 parallel big jobs thrashed the 15 GB machine.
Big N=16 defs are `noncomputable def` to skip the C compilation of huge terms (kernel checking is unchanged).
Manager check: `lake build Solution` exit 0 (9007 jobs); no banned words in any `Solution/Cert*` file; axioms of both theorems
propext/Classical.choice/Quot.sound; roots read: `cert16ge = .pick 1 (.all (keys 2..16))`, `cert16le = .all (keys 1..16)`, theorems
`value (Finset.Icc 1 15) = .draw`, `value (Finset.Icc 1 16) = .draw`. Files: as listed; staged copies removed (manifests kept).
### Attempt 5 — C generator for N = 15, 16 certificates — result: done (3 min)
Worker (opus), `deep/catchup/certgen/gen.c` (bottom-up over bitmask and gap, minimal sizes, emits Lean terms) and
`check.py` (independent Python implementation of the checkers with a parser; mutation-tested). Emitted and verified
`out/Cert{11,12,15,16}/`: ge root = `Cert.pick 1 (Cert.all cs)` with one `def cert{N}ge_k` per key k = 2..N (checked by
chkLe at (l−{1,k}, k−1)); le root = `Cert.all cs` with one `def cert{N}le_k` per key k = 1..N (checked by chkGe at (l−k, k)).
Node counts equal the manager's minimal sizes (F9). Largest children: N=15 ge 21,229 / le 39,243; N=16 ge 56,154 / le 104,181
(Le1). Source sizes: N=15 4.9 MB, N=16 13 MB. Max parenthesis depth 44 (N=15), 48 (N=16).
N = 19, 20 sizes computed: 4,476,241 / 6,673,524 and 12,797,969 / 19,075,858 nodes (280–800 MB of source): out of reach (D6).
Manager check: `deep/catchup/mycheck.py` (written independently): N=11 and N=12 roots pass chkGe/chkLe with nodes 2,097/3,129 and
4,937/7,442; N=15, 16 running in the background.
Files: `deep/catchup/certgen/{gen.c, check.py, out/Cert*/}`.

Decision D6: the Lean target is N ∈ {11, 12, 15, 16}; N = 19, 20 are not attempted (certificate too large for the kernel and the repo).

### Attempt 10 — final Lean assembly — result: proved-in-lean (3 min)
Worker (opus): `Solution/CertSmall.lean` (certificates for N = 3, 4, 7, 8 from `gen.py`, sizes 6/10, 11/18, 88/137, 189/285,
plus `catchup_draw_0`); `Solution/Final.lean`: `GE : Prop` (the "≥ draw" halves of (P)), `pairsConj_of_GE_T2_T4 : GE → T2 → T4 → PairsConj`,
`catchup_of_GE_T2_T4_P3 : GE → T2 → T4 → PairsConj3 → ∀ N, Even (N*(N+1)/2) → value (Icc 1 N) = .draw`,
`catchup_draw_le_16 : ∀ N ≤ 16, Even (N*(N+1)/2) → value (Icc 1 N) = .draw`; `Solution.lean` (appended):
`catchup_draw_iff_le_16 : ∀ N ≤ 16, value (Icc 1 N) = .draw ↔ Even (N*(N+1)/2)`.
Manager check: `lake build Solution` exit 0 (9009 jobs); no banned words in `Solution.lean` or `Solution/`; every `#print axioms`
(15 theorems) shows propext/Classical.choice/Quot.sound only. Files: `Solution/CertSmall.lean`, `Solution/Final.lean`, `Solution.lean`.

Ten attempts logged: stop condition reached at about 1791112100 (55 min after the start).

## 5. Dead ends

- (attempt 9) Fixed pick rules for the mover at pairs positions: a₁+1 fails on an arithmetic, non-monotone exception zone (a₁ ≥ 5, k ∈ {3,4,5,6}); refinements over {a₁+1, a₂+1, a₃+1} are incomplete at {1..22}. The ≥-draw half of (P) is not a short strategy.

- Equal-sum pairs ({a, c−a} with common sum c, mirror pairs included) are not a drawing family: 121 of 632 fail inside {1..14} (manager, `gv.py`). The stage 1 'mirror pairs inside {1..20} are draws' fact was specific to c = 21.

From stage 1:
- Fixed greedy strategies (largest / smallest / smallest catching pick) lose at N = 4 already.
- "The player behind gets the parity-best result" is false for general sets (F6).
- Balanced sets (#odd = #even), intervals {a..b}, general triples {t,t+1,t+2} ∪ pairs are not always draws.
- Kernel `decide` on the raw recursion stops at N = 8 (F7).
