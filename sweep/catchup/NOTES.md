# Sweep notes: catchup

```
result: partial
claim: (1) value (Finset.Icc 1 N) = .draw for every N ≤ 8 with N*(N+1)/2 even (N = 0,3,4,7,8);
       (2) for every N, value (Finset.Icc 1 N) = .draw → Even (N*(N+1)/2) (the converse direction);
       (3) hence for N ≤ 8: draw ↔ N*(N+1)/2 even.  The conjecture itself (all N) is NOT proved.
lean: Solution.lean, namespace CatchUpSweep, builds with no sorry (axioms: propext,
      Classical.choice, Quot.sound): catchup_draw_le_8, catchup_draw_0/3/4/7/8,
      value_ne_draw_of_odd, catchup_draw_iff_le_8, valueAux_draw_even, valueAux_eq_valL
      (bridge from valueAux to a computable list version), value_Icc_eq_valL, best_eq_bestSpec.
computed: conjecture true for every N ≤ 28 (exact C search `catchup.c`, values for N ≤ 22
      identical to the problem file's Python run; N = 23,24,27,28 draw).
      New "pairs conjecture" (below) true for all 75,024 unions of disjoint pairs {a,a+1}
      inside {1..24}, and for all sets {1,2,3} ∪ pairs (a ≥ 4) inside {1..24}; re-checked by an
      independent Python implementation of the literal Lean recursion inside {1..14} (754 sets).
next idea: Prove the pairs conjecture: for R a disjoint union of k pairs {a,a+1},
      v(R,0) = D if k even and v(R,1) = D if k odd (plus the {1,2,3} ∪ pairs variant); it
      implies the Catch-Up conjecture at once ({1..4m} = 2m pairs; {1..4m+3} = {1,2,3} ∪ 2m pairs).
      At gap ≤ 1 a turn is a single pick, and the partner reply (take the other element of the
      pair) returns to a pairs position in 3 of 4 cases, which proves the "≤ D" half modulo one
      case (k odd, mover takes the smaller element a). That case and the "≥ D" half need a
      larger family; every exception found so far lives at the bottom pairs {2,3},{4,5}
      (see "Attempted proof"), so a "generic pairs + finitely many low configurations"
      induction looks like the way in.
dead ends: fixed greedy strategies (largest / smallest / smallest catching pick / mixtures)
      lose already at N = 4 for both players; "the player behind gets the parity-best result"
      fails for 24–43 % of general positions; balanced sets (#odd = #even) are not draws
      (1,617 of 12,869 fail inside {1..16}); intervals {a..b} are not draws; general triple
      {t,t+1,t+2} ∪ pairs is not; kernel `decide` without memoisation stops at N = 8
      (N = 11 needs 15 M nodes; sorting the pre-picks of a turn saves only ~20 %).
confidence: high for the Lean results (full build, no sorry, standard axioms only); high for
      the computations (two independent implementations agree on overlapping ranges);
      low that the pairs approach closes quickly.
```

start: 1791105017 (date -u +%s)

## Phase A: understand

### Statement in my own words
`value (Finset.Icc 1 N) = valueAux (Icc 1 N) 0 0 true`. Claim: if `N*(N+1)/2` is even
then this value is `.draw`.

### Definitions (read from `.lake/packages/formal_conjectures/FormalConjectures/Paper/CatchUpConjecture.lean`)
- `Outcome` = win | loss | draw; `Outcome.neg` swaps win/loss, fixes draw.
- `Outcome.best os = os.foldl F .loss` with F(acc,o) = win if acc or o is win, else draw if
  acc or o is draw, else loss. So `best` is the maximum for loss < draw < win, order-independent;
  `best [] = loss` (never used on an empty list: `best` is only reached when `remaining ≠ ∅`).
- `valueAux R s_me s_opp first`:
  - `R = ∅`: win if s_me > s_opp, loss if s_opp > s_me, draw otherwise.
  - else if `s_me + ∑ R < s_opp`: loss.
  - else best over x ∈ R of: let s' = s_me + x, R' = R.erase x;
    if `first` or `s' ≥ s_opp`: `(valueAux R' s_opp s' false).neg` (turn passes),
    else `valueAux R' s' s_opp false` (same player continues).
- `value S = valueAux S 0 0 true`.

### Reformulation used by my code
Write g = s_opp - s_me. From the start (0,0) the current player always has s_me ≤ s_opp
(the turn passes only when the mover has caught up, so the new mover is the one who is behind
or tied). Hence the state is (R, g) with g ≥ 0, and
  v(R,g) = loss if R = ∅ and g > 0; draw if R = ∅ and g = 0; loss if ∑R < g;
  otherwise max over x ∈ R of ( x ≥ g ? neg v(R−x, x−g) : v(R−x, g−x) ).
The first-move flag is redundant here: at g = 0 every pick x ≥ 1 already ends the turn
(this needs 0 ∉ S, true for `Icc 1 N`). Also g ≤ N always (a new gap is x − g ≤ x ≤ N).

### Edge cases
- N = 0: `Icc 1 0 = ∅`, T = 0 even, value = draw (scores 0 = 0). Consistent.
- `N*(N+1)/2`: N(N+1) is always even, so the ℕ division is exact; `Even` ⇔ N ≡ 0,3 (mod 4).
- `best` of empty list never used. No `sInf`/`sSup`. ℕ subtraction is not used in the definition.
- Draw needs equal final scores, so with T odd a draw is impossible; the conjecture says the
  parity obstruction is the only one.

### Red team
- A multi-pick turn is modelled as consecutive single picks by the same player, with every
  intermediate score strictly behind; this is the same as choosing the whole turn at once.
- "cannot catch up ⇒ takes everything and loses" is the `∑R < g ⇒ loss` rule; a mover who
  takes the last number while still behind reaches `R = ∅, g > 0 ⇒ loss`. Consistent.
- Tied start of a turn (g = 0): one pick, then the turn passes. Matches the docstring rule.

statement check: matches

### Reproduction
`sweep/catchup/catchup.c` (C, dense 2-bit memo table over (mask, g)), independent from the
Python run in the problem file. Values N = 0..22 agree exactly with the problem file:
draw,win,win,draw,draw,win,win,draw,draw,loss,loss,draw,draw,win,loss,draw,draw,win,loss,draw,draw,win,win.
Whole run N = 0..22 took 5.5 s.

## Phase B: try to break it

Exact search with `catchup.c` (same recursion as `valueAux`, dense memo over (mask, gap),
win cut-off). `timeout 1500 ./catchup 23 29`, log in `run23_29.log`:
- N=23 draw (95,871,146 states), N=24 draw (200,426,887), N=25 win (T odd), N=26 win (T odd),
  N=27 draw (1,809,049,015 states).
- So the conjecture holds for every N ≤ 27 (by computer, C, not a proof). N=28 running (see report).
- N=29, 30 have odd T; N=31 needs a 17 GB table at 2 bits/entry, beyond this 15 GB machine,
  so N ≤ 28 is the frontier for this method in this session.

Simple-strategy test (`strat.c`): fixed strategies "largest", "smallest catching pick else
largest", "smallest", and two mixtures, each played as P1 and as P2 against an optimal
opponent for N ∈ {3,4,7,8,11,12,15,16}: every one of them LOSES already at N = 4 (only N = 3
survives). So no simple greedy rule gives either player the draw; a proof cannot be a
one-line greedy strategy.

Naive search tree size (no memo, win cut-off, increasing pick order, `count.c`):
N=7: 3,455 nodes, N=8: 43,341, N=11: 14.8 M, N=12: 160 M. So kernel evaluation without
memoisation is feasible up to N = 8 only.

## Phase C: proof attempts

### What is proved in Lean (`Solution.lean`, namespace `CatchUpSweep`, builds, no sorry,
axioms propext / Classical.choice / Quot.sound only)
- `best_eq_bestSpec`, `best_congr`: `Outcome.best` = max, depends only on membership.
- `valL`: structurally recursive copy of `valueAux` on lists.
- `valueAux_eq_valL`: if `R.val = ↑l` and `l.length = n` then `valueAux R s t b = valL n l s t b`.
  Paper proof: unfold both one step; empty/sum/erase agree; `best` of the two child lists
  agree because they contain the same outcomes (induction hypothesis on `l.erase x`).
- `value_Icc_eq_valL`: `value (Icc 1 N) = valL N (List.range' 1 N) 0 0 true`.
- `catchup_draw_0/3/4/7/8` by `decide +kernel` on `valL` (N = 8 ≈ 30 s), and
  `catchup_draw_le_8`: the conjecture for every N ≤ 8.
- `valueAux_draw_even`: a position with value draw has `s + t + ∑R` even
  (induction on `card R`: a draw value needs a draw child, and taking x moves x from ∑R to a score).
- `value_ne_draw_of_odd`: if `N*(N+1)/2` is odd then `value (Icc 1 N) ≠ draw` (all N).
- `catchup_draw_iff_le_8`: for N ≤ 8, draw ⇔ `N*(N+1)/2` even.

### Mathematics: structure found by computation

1. Gap profile of the full set (`profile.c`, N ≤ 20): for R = {1..N} and 2 ≤ g ≤ N the value
   v(R,g) is the parity-best outcome (D if T−g even, W if T−g odd), with exactly three
   exceptions: N = 5, g = 3 and g = 5 (W instead of D) and N = 13, g = 2 (L instead of W)
   (rechecked programmatically from `profile20.txt`). For general subsets this is false: over all R ⊆ {1..14}, 24–43 % of
   positions with gap g ≥ 1 are not parity-best (`parity.c`). So there is no
   "the player behind always gets the parity-best result" lemma for arbitrary sets.
2. First moves (`firstmove.c`, N ≤ 22): for T even and N = 8 or N ≥ 12 *every* first move
   of P1 leads to a draw; for N = 3, 4, 7, 11 some first moves lose for P1 (P2 wins).
   For T odd and N ≥ 9, P2 wins after all first moves except at most one small y ∈ {1,2,3}.
3. Structured families (`family.c`, inside {1..20}, g = 0, even sum): every union of aligned
   pairs {2k−1,2k}, every union of mirror pairs {k,21−k}, every union of blocks {4j+1..4j+4}
   is a draw; intervals {a..b} are not (68 D, 32 W).
4. **Pairs conjecture (new, computed only).** Let R be a disjoint union of k pairs {a, a+1}
   (a ≥ 1, pairs arbitrary, not necessarily aligned). Then
   v(R,0) = D if k is even, and v(R,1) = D if k is odd.
   Variant: the same with R = {1,2,3} ∪ (k pairs with a ≥ 4).
   Checked (`pairs2.c`, `triple.c`): all 28,656 pair-unions inside {1..22}: 0 violations;
   all 3,383 sets {1,2,3} ∪ pairs inside {1..22}, for both (k even, g=0) and (k odd, g=1): all D.
   Extended (`pairs2.c` with M = 24): all 75,024 pair-unions inside {1..24}: 0 violations.
   Wrong parity gives no draw, as it must (D impossible by parity).
   General triples {t,t+1,t+2} ∪ pairs are NOT always draws (~4 % W), so {1,2,3} is special.
5. **Reduction (paper proof, trivial).** Pairs conjecture ⇒ Catch-Up conjecture:
   N ≡ 0 (mod 4): {1..N} = {1,2} ∪ {3,4} ∪ … ∪ {N−1,N}, k = N/2 even, g = 0 → draw.
   N ≡ 3 (mod 4): {1..N} = {1,2,3} ∪ {4,5} ∪ … ∪ {N−1,N}, k = (N−3)/2 even, g = 0 → draw.
   Also: pairs conjecture with k odd, g = 1 alone already gives "P1 can secure ≥ draw" for
   N ≡ 3 (mod 4): P1 takes 1, leaving {2,3} ∪ … ∪ {N−1,N}, an odd number of pairs at gap 1.
   Decision: I did not formalize this reduction in Lean; it is an instantiation, and the time
   was better spent on the evidence for the pairs conjecture.

### Attempted proof of the pairs conjecture (incomplete)

Key fact: when the gap is g ≤ 1 the mover takes exactly ONE number (every number is ≥ 1 ≥ g).
So from a pairs position the mover takes one x from a pair {a, a+1}; the other player then
faces gap x − g with the partner of x still available. Write G(k) for the claim at k pairs.

Lemmas and status:
- L1 (proved on paper): value depends only on (R, gap); mid-turn and start-of-turn positions
  with the same (R, gap) have the same value; first-move flag irrelevant when 0 ∉ R.
- L2 (proved on paper, uses G(k−1) in both directions): k even, g = 0 ⇒ v(R,0) ≤ D.
  Partner reply: if the mover takes a, reply a+1 (lead 1; the mover then faces k−1 odd pairs
  at gap 1, value D); if the mover takes a+1, reply a (still behind by 1, mid-turn at k−1
  odd pairs and gap 1, value D for the replier).
- L3 (partial): k odd, g = 1 ⇒ v(R,1) ≤ D. If the mover takes a+1, reply a ties and leaves
  k−1 even pairs at gap 0 (value D). If the mover takes a, the gap is a−1 and the natural reply
  a+1 leads by 2 to (R∖{a,a+1}, 2), which is not a pairs position; computed (`gmoves.c`,
  inside {1..20}): this reply secures ≥ D in 29,274 of 29,581 cases, so 307 cases need
  another reply. **Unknown** how to close.
- L4 (unknown): the mover in a pairs position can secure ≥ D. Needs a good first pick and a
  reply to every opponent turn. Computed (`gmoves.c`, `grule.c`, inside {1..20}): after a
  single pick of the mover the other player never gets less than D (consistent with L2/L3),
  and gets W after about 39 % of the picks, so the mover must choose. Fixed rules:
  "take a1+1, the larger element of the lowest pair" draws in 5441/5472 (k even) and
  5386/5473 (k odd) positions,
  "take the smallest number" in 4915 / 4592; none is always right.
So the pairs family is not closed under the obvious replies; a proof needs a larger family
that also contains positions like (pairs, gap 2) and (pairs ∪ {one singleton}, gap a−1).

Exceptions in the hard case (`g2ex.c`, `hard.c`, inside {1..18} / {1..20}): the 24 even
pair-unions Q with v(Q,2) = W all contain the pairs {2,3} and {4,5}; in the 307 cases where
the reply a+1 fails, the shown examples all contain {2,3},{4,5}, and the replier instead starts
with a small pre-pick from {2,3,4,5} (failures by a: a = 6..19, 15–38 each).

## Phase D

Stopped at about minute 20 of 60 (`date -u +%s` = 1791106130 at the last computation): the
remaining gap is a genuine research step (a closed strategy family), not more computation.
The N = 29 run was stopped by hand after N = 28 (N = 29, 30 have odd T; N = 31 needs 17 GB).
