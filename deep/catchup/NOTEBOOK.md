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

1. L1 gap reformulation `valueAux_eq_gv`, `value_eq_gv`. [proved on paper (stage 1 + above); Lean: open]
2. L2 reduction: (P) ∧ (P3) ⇒ target, stated in Lean with (P),(P3) as hypotheses. [proved on paper; Lean: open]
3. L3 (P) "≤ draw" half for k even, g = 0, from the k−1 case: partner reply.
   [proved on paper in stage 1, not reviewed; Lean: open]
4. L4 (P) "≤ draw" half for k odd, g = 1: mover takes a+1 → reply a, ties, k−1 even pairs at gap 0;
   mover takes a (smaller) → reply unknown (natural reply a+1 fails in 307 of 29,581 cases). [open, key]
5. L5 (P) "≥ draw" halves (mover has a good pick). No fixed rule works. [open, key]
6. L6 a closed strategy family F ⊇ pairs positions on which an induction closes L4 and L5. [open, key]

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
- F7. Kernel evaluation without memoisation: N = 8 (43 K nodes) takes 30 s; N = 11 needs 15 M nodes.

## 4. Attempts

(none yet)

## 5. Dead ends

From stage 1:
- Fixed greedy strategies (largest / smallest / smallest catching pick) lose at N = 4 already.
- "The player behind gets the parity-best result" is false for general sets (F6).
- Balanced sets (#odd = #even), intervals {a..b}, general triples {t,t+1,t+2} ∪ pairs are not always draws.
- Kernel `decide` on the raw recursion stops at N = 8 (F7).
