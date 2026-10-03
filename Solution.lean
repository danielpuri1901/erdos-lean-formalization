import FormalConjectures.Wikipedia.VizingConjecture

open SimpleGraph

theorem suen_tarr {α β : Type} [Fintype α] [Fintype β] [DecidableEq α] [DecidableEq β]
    (G : SimpleGraph α) (H : SimpleGraph β) :
    G.dominationNumber * H.dominationNumber + min G.dominationNumber H.dominationNumber ≤
      2 * (G □ H).dominationNumber := by
  sorry
