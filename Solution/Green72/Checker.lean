import Solution.Green72.Witnesses

/-! A kernel-friendly no-three-in-line checker for the Green 72 witnesses.

The recursions are written with `List.rec` and `Bool.rec` and the arithmetic with `Nat.add`,
`Nat.mul` and `Nat.beq`, so `decide +kernel` spends its time on GMP arithmetic instead of
unfolding instances and structural-recursion compilations. For a pair `p, q` the two products
`p.1 * q.2` and `q.1 * p.2` are passed in once and shared by every third point `r`. -/

namespace Green72Proof

/-- `true` iff no `r ∈ l` satisfies the collinearity equation with the pair
`(x1, y1), (x2, y2)`, where `c1 = x1 * y2` and `c2 = x2 * y1`. -/
noncomputable def allOk (x1 x2 y1 y2 c1 c2 : Nat) (l : List (Nat × Nat)) : Bool :=
  l.rec true (fun r _ ih =>
    Bool.rec ih false (Nat.beq (Nat.add (Nat.add (Nat.mul r.2 x2) (Nat.mul r.1 y1)) c1)
                               (Nat.add (Nat.add (Nat.mul r.2 x1) (Nat.mul r.1 y2)) c2)))

/-- `true` iff no `q, r` in this order in `l` are collinear with `p`. -/
noncomputable def pairsOk (p : Nat × Nat) (l : List (Nat × Nat)) : Bool :=
  l.rec true (fun q rest ih =>
    Bool.rec false ih (allOk p.1 q.1 p.2 q.2 (Nat.mul p.1 q.2) (Nat.mul q.1 p.2) rest))

/-- `true` iff no three points of `l`, taken in list order, are collinear. -/
noncomputable def noThree (l : List (Nat × Nat)) : Bool :=
  l.rec true (fun p rest ih => Bool.rec false ih (pairsOk p rest))

/-- Everything the proof needs about a witness for the `n` by `n` grid. -/
noncomputable def check (n : Nat) (l : List (Nat × Nat)) : Bool :=
  Nat.beq l.length (2 * n) && Green72Data.inGrid n l && decide l.Nodup && noThree l

end Green72Proof
