# Catch-Up is a draw when the total is even

- id: `catchup`
- source: `.lake/packages/formal_conjectures/FormalConjectures/Paper/CatchUpConjecture.lean`
- theorem: `value_of_even_mul_succ_self_div_two`
- kind: other

## Lean statement (copied from the pinned source; the source file is the authority)

```lean
/--
Let $T_N = \sum_{k=1}^{N} k = \frac{N(N+1)}{2}$.
If $T_N$ is even (equivalently $N \equiv 0 \pmod 4$ or $N \equiv 3 \pmod 4$),
then under optimal play the game `Catch-Up($\{1, \ldots, N\}$)` ends in a draw.
-/
@[category research open, AMS 11 91]
theorem value_of_even_mul_succ_self_div_two
    (N : ℕ) (h_even : Even (N * (N + 1) / 2)) :
    value (.Icc 1 N) = .draw := by
  sorry
```

## Plain statement

Two players take turns grabbing numbers from 1..N into their own score; whoever is behind must keep grabbing until they catch up or pass; when the numbers run out the higher score wins. The claim: if 1+2+...+N is an even number, perfect play always ends in a draw.

## Definitions

Position = (remaining set R, mover's score s, opponent's score t, first-move flag). value(R,s,t,first): if R is empty -> win if s>t, loss if s<t, draw if equal. Else if s+sum(R) < t -> loss. Else best outcome (win>draw>loss) over x in R: let s'=s+x; if first: result = negate(value(R-x, t, s', false)); else if s' >= t: result = negate(value(R-x, t, s', false)); else (still behind, same player continues) result = value(R-x, s', t, false). Game value = value({1..N},0,0,true). negate swaps win/loss, keeps draw. Claim: N(N+1)/2 even => draw. Computed values: N=0..22 = draw,win,win,draw,draw,win,win,draw,draw,loss,loss,draw,draw,win,loss,draw,draw,win,loss,draw,draw,win,win.

## Checked so far (Python, 2026-10-04, not a proof)

Python memoised minimax implementing the Lean recursion exactly: all N<=22 checked; every N with N(N+1)/2 even (N=0,3,4,7,8,11,12,15,16,19,20) is a draw; one Python process: N=19 done after 45 s total, N=22 after 283 s total. No failure.

## Attack ideas

Extend exact search to N=23..30 (state = remaining set + score, with win cut-offs and bitboards in C/WASM), or find a pairing/strategy argument showing the second player can always force equal totals when the sum is even.

## Risks and notes

State space grows roughly 6x per extra N, so brute force stalls near N=30; a proof needs a strategy argument. Lean rules checked against the docstring (first move exactly one number; forced continuation while strictly behind; loss if cannot catch up): consistent.
