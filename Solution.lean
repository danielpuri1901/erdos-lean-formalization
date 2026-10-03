import FormalConjectures.GreensOpenProblems.«72»
import Solution.Green72.Sound
import Solution.Green72.Checks1
import Solution.Green72.Checks2
import Solution.Green72.Checks3
import Solution.Green72.Checks4
import Solution.Green72.Checks5
import Solution.Green72.Checks6
import Solution.Green72.Checks7

/-! Green 72 for 3 ≤ N ≤ 60: the upper bound is `Green72.allowedSetSize_le`, and each N has a
kernel-checked witness of 2N points (`Solution/Green72/Checks*.lean`) that `Green72Proof.of_check`
turns into the lower bound. -/

open Green72Proof

theorem green72_no_three_in_line_le {N : ℕ} (hN : 3 ≤ N) (hN' : N ≤ 60) :
    Green72.NoKInLineFor 3 N := by
  interval_cases N
  exacts [of_check check3,
    of_check check4,
    of_check check5,
    of_check check6,
    of_check check7,
    of_check check8,
    of_check check9,
    of_check check10,
    of_check check11,
    of_check check12,
    of_check check13,
    of_check check14,
    of_check check15,
    of_check check16,
    of_check check17,
    of_check check18,
    of_check check19,
    of_check check20,
    of_check check21,
    of_check check22,
    of_check check23,
    of_check check24,
    of_check check25,
    of_check check26,
    of_check check27,
    of_check check28,
    of_check check29,
    of_check check30,
    of_check check31,
    of_check check32,
    of_check check33,
    of_check check34,
    of_check check35,
    of_check check36,
    of_check check37,
    of_check check38,
    of_check check39,
    of_check check40,
    of_check check41,
    of_check check42,
    of_check check43,
    of_check check44,
    of_check check45,
    of_check check46,
    of_check check47,
    of_check check48,
    of_check check49,
    of_check check50,
    of_check check51,
    of_check check52,
    of_check check53,
    of_check check54,
    of_check check55,
    of_check check56,
    of_check check57,
    of_check check58,
    of_check check59,
    of_check check60]
