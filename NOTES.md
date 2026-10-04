# NOTES: triplespow (`maximalLength_pow`)

## Argument

Let S n be the set whose `sSup` is F n = `maximalLength n`.
For n ≥ 2, S n is bounded by n^2 (pigeonhole lemma `exists_pair_of_mem_Icc`, as in
`SqTuples.bdd` on `origin/run/sqtuples`) and contains 0, so `Nat.sSup_mem` gives a list
of length F n in S n.

Product lemma (a, b ≥ 2): F a * F b ≤ F (a * b).
Take s ∈ S a, t ∈ S b of maximal length and put
  comb b x y k = (x k - 1) * b + y k,
  P = s.flatMap (fun x => t.map (comb b x)).
- Entries: with 1 ≤ u ≤ a, 1 ≤ v ≤ b we get 1 ≤ (u - 1) b + v ≤ a b.
- Same x, y <₂ y': in the two coordinates where y grows, comb grows.
- x <₂ x' (x earlier in s): in a coordinate with u < u', (u-1) b + v ≤ u b ≤ (u'-1) b < (u'-1) b + v'.
- `List.pairwise_flatMap` and `List.pairwise_map` give `IsIncreasing₂ P`; length = |s| |t|.
Then `le_csSup` with the bound for a b ≥ 2.

Powers: F n ^ (k+1) ≤ F (n^(k+1)) by induction, using the product lemma with n^(k+1), n ≥ 2.

Main: `Filter.frequently_atTop`: for each A take m = n^(A+1) ≥ A.
(m : ℝ)^e = ((n:ℝ)^e)^(A+1) = (F n)^(A+1) ≤ F m (rpow/pow commute for n ≥ 0).

## Plan

1. `S`, `bdd`, `exists_max` (list of length F n for n ≥ 2).
2. `comb`, `P`, `length_P`, `range_P`, `pairwise_P`.
3. `prod_le`, `pow_le`, main theorem.
