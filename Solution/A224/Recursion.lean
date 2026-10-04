import FormalConjectures.OEIS.«224»
import Solution.A224.Units

/-! a000224 deep attempt, lemmas R2 and R3: squares of multiples of `p` mod `p^(k+2)`, and the
recursion `2 a(p^(k+2)) = p^(k+2) - p^(k+1) + 2 a(p^k)` for odd primes `p`. -/

namespace A224Deep
open OeisA224

/-- R2. The squares of multiples of `p` modulo `p^(k+2)` are in bijection (multiplication by `p^2`)
with the squares modulo `p^k`. -/
theorem card_nonunit_squares {p : ℕ} (hp : p.Prime) (k : ℕ) :
    (((Finset.range (p ^ (k + 2))).filter (fun x => p ∣ x)).image
        (fun x => x ^ 2 % p ^ (k + 2))).card = a (p ^ k) := by
  have hp0 : 0 < p := hp.pos
  have hM0 : 0 < p ^ k := pow_pos hp0 k
  have hN : p ^ (k + 2) = p ^ 2 * p ^ k := by ring
  have key : ∀ y : ℕ, (p * y) ^ 2 % p ^ (k + 2) = p ^ 2 * (y ^ 2 % p ^ k) := by
    intro y
    rw [hN, mul_pow, Nat.mul_mod_mul_left]
  have hset : ((Finset.range (p ^ (k + 2))).filter (fun x => p ∣ x)).image
        (fun x => x ^ 2 % p ^ (k + 2)) =
      ((Finset.range (p ^ k)).image (fun y => y ^ 2 % p ^ k)).image (fun s => p ^ 2 * s) := by
    ext b
    simp only [Finset.mem_image, Finset.mem_filter, Finset.mem_range]
    constructor
    · rintro ⟨x, ⟨_, hdvd⟩, rfl⟩
      obtain ⟨y, rfl⟩ := hdvd
      refine ⟨y ^ 2 % p ^ k, ⟨y % p ^ k, Nat.mod_lt _ hM0, ?_⟩, (key y).symm⟩
      rw [← Nat.pow_mod]
    · rintro ⟨s, ⟨y, hy, rfl⟩, rfl⟩
      refine ⟨p * y, ⟨?_, dvd_mul_right _ _⟩, key y⟩
      have hpp : p ≤ p ^ 2 := by nlinarith
      calc p * y < p * p ^ k := Nat.mul_lt_mul_of_pos_left hy hp0
        _ ≤ p ^ 2 * p ^ k := Nat.mul_le_mul_right _ hpp
        _ = p ^ (k + 2) := hN.symm
  rw [hset, Finset.card_image_of_injective _ (mul_right_injective₀ (pow_ne_zero 2 hp.ne_zero))]
  unfold a
  rw [if_neg (pow_ne_zero k hp.ne_zero)]

/-- R3. Recursion for the number of squares modulo an odd prime power. -/
theorem two_mul_a_prime_pow_succ_succ {p : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) (k : ℕ) :
    2 * a (p ^ (k + 2)) = p ^ (k + 2) - p ^ (k + 1) + 2 * a (p ^ k) := by
  have hN0 : p ^ (k + 2) ≠ 0 := pow_ne_zero _ hp.ne_zero
  have hpN : p ∣ p ^ (k + 2) := dvd_pow_self p (by omega)
  have hsplit : Finset.range (p ^ (k + 2)) =
      (Finset.range (p ^ (k + 2))).filter (fun x => ¬ p ∣ x) ∪
        (Finset.range (p ^ (k + 2))).filter (fun x => p ∣ x) := by
    ext x
    simp only [Finset.mem_union, Finset.mem_filter]
    tauto
  have hdisj : Disjoint
      (((Finset.range (p ^ (k + 2))).filter (fun x => ¬ p ∣ x)).image
        (fun x => x ^ 2 % p ^ (k + 2)))
      (((Finset.range (p ^ (k + 2))).filter (fun x => p ∣ x)).image
        (fun x => x ^ 2 % p ^ (k + 2))) := by
    rw [Finset.disjoint_left]
    intro b hb1 hb2
    simp only [Finset.mem_image, Finset.mem_filter, Finset.mem_range] at hb1 hb2
    obtain ⟨x, ⟨_, hx⟩, rfl⟩ := hb1
    obtain ⟨y, ⟨_, hy⟩, hxy⟩ := hb2
    have h1 : p ∣ y ^ 2 % p ^ (k + 2) := (Nat.dvd_mod_iff hpN).mpr (dvd_pow hy two_ne_zero)
    rw [hxy, Nat.dvd_mod_iff hpN] at h1
    exact hx (hp.dvd_of_dvd_pow h1)
  have hS : (Finset.range (p ^ (k + 2))).image (fun x => x ^ 2 % p ^ (k + 2)) =
      ((Finset.range (p ^ (k + 2))).filter (fun x => ¬ p ∣ x)).image
        (fun x => x ^ 2 % p ^ (k + 2)) ∪
      ((Finset.range (p ^ (k + 2))).filter (fun x => p ∣ x)).image
        (fun x => x ^ 2 % p ^ (k + 2)) := by
    rw [← Finset.image_union, ← hsplit]
  have hA : a (p ^ (k + 2)) =
      (((Finset.range (p ^ (k + 2))).filter (fun x => ¬ p ∣ x)).image
        (fun x => x ^ 2 % p ^ (k + 2))).card +
      (((Finset.range (p ^ (k + 2))).filter (fun x => p ∣ x)).image
        (fun x => x ^ 2 % p ^ (k + 2))).card := by
    unfold a
    rw [if_neg hN0, hS, Finset.card_union_of_disjoint hdisj]
  have hR1 := card_unit_squares hp hp2 (j := k + 2) (by omega)
  have hR2 := card_nonunit_squares hp k
  have hsub : k + 2 - 1 = k + 1 := by omega
  rw [hsub] at hR1
  rw [hA, mul_add, hR1, hR2]

end A224Deep
