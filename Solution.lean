import FormalConjectures.GreensOpenProblems.«72»

/-! Solution for the trivial challenge: the statement holds by unfolding `Green72.NoKInLineFor`. -/

theorem challenge_trivial :
    Green72.NoKInLineFor 3 3 ↔ Green72.AllowedSetSize 3 3 = (3 - 1) * 3 :=
  Iff.rfl
