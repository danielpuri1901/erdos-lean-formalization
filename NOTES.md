# NOTES: snakeupper (snake in Q_n has at most 2^(n-1) edges)

Session of 2026-10-04, branch `run/snakeupper`.

## Target

`theorem snake_le_two_pow : type_of% @SnakeInBox.snake_upper_bound`, i.e.
`∀ n, 1 ≤ n → LongestSnakeInTheBox n ≤ 2 ^ (n - 1)`.
`LongestSnakeInTheBox n = sSup {k | ∃ S, IsSnakeInGraphOfLength (Hypercube n) S k}` in `ℕ`.
Since `sSup` in `ℕ` is `0` for an unbounded set, the bound needs each length bounded (true: a path has fewer edges than the cube has vertices) and then `csSup_le`.

## Computation (scratch Python, not committed)

Exhaustive search over induced paths from vertex 0:

| n | max snake length | bound 2^(n-1) |
|---|------------------|---------------|
| 1 | 1 | 1 |
| 2 | 2 | 2 |
| 3 | 4 | 4 |
| 4 | 7 | 8 |
| 5 | 13 | 16 |
| 6 | 26 | 32 |

This matches the TASK values 1, 2, 4, 7. The bound is tight for n = 1, 2, 3.

## Paper argument: status

I found no complete argument within the 10-minute limit.
Below are the reformulations I found, each verified on paper, and the conjectured lemmas that would close the proof, checked by computer.

Notation: snake `S = {v_0, ..., v_k}` (induced path), `d_t` = direction of edge `v_{t-1} v_t`, `T` = vertices not in `S`.

1. Facts that hold:
   - `d_t ≠ d_{t+1}` (path) and `d_t ≠ d_{t+2}` (induced), so any three consecutive directions are distinct.
   - Projection along direction `i` is injective on `S` except on the `m_i` snake edges in direction `i`, so `|S| ≤ 2^(n-1) + m_i`.
     If some direction is used at most once the theorem follows at once.
   - Between two consecutive `i`-edges the snake runs at least 2 edges inside one half.
2. Invariant: for every perfect matching `M` of `Q_n`,
   `#(M-edges inside S) − #(M-edges inside T) = |S| − 2^(n-1)`.
   So the theorem is equivalent to finding one perfect matching with `#full ≤ #empty + 1`.
   For the direction-`i` matching this says: (number of snake edges in direction `i`) ≤ (number of direction-`i` edges disjoint from `S`) + 1.
   Averaging over directions is circular (it is equivalent to the theorem).
3. Parity form: for `n ≥ 2` the theorem is equivalent to `|S ∩ C| ≤ 2^(n-2)`, where `C` is the colour class of `v_1`.
   Coils violate this at n = 3 (a 6-cycle in Q_3), so any proof must use the endpoints.
4. Generalisation, true by exhaustive check for n = 2, 3, 4: every induced linear forest `F` in `Q_n` has matching number `≤ 2^(n-2)`.
   The obvious induction (split along one direction) does not close: restricting to halves loses the crossing edges.
5. Hall form, true by exhaustive check for every snake and every direction for n = 4, 5:
   in `Q_{n-1}`, the projections of the `i`-crossings, all but one of them, can be matched injectively to adjacent empty `i`-fibres.
   Each internal crossing has exactly `n − 3` adjacent empty fibres (directions other than `i` and the two neighbouring edge directions).
   I found no explicit injection.
   The local choice "fourth corner of the next turn" fails on the pattern `a i b a`.

## Decision

TASK says: without a paper argument after 10 minutes, prove the strongest partial statement in Lean, write what is missing, and stop.
Partial statement chosen (all n, no extra hypotheses):

- every snake in `Hypercube n` has length `< 2^n` (a path has fewer edges than the graph has vertices);
- the set of snake lengths is bounded above;
- `LongestSnakeInTheBox n ≤ 2^n − 1` for every `n`;
- the target for `n = 1` (`2^1 − 1 = 2^0`).

## Plan

1. Skeleton in `Solution.lean` with these lemmas as `sorry`; build.
2. Fill: `Walk.IsPath.length_lt`, `Fintype.card (Finset (Fin n)) = 2^n`, `csSup_le'`/`Nat.sSup_le`-style lemma.
3. Main theorem: case `n = 1` from the general bound; case `n ≥ 2` stays `sorry`.
   No `submit(snakeupper):` commit, because the proof is incomplete.
