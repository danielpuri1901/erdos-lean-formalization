/-- Nat-only collinearity test: three points are collinear iff the cross terms agree. -/
def collinear3 (p q r : Nat × Nat) : Bool :=
  p.1 * q.2 + q.1 * r.2 + r.1 * p.2 == p.1 * r.2 + q.1 * p.2 + r.1 * q.2

/-- True iff no three points of the list are collinear. -/
def noThree : List (Nat × Nat) → Bool
  | [] => true
  | p :: rest => pairsOk p rest && noThree rest
where
  pairsOk (p : Nat × Nat) : List (Nat × Nat) → Bool
    | [] => true
    | q :: rest => allOk p q rest && pairsOk p rest
  allOk (p q : Nat × Nat) : List (Nat × Nat) → Bool
    | [] => true
    | r :: rest => !collinear3 p q r && allOk p q rest

def inGrid (n : Nat) (l : List (Nat × Nat)) : Bool := l.all fun p => p.1 < n && p.2 < n
