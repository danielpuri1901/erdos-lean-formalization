import FormalConjectures.OEIS.«77408»

/-!
# Sweep a077408: bounded check of the base-3 trajectory of 103

`OeisA77408.conjecture` says that no term `a n` is a base-3 palindrome.
Here we prove the bounded statement `∀ n < N, ¬ IsBasePalindrome 3 (a n)` for an explicit `N`.

Plan (one Lean block per line of the written argument in `sweep/a077408/NOTES.md`):
1. `revAux` reverses base-3 digits by structural recursion on a fuel argument (kernel friendly).
2. `revAux_eq`: `revAux` agrees with `Nat.ofDigits 3 (Nat.digits 3 n).reverse` plus a shifted accumulator.
3. `revBase_eq_revAux`: `revBase 3 n = revAux n n 0`.
4. `check x k` tests the next `k` terms from `x`; `check_sound` turns `check (a m) k = true` into the bounded claim.
5. `decide +kernel` evaluates `check 103 N`.
-/

namespace A077408Sweep

open OeisA77408

/-- Base-3 digit reversal with fuel: pushes the low digit of `n` onto `acc`. -/
def revAux : Nat → Nat → Nat → Nat
  | 0, _, acc => acc
  | fuel + 1, n, acc => if n = 0 then acc else revAux fuel (n / 3) (acc * 3 + n % 3)

/-- Step 2: with enough fuel, `revAux` computes the reversal, plus `acc` shifted past the digits. -/
theorem revAux_eq (fuel : Nat) : ∀ n acc : Nat, n ≤ fuel →
    revAux fuel n acc =
      Nat.ofDigits 3 (Nat.digits 3 n).reverse + acc * 3 ^ (Nat.digits 3 n).length := by
  induction fuel with
  | zero =>
    intro n acc h
    have hn : n = 0 := by omega
    subst hn
    simp [revAux]
  | succ f ih =>
    intro n acc h
    rcases Nat.eq_zero_or_pos n with hn | hn
    · subst hn
      simp [revAux]
    · rw [revAux, if_neg (by omega), ih (n / 3) _ (by omega), Nat.digits_def' (by norm_num) hn]
      simp only [List.reverse_cons, Nat.ofDigits_append, List.length_reverse, List.length_cons,
        Nat.ofDigits_singleton, pow_succ]
      ring

/-- Step 3: the imported `revBase 3` equals the fuelled reversal. -/
theorem revBase_eq_revAux (n : Nat) : revBase 3 n = revAux n n 0 := by
  rw [revAux_eq n n 0 le_rfl]
  simp [revBase]

/-- One reverse-and-add step, computed with `revAux`. -/
def step (x : Nat) : Nat := x + revAux x x 0

/-- `check x k = true` iff none of the `k` terms `x, step x, …` is a palindrome. -/
def check : Nat → Nat → Bool
  | _, 0 => true
  | x, k + 1 => (x != revAux x x 0) && check (step x) k

theorem a_succ_eq_step (m : Nat) : a (m + 1) = step (a m) := by
  rw [step, ← revBase_eq_revAux]
  rfl

/-- Step 4: soundness of `check` along the trajectory. -/
theorem check_sound (k : Nat) : ∀ m : Nat, check (a m) k = true →
    ∀ i < k, ¬ IsBasePalindrome 3 (a (m + i)) := by
  induction k with
  | zero => intro m _ i hi; omega
  | succ k ih =>
    intro m h i hi
    simp only [check, Bool.and_eq_true, bne_iff_ne, ne_eq] at h
    rcases i with _ | j
    · rw [IsBasePalindrome, revBase_eq_revAux]
      exact h.1
    · rw [← a_succ_eq_step] at h
      have := ih (m + 1) h.2 j (by omega)
      rwa [show m + 1 + j = m + (j + 1) by omega] at this

/-- Step 5: the kernel evaluates the checker on the first 1000 terms. -/
theorem check_103_1000 : check 103 1000 = true := by decide +kernel

/-- Bounded form of `OeisA77408.conjecture`: none of `a 0, …, a 999` is a base-3 palindrome. -/
theorem no_palindrome_below_1000 (n : Nat) (hn : n < 1000) : ¬ IsBasePalindrome 3 (a n) := by
  have h := check_sound 1000 0 check_103_1000 n hn
  rwa [Nat.zero_add] at h

end A077408Sweep
