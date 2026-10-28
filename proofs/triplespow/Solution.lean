import FormalConjectures.Arxiv.«1609.08688».sIncreasingrTuples

/-! Solution for the triplespow target. See `TASK.md` and `NOTES.md`.

Product lemma: F a * F b ≤ F (a * b) for a, b ≥ 2, by combining longest sequences
s for a and t for b lexicographically, the triple (x, y) having coordinates
(x k - 1) * b + y k. Then F n ^ k ≤ F (n ^ k), and n ^ k is arbitrarily large. -/

namespace TriplesPow

open Arxiv.«1609.08688»

/-- The set whose supremum is `maximalLength n`. -/
def S (n : Nat) : Set Nat :=
  { List.length s | (s : List (Fin 3 → Nat))
      (_ : ∀ a ∈ s, Set.range a ⊆ Set.Icc 1 n) (_ : IsIncreasing₂ s) }

theorem F_eq (n : Nat) : maximalLength n = sSup (S n) := rfl

theorem bdd {n : Nat} (hn : 2 ≤ n) : BddAbove (S n) := by
  refine ⟨n ^ 2, ?_⟩
  rintro _ ⟨s, hs_range, hs_inc, rfl⟩
  by_contra hle
  have hs_length : n ^ 2 < s.length := Nat.lt_of_not_ge hle
  obtain ⟨i, j, hij, h0, h1⟩ := exists_pair_of_mem_Icc hn hs_range hs_length
  have hp : s.Pairwise lt₂ := hs_inc
  rcases lt_or_gt_of_ne hij with hij | hji
  · exact (not_lt₂_of_exists 0 1 zero_ne_one h0.ge h1.ge)
      (List.pairwise_iff_get.1 hp i j hij)
  · exact (not_lt₂_of_exists 0 1 zero_ne_one h0.le h1.le)
      (List.pairwise_iff_get.1 hp j i hji)

theorem exists_max {n : Nat} (hn : 2 ≤ n) :
    ∃ s : List (Fin 3 → Nat), (∀ a ∈ s, Set.range a ⊆ Set.Icc 1 n) ∧ IsIncreasing₂ s ∧
      s.length = maximalLength n := by
  have hne : (S n).Nonempty := ⟨0, ⟨[], by simp, isIncreasing₂_nil, rfl⟩⟩
  have hmem := Nat.sSup_mem hne (bdd hn)
  rw [← F_eq] at hmem
  obtain ⟨s, h1, h2, h3⟩ := hmem
  exact ⟨s, h1, h2, h3⟩

/-- The combined triple. -/
def comb (b : Nat) (x y : Fin 3 → Nat) : Fin 3 → Nat := fun k => (x k - 1) * b + y k

/-- The combined sequence. -/
def P (b : Nat) (s t : List (Fin 3 → Nat)) : List (Fin 3 → Nat) :=
  s.flatMap fun x => t.map (comb b x)

theorem length_P (b : Nat) (s t : List (Fin 3 → Nat)) :
    (P b s t).length = s.length * t.length := by
  simp [P, List.length_flatMap, List.map_const', List.sum_replicate]

theorem entry_bounds {u v a b : Nat} (hu1 : 1 ≤ u) (hua : u ≤ a) (hv1 : 1 ≤ v) (hvb : v ≤ b) :
    1 ≤ (u - 1) * b + v ∧ (u - 1) * b + v ≤ a * b := by
  obtain ⟨p, rfl⟩ : ∃ p, u = p + 1 := ⟨u - 1, by omega⟩
  simp only [Nat.add_sub_cancel]
  have : (p + 1) * b ≤ a * b := Nat.mul_le_mul_right _ hua
  constructor
  · omega
  · nlinarith

theorem range_P {a b : Nat} {s t : List (Fin 3 → Nat)}
    (hs : ∀ x ∈ s, Set.range x ⊆ Set.Icc 1 a) (ht : ∀ y ∈ t, Set.range y ⊆ Set.Icc 1 b) :
    ∀ c ∈ P b s t, Set.range c ⊆ Set.Icc 1 (a * b) := by
  intro c hc
  simp only [P, List.mem_flatMap, List.mem_map] at hc
  obtain ⟨x, hx, y, hy, rfl⟩ := hc
  rintro _ ⟨k, rfl⟩
  have h1 := hs x hx ⟨k, rfl⟩
  have h2 := ht y hy ⟨k, rfl⟩
  rw [Set.mem_Icc] at h1 h2 ⊢
  exact entry_bounds h1.1 h1.2 h2.1 h2.2

theorem key {p q v v' b : Nat} (hpq : p < q) (hv : v ≤ b) (hv' : 1 ≤ v') :
    p * b + v < q * b + v' := by
  have : (p + 1) * b ≤ q * b := Nat.mul_le_mul_right _ hpq
  nlinarith

theorem lt₂_same {b : Nat} {x y y' : Fin 3 → Nat} (h : lt₂ y y') :
    lt₂ (comb b x y) (comb b x y') := by
  obtain ⟨i, j, hij, hi, hj⟩ := h
  exact ⟨i, j, hij, by simp only [comb]; omega, by simp only [comb]; omega⟩

theorem lt₂_diff {a b : Nat} {x x' y y' : Fin 3 → Nat}
    (hx : Set.range x ⊆ Set.Icc 1 a) (hy : Set.range y ⊆ Set.Icc 1 b)
    (hy' : Set.range y' ⊆ Set.Icc 1 b) (h : lt₂ x x') :
    lt₂ (comb b x y) (comb b x' y') := by
  obtain ⟨i, j, hij, hi, hj⟩ := h
  have step : ∀ k, x k < x' k → comb b x y k < comb b x' y' k := by
    intro k hk
    have h1 := hx ⟨k, rfl⟩
    have h2 := hy ⟨k, rfl⟩
    have h3 := hy' ⟨k, rfl⟩
    rw [Set.mem_Icc] at h1 h2 h3
    exact key (by omega) h2.2 h3.1
  exact ⟨i, j, hij, step i hi, step j hj⟩

theorem pairwise_P {a b : Nat} {s t : List (Fin 3 → Nat)}
    (hs : ∀ x ∈ s, Set.range x ⊆ Set.Icc 1 a) (ht : ∀ y ∈ t, Set.range y ⊆ Set.Icc 1 b)
    (hsi : IsIncreasing₂ s) (hti : IsIncreasing₂ t) : IsIncreasing₂ (P b s t) := by
  unfold IsIncreasing₂ P
  rw [List.pairwise_flatMap]
  refine ⟨fun x _ => ?_, ?_⟩
  · rw [List.pairwise_map]
    exact (show t.Pairwise lt₂ from hti).imp fun h => lt₂_same h
  · refine (show s.Pairwise lt₂ from hsi).imp_of_mem fun {x x'} hx _ hxx' => ?_
    intro c hc d hd
    simp only [List.mem_map] at hc hd
    obtain ⟨y, hy, rfl⟩ := hc
    obtain ⟨y', hy', rfl⟩ := hd
    exact lt₂_diff (hs x hx) (ht y hy) (ht y' hy') hxx'

theorem prod_le {a b : Nat} (ha : 2 ≤ a) (hb : 2 ≤ b) :
    maximalLength a * maximalLength b ≤ maximalLength (a * b) := by
  obtain ⟨s, hs1, hs2, hs3⟩ := exists_max ha
  obtain ⟨t, ht1, ht2, ht3⟩ := exists_max hb
  have hab : 2 ≤ a * b := by nlinarith
  rw [← hs3, ← ht3, ← length_P b, F_eq]
  exact le_csSup (bdd hab) ⟨P b s t, range_P hs1 ht1, pairwise_P hs1 ht1 hs2 ht2, rfl⟩

theorem pow_le {n : Nat} (hn : 2 ≤ n) (k : Nat) :
    maximalLength n ^ (k + 1) ≤ maximalLength (n ^ (k + 1)) := by
  induction k with
  | zero => simp
  | succ k ih =>
    have h2 : 2 ≤ n ^ (k + 1) :=
      le_trans hn (Nat.le_self_pow (by omega) n)
    calc maximalLength n ^ (k + 1 + 1)
        = maximalLength n ^ (k + 1) * maximalLength n := pow_succ _ _
      _ ≤ maximalLength (n ^ (k + 1)) * maximalLength n := Nat.mul_le_mul_right _ ih
      _ ≤ maximalLength (n ^ (k + 1) * n) := prod_le h2 hn
      _ = maximalLength (n ^ (k + 1 + 1)) := by rw [← pow_succ]

end TriplesPow

theorem increasing_triples_power : type_of% @Arxiv.«1609.08688».maximalLength_pow := by
  intro n e hn h
  rw [Filter.frequently_atTop]
  intro A
  refine ⟨n ^ (A + 1), ?_, ?_⟩
  · exact le_trans (Nat.lt_pow_self hn).le (Nat.pow_le_pow_right (by omega) (by omega))
  · have hle := TriplesPow.pow_le (n := n) (by omega) A
    have hn0 : (0 : ℝ) ≤ n := Nat.cast_nonneg n
    calc ((n ^ (A + 1) : Nat) : ℝ) ^ e
        = ((n : ℝ) ^ e) ^ (A + 1) := by
          rw [Nat.cast_pow, ← Real.rpow_natCast, ← Real.rpow_natCast, ← Real.rpow_mul hn0,
            ← Real.rpow_mul hn0, mul_comm]
      _ = ((Arxiv.«1609.08688».maximalLength n : Nat) : ℝ) ^ (A + 1) := by rw [h]
      _ ≤ (Arxiv.«1609.08688».maximalLength (n ^ (A + 1)) : ℝ) := by
          exact_mod_cast hle

example : type_of% @increasing_triples_power = type_of% @Arxiv.«1609.08688».maximalLength_pow := rfl
