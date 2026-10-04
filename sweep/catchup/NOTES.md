# Sweep notes: catchup

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
