import FormalConjectures.Paper.ClaudesCycles
import Solution.Check

/-! Solution for the claudecycles2 target. See `TASK.md` and `NOTES.md`. -/

namespace CC2

open ClaudesCycles Equiv

/-- Vertices of the cube digraph for `m = 2`. -/
abbrev V := Vertex 2

/-- Encode a vertex as the number with bits `v 0, v 1, v 2`. -/
def enc (v : V) : Fin 8 :=
  ⟨((v 0).val + 2 * (v 1).val + 4 * (v 2).val) % 8, Nat.mod_lt _ (by decide)⟩

/-- Decode a number below 8 into a vertex. -/
def vtx (n : Fin 8) : V :=
  ![(n.val % 2 : Nat), (n.val / 2 % 2 : Nat), (n.val / 4 % 2 : Nat)]

theorem enc_vtx : ∀ n : Fin 8, enc (vtx n) = n := by decide

theorem vtx_enc : ∀ v : V, vtx (enc v) = v := by decide

theorem enc_bump : ∀ (b : Fin 3) (v : V), enc (bumpAt b v) = flipT b (enc v) := by decide

theorem card_V : Fintype.card V = 8 := by simp [V, Vertex]

theorem orb_mem (t : Fin 8 → Fin 3) : ∀ (k : Nat) (x : Fin 8) (i : Nat), i < k →
    (step t)^[i] x ∈ orb t k x := by
  intro k
  induction k with
  | zero => intro x i hi; omega
  | succ k ih =>
    intro x i hi
    cases i with
    | zero => simp [orb]
    | succ i =>
      rw [Function.iterate_succ_apply, orb]
      exact List.mem_cons_of_mem _ (ih _ _ (by omega))

theorem reach (σ : Perm V) (h : IsDirectedHamiltonianCycle (cubeAdj (m := 2)) σ) (x y : V) :
    ∃ i < 8, (σ ^ i) x = y := by
  obtain ⟨-, hc, hs⟩ := h
  have hx : x ∈ σ.support := by rw [hs]; exact Finset.mem_univ _
  have hy : y ∈ σ.support := by rw [hs]; exact Finset.mem_univ _
  have hsc : σ.SameCycle x y := hc.sameCycle (Perm.mem_support.mp hx) (Perm.mem_support.mp hy)
  obtain ⟨i, hi, he⟩ := hsc.exists_pow_eq_of_mem_support hx
  refine ⟨i, lt_of_lt_of_le hi ?_, he⟩
  rw [← card_V]
  exact Finset.card_le_univ _

theorem enc_pow (σ : Perm V) (f : V → Fin 3) (hf : ∀ v, σ v = bumpAt (f v) v) (v : V) (i : Nat) :
    enc ((σ ^ i) v) = (step (fun n => f (vtx n)))^[i] (enc v) := by
  induction i with
  | zero => simp
  | succ i ih =>
    rw [pow_succ', Perm.mul_apply, Function.iterate_succ_apply', ← ih, hf, enc_bump, step,
      vtx_enc]

theorem ham_of (σ : Perm V) (f : V → Fin 3) (hf : ∀ v, σ v = bumpAt (f v) v)
    (h : IsDirectedHamiltonianCycle (cubeAdj (m := 2)) σ) : hamB (fun n => f (vtx n)) = true := by
  simp only [hamB, List.all_eq_true]
  intro y _
  obtain ⟨i, hi, he⟩ := reach σ h (vtx 0) (vtx y)
  have := enc_pow σ f hf (vtx 0) i
  rw [he, enc_vtx, enc_vtx] at this
  rw [this]
  simpa using orb_mem _ 8 0 i hi

end CC2

open ClaudesCycles CC2 in
theorem cube_no_decomposition_m2 :
    type_of% @ClaudesCycles.cube_hamiltonian_arc_decomposition_impossible_m2 := by
  intro hdec
  obtain ⟨σ, hcyc, huniq⟩ := hdec
  have hadj : ∀ c v, ∃ b, bumpAt b v = σ c v := fun c v => (hcyc c).1 v
  choose f hf using hadj
  have hdist : ∀ v c c', c ≠ c' → f c v ≠ f c' v := by
    intro v c c' hne heq
    obtain ⟨c0, -, hu⟩ := huniq v (f c v)
    have h1 := hu c (hf c v).symm
    have h2 := hu c' (by rw [heq]; exact (hf c' v).symm)
    exact hne (h1.trans h2.symm)
  have hham : ∀ c, hamB (fun n => f c (vtx n)) = true := fun c =>
    ham_of (σ c) (f c) (fun v => (hf c v).symm) (hcyc c)
  exact no_three _ _ _ (fun n => hdist _ 0 1 (by decide)) (fun n => hdist _ 0 2 (by decide))
    (fun n => hdist _ 1 2 (by decide)) (hham 0) (hham 1) (hham 2)
