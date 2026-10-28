import FormalConjectures.Wikipedia.LeinsterGroup

/-! Finite checks for S3 × C5 (see `NOTES.md`). -/

namespace LeinsterS3C5

open DihedralGroup

abbrev G := DihedralGroup 3 × Multiplicative (ZMod 5)

/-- Rational class of an element: (identity, 3-cycle, reflection) × (C5 part trivial or not). -/
def cls : G → Fin 6
  | (r i, m) => if i = 0 then (if Multiplicative.toAdd m = 0 then 0 else 3)
      else (if Multiplicative.toAdd m = 0 then 1 else 4)
  | (sr _, m) => if Multiplicative.toAdd m = 0 then 2 else 5

def rep : Fin 6 → G
  | 0 => (1, 1)
  | 1 => (r 1, 1)
  | 2 => (sr 0, 1)
  | 3 => (1, Multiplicative.ofAdd 1)
  | 4 => (r 1, Multiplicative.ofAdd 1)
  | 5 => (sr 0, Multiplicative.ofAdd 1)

def conjs : List G := [(r 0, 1), (r 1, 1), (r 2, 1), (sr 0, 1), (sr 1, 1), (sr 2, 1)]

theorem cls_inv : ∀ g : G, cls g⁻¹ = cls g := by decide +kernel

theorem cls_conj : ∀ x g : G, cls (x * g * x⁻¹) = cls g := by decide +kernel

theorem rep_witness : ∀ g : G,
    (∃ x ∈ conjs, ∃ k ∈ List.range 15, x * g ^ k * x⁻¹ = rep (cls g)) ∧
    (∃ x ∈ conjs, ∃ k ∈ List.range 15, x * rep (cls g) ^ k * x⁻¹ = g) := by
  decide +kernel

/-- The six class vectors of normal subgroups: 1, A3, S3, C5, C15, G. -/
def vs : Fin 6 → Fin 6 → Bool
  | 0 => ![true, false, false, false, false, false]
  | 1 => ![true, true, false, false, false, false]
  | 2 => ![true, true, true, false, false, false]
  | 3 => ![true, false, false, true, false, false]
  | 4 => ![true, true, false, true, true, false]
  | 5 => ![true, true, true, true, true, true]

def cards : Fin 6 → Nat := ![1, 3, 6, 5, 15, 30]

/-- A class vector closed under the group operation. -/
def Good (v : Fin 6 → Bool) : Prop :=
  v (cls 1) = true ∧ ∀ a b : G, v (cls a) = true → v (cls b) = true → v (cls (a * b)) = true

instance (v : Fin 6 → Bool) : Decidable (Good v) := by unfold Good; infer_instance

theorem classify : ∀ b0 b1 b2 b3 b4 b5 : Bool, Good ![b0, b1, b2, b3, b4, b5] →
    ∃ i : Fin 6, ∀ j, ![b0, b1, b2, b3, b4, b5] j = vs i j := by
  decide +kernel

theorem vs_good : ∀ i, Good (vs i) := by decide +kernel

theorem vs_inj : ∀ i j : Fin 6, (∀ k, vs i k = vs j k) → i = j := by decide +kernel

theorem cls_rep : ∀ i, cls (rep i) = i := by decide +kernel

theorem card_vs : ∀ i, Fintype.card {g : G // vs i (cls g) = true} = cards i := by decide +kernel

/-- The normal subgroup with class vector `vs i`. -/
def mkN (i : Fin 6) : Subgroup G where
  carrier := {g | vs i (cls g) = true}
  one_mem' := (vs_good i).1
  mul_mem' := fun ha hb => (vs_good i).2 _ _ ha hb
  inv_mem' := fun {g} (hg : vs i (cls g) = true) => by
    show vs i (cls g⁻¹) = true
    rw [cls_inv]; exact hg

theorem mem_mkN (i : Fin 6) (g : G) : g ∈ mkN i ↔ vs i (cls g) = true := Iff.rfl

theorem mkN_normal (i : Fin 6) : (mkN i).Normal where
  conj_mem := fun n hn g => by
    rw [mem_mkN, cls_conj]; exact hn

theorem mem_iff_rep (N : Subgroup G) (hN : N.Normal) (g : G) :
    g ∈ N ↔ rep (cls g) ∈ N := by
  obtain ⟨⟨x, -, k, -, hx⟩, ⟨y, -, j, -, hy⟩⟩ := rep_witness g
  constructor
  · intro hg
    rw [← hx]
    exact hN.conj_mem _ (N.pow_mem hg k) x
  · intro hg
    rw [← hy]
    exact hN.conj_mem _ (N.pow_mem hg j) y

theorem normal_eq_mkN (N : Subgroup G) (hN : N.Normal) : ∃ i, N = mkN i := by
  classical
  let v : Fin 6 → Bool := fun k => decide (rep k ∈ N)
  have hv : ∀ g, g ∈ N ↔ v (cls g) = true := fun g => by
    simp only [v, decide_eq_true_eq]; exact mem_iff_rep N hN g
  have hgood : Good v := by
    refine ⟨(hv 1).1 N.one_mem, fun a b ha hb => (hv _).1 (N.mul_mem ((hv a).2 ha) ((hv b).2 hb))⟩
  have hv' : v = ![v 0, v 1, v 2, v 3, v 4, v 5] := by
    funext k; fin_cases k <;> rfl
  rw [hv'] at hgood
  obtain ⟨i, hi⟩ := classify _ _ _ _ _ _ hgood
  refine ⟨i, ?_⟩
  ext g
  rw [hv, mem_mkN, ← hi (cls g), ← hv']

open scoped Classical in
theorem sum_normal :
    ∑ H : {H : Subgroup G // H.Normal}, Nat.card H = 60 := by
  classical
  let e : Fin 6 → {H : Subgroup G // H.Normal} := fun i => ⟨mkN i, mkN_normal i⟩
  have he : Function.Bijective e := by
    constructor
    · intro i j hij
      have h : mkN i = mkN j := congrArg Subtype.val hij
      apply vs_inj
      intro k
      have hk := SetLike.ext_iff.mp h (rep k)
      rw [mem_mkN, mem_mkN, cls_rep] at hk
      cases hi : vs i k <;> cases hj : vs j k <;> simp_all
    · rintro ⟨N, hN⟩
      obtain ⟨i, rfl⟩ := normal_eq_mkN N hN
      exact ⟨i, rfl⟩
  rw [← Fintype.sum_bijective e he (fun i => cards i) _ (fun i => ?_)]
  · decide
  · show cards i = Nat.card {g : G // vs i (cls g) = true}
    rw [Nat.card_eq_fintype_card, card_vs]

theorem card_G : Fintype.card G = 30 := by decide +kernel

theorem not_comm : ¬ ∀ a b : G, a * b = b * a := by
  intro h
  exact absurd (h (r 1, 1) (sr 0, 1)) (by decide +kernel)

theorem exists_nonabelian :
    ∃ G : Type, ∃ (_ : Group G) (_ : Fintype G),
      LeinsterGroup.IsLeinster G ∧ ¬ ∀ (a b : G), a * b = b * a :=
  ⟨G, inferInstance, inferInstance, by
    unfold LeinsterGroup.IsLeinster
    rw [card_G]
    convert sum_normal, not_comm⟩

end LeinsterS3C5
