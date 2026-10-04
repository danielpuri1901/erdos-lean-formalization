# Notes: non-abelian Leinster group (S3 x C5)

## Argument
G := DihedralGroup 3 × Multiplicative (ZMod 5), order 30, non-abelian ((r 1,1) and (sr 0,1) do not commute).

Normal subgroups via "rational classes": a normal subgroup N is closed under conjugation and powers,
so g ∈ N ↔ rep (cls g) ∈ N, where cls : G → Fin 6 records (S3 class of the first coordinate: e / 3-cycle / reflection)
× (C5 part trivial or not), and rep i is a fixed representative.
Check by `decide`: for every g there are x and k with x * g^k * x⁻¹ = rep (cls g), and y, j with y * rep(cls g)^j * y⁻¹ = g.

So N is determined by the bit vector v i := (rep i ∈ N), and v is "good": v (cls 1) = true and
v (cls a) → v (cls b) → v (cls (a*b)). A kernel check over the 64 bit vectors shows exactly 6 are good.
Conversely each good v gives a normal subgroup {g | v (cls g)} (closure by decide; normality since cls is
conjugation invariant; inverses since cls g⁻¹ = cls g).
Bijection Fin 6 → {N // N.Normal}; sum of cards = 1+3+6+5+15+30 = 60 = 2*30.

## Plan
1. Definitions G, cls, rep, good (Bool checker), mkN.
2. Lemmas: cls_inv, cls_conj, rep_witness (decide), classification (decide over 6 Bools).
3. Bijection and the sum; final theorem.

## Decisions
- Chose the class-vector approach instead of the coprime product decomposition: all finite checks are tiny (≤ 64 × 900).

## Status
- `Solution/Leinster.lean`: all finite checks (`decide +kernel`, each a few seconds, module builds in ~12 s) and the
  bijection Fin 6 → {N // N.Normal}; `Solution.lean` proves `leinster_nonabelian_exists` from it.
- Axioms: propext, Classical.choice, Quot.sound. Submitted with a `submit(leinster):` commit.
