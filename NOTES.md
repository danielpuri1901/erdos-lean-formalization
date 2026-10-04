# dean3 notes

## Target

`dean_three : type_of% @Arxiv.«2605.02731».dean_conjecture.variants.three`:
every finite graph with `3 ≤ G.minDegree` has a cycle (`G.cycleLengths`) of length divisible by 3.

## Paper argument (time-boxed to 15 minutes): not found

What I checked in the time box:

1. Longest path `P = v_0 … v_n`. All neighbours of `v_0` lie on `P`, at indices
   `1 = i_1 < i_2 < … < i_d`, `d ≥ 3`. The cycles `v_0 v_1 … v_j v_0` (length `j+1`, `j ≥ 2`)
   and `v_0 v_i … v_j v_0` (length `j-i+2`, `i < j`) avoid `0 mod 3` exactly when
   every index `j ≢ 2 (mod 3)` and for `i < j`, `j - i ≢ 1 (mod 3)`, i.e. the residues of the
   indices read `1,…,1,0,…,0`. Example `1,4,7` passes, so the fan alone does not settle the claim.
2. Subdivided `K_4` (Dirac: `δ ≥ 3` gives one): a brute force over the residues of the six
   branch-path lengths found 42 of 729 patterns with all seven cycles `≢ 0 (mod 3)`, so a
   `K_4` subdivision alone does not settle it either.
3. A promising route I could not finish: two internally disjoint `x`–`y` pieces, each with two
   `x`–`y` paths of different length mod 3, always give a cycle `≡ 0 (mod 3)` (two 2-subsets of
   `Z/3` meet). Getting such pieces needs the Bondy–Vince/Fan path lemma (2-connected `H`, all
   vertices but `x,y` of degree `≥ 3` ⇒ two `x`–`y` paths whose lengths differ by 1 or 2) plus an
   end-block decomposition. Neither the full argument nor a Lean-sized version of it fits the budget
   (40 minutes in total, and Mathlib has no block decomposition).

Decision: per TASK.md, prove the strongest partial statement I can in Lean, the longest-path fan
lemma of item 1, and record what is missing.

## Partial statement to formalize (`Solution.lean`)

`dean_three_fan`: if `3 ≤ G.minDegree` then either some cycle length is divisible by 3, or there is a
longest path `p : G.Walk a b` (no path is longer) such that every neighbour `w` of `a` equals
`p.getVert i` for some `1 ≤ i ≤ p.length` with `i % 3 ≠ 2`, and for any two neighbours at indices
`i < j`, `(j - i) % 3 ≠ 1`.

Lean plan:

- `exists_longest_path`: `Nat.findGreatest` over path lengths below `Fintype.card V`.
- `nbr_mem_support`: a neighbour of the end `a` off the path extends it (`Walk.cons`, `IsPath.cons`).
- `seg`: for a path `p` and `i ≤ j ≤ p.length`, a path `p.getVert i → p.getVert j` of length `j - i`
  whose support is `{p.getVert k | i ≤ k ≤ j}` (`Walk.drop`, `Walk.take`).
- `fan_cycle`: for `1 ≤ i < j ≤ p.length` with `a ~ v_i`, `a ~ v_j`: `j - i + 2 ∈ G.cycleLengths`
  (cycle `a → v_j → … → v_i → a`, `Walk.cons_isCycle_iff`). With `i = 1` this gives `j + 1`.

## What is missing for the full theorem

The combinatorial core of Chen–Saito: a reason why the fan pattern `1,…,1,0,…,0` (mod 3) cannot hold
for every longest path / every end block of a graph with minimum degree 3. None of that is in Lean.
