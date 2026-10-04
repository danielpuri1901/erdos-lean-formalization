import FormalConjectures.Arxiv.«2607.05739».TanArctanSum
import Solution.TanArctanCheck
import Solution.TanArctanRun
import Solution.TanArctanChunk.K1
import Solution.TanArctanChunk.K2
import Solution.TanArctanChunk.K3
import Solution.TanArctanChunk.K4
import Solution.TanArctanChunk.K5
import Solution.TanArctanChunk.K6
import Solution.TanArctanChunk.K7
import Solution.TanArctanChunk.K8
import Solution.TanArctanChunk.K9
import Solution.TanArctanChunk.K10
import Solution.TanArctanChunk.K11
import Solution.TanArctanChunk.K12
import Solution.TanArctanChunk.K13
import Solution.TanArctanChunk.K14
import Solution.TanArctanChunk.K15
import Solution.TanArctanChunk.K16
import Solution.TanArctanChunk.K17
import Solution.TanArctanChunk.K18
import Solution.TanArctanChunk.K19
import Solution.TanArctanChunk.K20
import Solution.TanArctanChunk.K21
import Solution.TanArctanChunk.K22
import Solution.TanArctanChunk.K23
import Solution.TanArctanChunk.K24
import Solution.TanArctanChunk.K25
import Solution.TanArctanChunk.K26
import Solution.TanArctanChunk.K27
import Solution.TanArctanChunk.K28
import Solution.TanArctanChunk.K29
import Solution.TanArctanChunk.K30
import Solution.TanArctanChunk.K31
import Solution.TanArctanChunk.K32
import Solution.TanArctanChunk.K33
import Solution.TanArctanChunk.K34
import Solution.TanArctanChunk.K35
import Solution.TanArctanChunk.K36
import Solution.TanArctanChunk.K37
import Solution.TanArctanChunk.K38
import Solution.TanArctanChunk.K39
import Solution.TanArctanChunk.K40

/-! Sweep results for `tanarctan` (see `sweep/tanarctan/NOTES.md`). -/

namespace TanArctanSweep

open Arxiv.«2607.05739»

/-- Reduction: `x_n` is an integer exactly when `|A_n| = gcd(A_n, B_n)`, i.e. when `A_n` is as small
as the content of `Z_n` allows. -/
theorem isIntegerValue_iff_gcd_eq_natAbs (n : Nat) :
    IsIntegerValue n ↔ Int.gcd (A n) (B n) = (A n).natAbs :=
  Int.gcd_eq_natAbs_left_iff_dvd.symm

/-- The conjecture of Amdeberhan-Medina-Moll on the finite range `5 ≤ n ≤ 50000`:
40 chained kernel runs of `runFrom`, each over at most 1250 indices. -/
theorem tan_arctan_sum_not_integer_of_le_50000 :
    ∀ n : Nat, 5 ≤ n → n ≤ 50000 → ¬ IsIntegerValue n := by
  intro n hlo hN
  have h1 := runFrom_sound 1246 5 190 (-90) _ _ chunk1 (by decide)
  have h2 := runFrom_sound 1250 1251 _ _ _ _ chunk2 h1.2
  have h3 := runFrom_sound 1250 2501 _ _ _ _ chunk3 h2.2
  have h4 := runFrom_sound 1250 3751 _ _ _ _ chunk4 h3.2
  have h5 := runFrom_sound 1250 5001 _ _ _ _ chunk5 h4.2
  have h6 := runFrom_sound 1250 6251 _ _ _ _ chunk6 h5.2
  have h7 := runFrom_sound 1250 7501 _ _ _ _ chunk7 h6.2
  have h8 := runFrom_sound 1250 8751 _ _ _ _ chunk8 h7.2
  have h9 := runFrom_sound 1250 10001 _ _ _ _ chunk9 h8.2
  have h10 := runFrom_sound 1250 11251 _ _ _ _ chunk10 h9.2
  have h11 := runFrom_sound 1250 12501 _ _ _ _ chunk11 h10.2
  have h12 := runFrom_sound 1250 13751 _ _ _ _ chunk12 h11.2
  have h13 := runFrom_sound 1250 15001 _ _ _ _ chunk13 h12.2
  have h14 := runFrom_sound 1250 16251 _ _ _ _ chunk14 h13.2
  have h15 := runFrom_sound 1250 17501 _ _ _ _ chunk15 h14.2
  have h16 := runFrom_sound 1250 18751 _ _ _ _ chunk16 h15.2
  have h17 := runFrom_sound 1250 20001 _ _ _ _ chunk17 h16.2
  have h18 := runFrom_sound 1250 21251 _ _ _ _ chunk18 h17.2
  have h19 := runFrom_sound 1250 22501 _ _ _ _ chunk19 h18.2
  have h20 := runFrom_sound 1250 23751 _ _ _ _ chunk20 h19.2
  have h21 := runFrom_sound 1250 25001 _ _ _ _ chunk21 h20.2
  have h22 := runFrom_sound 1250 26251 _ _ _ _ chunk22 h21.2
  have h23 := runFrom_sound 1250 27501 _ _ _ _ chunk23 h22.2
  have h24 := runFrom_sound 1250 28751 _ _ _ _ chunk24 h23.2
  have h25 := runFrom_sound 1250 30001 _ _ _ _ chunk25 h24.2
  have h26 := runFrom_sound 1250 31251 _ _ _ _ chunk26 h25.2
  have h27 := runFrom_sound 1250 32501 _ _ _ _ chunk27 h26.2
  have h28 := runFrom_sound 1250 33751 _ _ _ _ chunk28 h27.2
  have h29 := runFrom_sound 1250 35001 _ _ _ _ chunk29 h28.2
  have h30 := runFrom_sound 1250 36251 _ _ _ _ chunk30 h29.2
  have h31 := runFrom_sound 1250 37501 _ _ _ _ chunk31 h30.2
  have h32 := runFrom_sound 1250 38751 _ _ _ _ chunk32 h31.2
  have h33 := runFrom_sound 1250 40001 _ _ _ _ chunk33 h32.2
  have h34 := runFrom_sound 1250 41251 _ _ _ _ chunk34 h33.2
  have h35 := runFrom_sound 1250 42501 _ _ _ _ chunk35 h34.2
  have h36 := runFrom_sound 1250 43751 _ _ _ _ chunk36 h35.2
  have h37 := runFrom_sound 1250 45001 _ _ _ _ chunk37 h36.2
  have h38 := runFrom_sound 1250 46251 _ _ _ _ chunk38 h37.2
  have h39 := runFrom_sound 1250 47501 _ _ _ _ chunk39 h38.2
  have h40 := runFrom_sound 1250 48751 _ _ _ _ chunk40 h39.2
  have h : ¬ (zrec n).1 ∣ (zrec n).2 := by
    rcases Nat.lt_or_ge n 1251 with hc1 | hn1
    · exact h1.1 n hlo hc1
    rcases Nat.lt_or_ge n 2501 with hc2 | hn2
    · exact h2.1 n hn1 hc2
    rcases Nat.lt_or_ge n 3751 with hc3 | hn3
    · exact h3.1 n hn2 hc3
    rcases Nat.lt_or_ge n 5001 with hc4 | hn4
    · exact h4.1 n hn3 hc4
    rcases Nat.lt_or_ge n 6251 with hc5 | hn5
    · exact h5.1 n hn4 hc5
    rcases Nat.lt_or_ge n 7501 with hc6 | hn6
    · exact h6.1 n hn5 hc6
    rcases Nat.lt_or_ge n 8751 with hc7 | hn7
    · exact h7.1 n hn6 hc7
    rcases Nat.lt_or_ge n 10001 with hc8 | hn8
    · exact h8.1 n hn7 hc8
    rcases Nat.lt_or_ge n 11251 with hc9 | hn9
    · exact h9.1 n hn8 hc9
    rcases Nat.lt_or_ge n 12501 with hc10 | hn10
    · exact h10.1 n hn9 hc10
    rcases Nat.lt_or_ge n 13751 with hc11 | hn11
    · exact h11.1 n hn10 hc11
    rcases Nat.lt_or_ge n 15001 with hc12 | hn12
    · exact h12.1 n hn11 hc12
    rcases Nat.lt_or_ge n 16251 with hc13 | hn13
    · exact h13.1 n hn12 hc13
    rcases Nat.lt_or_ge n 17501 with hc14 | hn14
    · exact h14.1 n hn13 hc14
    rcases Nat.lt_or_ge n 18751 with hc15 | hn15
    · exact h15.1 n hn14 hc15
    rcases Nat.lt_or_ge n 20001 with hc16 | hn16
    · exact h16.1 n hn15 hc16
    rcases Nat.lt_or_ge n 21251 with hc17 | hn17
    · exact h17.1 n hn16 hc17
    rcases Nat.lt_or_ge n 22501 with hc18 | hn18
    · exact h18.1 n hn17 hc18
    rcases Nat.lt_or_ge n 23751 with hc19 | hn19
    · exact h19.1 n hn18 hc19
    rcases Nat.lt_or_ge n 25001 with hc20 | hn20
    · exact h20.1 n hn19 hc20
    rcases Nat.lt_or_ge n 26251 with hc21 | hn21
    · exact h21.1 n hn20 hc21
    rcases Nat.lt_or_ge n 27501 with hc22 | hn22
    · exact h22.1 n hn21 hc22
    rcases Nat.lt_or_ge n 28751 with hc23 | hn23
    · exact h23.1 n hn22 hc23
    rcases Nat.lt_or_ge n 30001 with hc24 | hn24
    · exact h24.1 n hn23 hc24
    rcases Nat.lt_or_ge n 31251 with hc25 | hn25
    · exact h25.1 n hn24 hc25
    rcases Nat.lt_or_ge n 32501 with hc26 | hn26
    · exact h26.1 n hn25 hc26
    rcases Nat.lt_or_ge n 33751 with hc27 | hn27
    · exact h27.1 n hn26 hc27
    rcases Nat.lt_or_ge n 35001 with hc28 | hn28
    · exact h28.1 n hn27 hc28
    rcases Nat.lt_or_ge n 36251 with hc29 | hn29
    · exact h29.1 n hn28 hc29
    rcases Nat.lt_or_ge n 37501 with hc30 | hn30
    · exact h30.1 n hn29 hc30
    rcases Nat.lt_or_ge n 38751 with hc31 | hn31
    · exact h31.1 n hn30 hc31
    rcases Nat.lt_or_ge n 40001 with hc32 | hn32
    · exact h32.1 n hn31 hc32
    rcases Nat.lt_or_ge n 41251 with hc33 | hn33
    · exact h33.1 n hn32 hc33
    rcases Nat.lt_or_ge n 42501 with hc34 | hn34
    · exact h34.1 n hn33 hc34
    rcases Nat.lt_or_ge n 43751 with hc35 | hn35
    · exact h35.1 n hn34 hc35
    rcases Nat.lt_or_ge n 45001 with hc36 | hn36
    · exact h36.1 n hn35 hc36
    rcases Nat.lt_or_ge n 46251 with hc37 | hn37
    · exact h37.1 n hn36 hc37
    rcases Nat.lt_or_ge n 47501 with hc38 | hn38
    · exact h38.1 n hn37 hc38
    rcases Nat.lt_or_ge n 48751 with hc39 | hn39
    · exact h39.1 n hn38 hc39
    exact h40.1 n hn39 (by omega)
  rw [zrec_eq] at h
  exact h

end TanArctanSweep
