import FormalConjectures.Paper.ClaudesCycles

/-! Finite model of the cube digraph for `m = 2` on `Fin 8`, and the kernel check that no three
pointwise-distinct direction tables all give Hamiltonian cycles. -/

namespace CC2

/-- `flipT b n` flips bit `b` of `n`. -/
def flipT (b : Fin 3) (n : Fin 8) : Fin 8 :=
  ![![1, 0, 3, 2, 5, 4, 7, 6], ![2, 3, 0, 1, 6, 7, 4, 5], ![4, 5, 6, 7, 0, 1, 2, 3]] b n

/-- One step along the direction table `t`. -/
def step (t : Fin 8 → Fin 3) (n : Fin 8) : Fin 8 := flipT (t n) n

/-- The first `k` points of the orbit of `x`. -/
def orb (t : Fin 8 → Fin 3) : Nat → Fin 8 → List (Fin 8)
  | 0, _ => []
  | k + 1, x => x :: orb t k (step t x)

/-- The orbit of `0` under `step t` visits every vertex within 8 steps. -/
def Ham (t : Fin 8 → Fin 3) : Prop := ∀ y : Fin 8, y ∈ orb t 8 0

instance (t : Fin 8 → Fin 3) : Decidable (Ham t) :=
  inferInstanceAs (Decidable (∀ y : Fin 8, y ∈ orb t 8 0))

set_option synthInstance.maxHeartbeats 0 in
set_option synthInstance.maxSize 100000 in
theorem key : ∀ a0 a1 a2 a3 a4 a5 a6 a7 : Fin 3, Ham ![a0, a1, a2, a3, a4, a5, a6, a7] →
    ∀ b0, b0 ≠ a0 → ∀ b1, b1 ≠ a1 → ∀ b2, b2 ≠ a2 → ∀ b3, b3 ≠ a3 →
    ∀ b4, b4 ≠ a4 → ∀ b5, b5 ≠ a5 → ∀ b6, b6 ≠ a6 → ∀ b7, b7 ≠ a7 →
    Ham ![b0, b1, b2, b3, b4, b5, b6, b7] →
    ∀ c0, c0 ≠ a0 → c0 ≠ b0 → ∀ c1, c1 ≠ a1 → c1 ≠ b1 → ∀ c2, c2 ≠ a2 → c2 ≠ b2 →
    ∀ c3, c3 ≠ a3 → c3 ≠ b3 → ∀ c4, c4 ≠ a4 → c4 ≠ b4 → ∀ c5, c5 ≠ a5 → c5 ≠ b5 →
    ∀ c6, c6 ≠ a6 → c6 ≠ b6 → ∀ c7, c7 ≠ a7 → c7 ≠ b7 →
    ¬ Ham ![c0, c1, c2, c3, c4, c5, c6, c7] := by
  decide +kernel

theorem eta8 (a : Fin 8 → Fin 3) : a = ![a 0, a 1, a 2, a 3, a 4, a 5, a 6, a 7] := by
  funext i; fin_cases i <;> rfl

theorem no_three (a b c : Fin 8 → Fin 3) (hab : ∀ n, a n ≠ b n) (hac : ∀ n, a n ≠ c n)
    (hbc : ∀ n, b n ≠ c n) (ha : Ham a) (hb : Ham b) (hc : Ham c) : False := by
  rw [eta8 a] at ha
  rw [eta8 b] at hb
  rw [eta8 c] at hc
  exact key _ _ _ _ _ _ _ _ ha
    _ (hab 0).symm _ (hab 1).symm _ (hab 2).symm _ (hab 3).symm
    _ (hab 4).symm _ (hab 5).symm _ (hab 6).symm _ (hab 7).symm hb
    _ (hac 0).symm (hbc 0).symm _ (hac 1).symm (hbc 1).symm _ (hac 2).symm (hbc 2).symm
    _ (hac 3).symm (hbc 3).symm _ (hac 4).symm (hbc 4).symm _ (hac 5).symm (hbc 5).symm
    _ (hac 6).symm (hbc 6).symm _ (hac 7).symm (hbc 7).symm hc

end CC2
