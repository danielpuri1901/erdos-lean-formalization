import Solution.Cert16.Ge2
import Solution.Cert16.Ge3
import Solution.Cert16.Ge4
import Solution.Cert16.Ge5
import Solution.Cert16.Ge6
import Solution.Cert16.Ge7
import Solution.Cert16.Ge8
import Solution.Cert16.Ge9
import Solution.Cert16.Ge10
import Solution.Cert16.Ge11
import Solution.Cert16.Ge12
import Solution.Cert16.Ge13
import Solution.Cert16.Ge14
import Solution.Cert16.Ge15
import Solution.Cert16.Ge16
import Solution.Cert16.Le1
import Solution.Cert16.Le2
import Solution.Cert16.Le3
import Solution.Cert16.Le4
import Solution.Cert16.Le5
import Solution.Cert16.Le6
import Solution.Cert16.Le7
import Solution.Cert16.Le8
import Solution.Cert16.Le9
import Solution.Cert16.Le10
import Solution.Cert16.Le11
import Solution.Cert16.Le12
import Solution.Cert16.Le13
import Solution.Cert16.Le14
import Solution.Cert16.Le15
import Solution.Cert16.Le16
import Solution.CertRoot

/-! Catch-Up on {1, ..., 16} is a draw: the strategy certificates are split into one
child per first-level key (modules `Solution.Cert16.Ge*`, `Solution.Cert16.Le*`), each
checked by `decide +kernel` in its own module; this module assembles them. -/

namespace CatchUpDeep

open CatchUp

def cert16ge : Cert := .pick 1 (.all (.cons 2 cert16ge_2 (.cons 3 cert16ge_3 (.cons 4 cert16ge_4 (.cons 5 cert16ge_5 (.cons 6 cert16ge_6 (.cons 7 cert16ge_7 (.cons 8 cert16ge_8 (.cons 9 cert16ge_9 (.cons 10 cert16ge_10 (.cons 11 cert16ge_11 (.cons 12 cert16ge_12 (.cons 13 cert16ge_13 (.cons 14 cert16ge_14 (.cons 15 cert16ge_15 (.cons 16 cert16ge_16 .nil))))))))))))))))

def cert16le : Cert := .all (.cons 1 cert16le_1 (.cons 2 cert16le_2 (.cons 3 cert16le_3 (.cons 4 cert16le_4 (.cons 5 cert16le_5 (.cons 6 cert16le_6 (.cons 7 cert16le_7 (.cons 8 cert16le_8 (.cons 9 cert16le_9 (.cons 10 cert16le_10 (.cons 11 cert16le_11 (.cons 12 cert16le_12 (.cons 13 cert16le_13 (.cons 14 cert16le_14 (.cons 15 cert16le_15 (.cons 16 cert16le_16 .nil))))))))))))))))

theorem cert16ge_ok : chkGe (List.range' 1 16) 0 cert16ge = true := by
  unfold cert16ge
  refine chkGe_pick_of (by decide) (by decide) (by decide) (d := 1) (by decide)
    (chkLe_all_of (by decide) ?_)
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_2_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_3_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_4_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_5_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_6_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_7_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_8_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_9_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_10_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_11_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_12_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_13_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_14_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_15_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16ge_16_ok ?_
  exact chkLeList_nil_of _ _

theorem cert16le_ok : chkLe (List.range' 1 16) 0 cert16le = true := by
  unfold cert16le
  refine chkLe_all_of (by decide) ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_1_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_2_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_3_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_4_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_5_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_6_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_7_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_8_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_9_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_10_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_11_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_12_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_13_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_14_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_15_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert16le_16_ok ?_
  exact chkLeList_nil_of _ _

theorem catchup_draw_16 : value (Finset.Icc 1 16) = .draw :=
  value_Icc_eq_draw_of_certs 16 cert16ge cert16le cert16ge_ok cert16le_ok

end CatchUpDeep

#print axioms CatchUpDeep.catchup_draw_16
