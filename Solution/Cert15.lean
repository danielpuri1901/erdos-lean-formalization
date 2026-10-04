import Solution.Cert15.Ge2
import Solution.Cert15.Ge3
import Solution.Cert15.Ge4
import Solution.Cert15.Ge5
import Solution.Cert15.Ge6
import Solution.Cert15.Ge7
import Solution.Cert15.Ge8
import Solution.Cert15.Ge9
import Solution.Cert15.Ge10
import Solution.Cert15.Ge11
import Solution.Cert15.Ge12
import Solution.Cert15.Ge13
import Solution.Cert15.Ge14
import Solution.Cert15.Ge15
import Solution.Cert15.Le1
import Solution.Cert15.Le2
import Solution.Cert15.Le3
import Solution.Cert15.Le4
import Solution.Cert15.Le5
import Solution.Cert15.Le6
import Solution.Cert15.Le7
import Solution.Cert15.Le8
import Solution.Cert15.Le9
import Solution.Cert15.Le10
import Solution.Cert15.Le11
import Solution.Cert15.Le12
import Solution.Cert15.Le13
import Solution.Cert15.Le14
import Solution.Cert15.Le15
import Solution.CertRoot

/-! Catch-Up on {1, ..., 15} is a draw: the strategy certificates are split into one
child per first-level key (modules `Solution.Cert15.Ge*`, `Solution.Cert15.Le*`), each
checked by `decide +kernel` in its own module; this module assembles them. -/

namespace CatchUpDeep

open CatchUp

def cert15ge : Cert := .pick 1 (.all (.cons 2 cert15ge_2 (.cons 3 cert15ge_3 (.cons 4 cert15ge_4 (.cons 5 cert15ge_5 (.cons 6 cert15ge_6 (.cons 7 cert15ge_7 (.cons 8 cert15ge_8 (.cons 9 cert15ge_9 (.cons 10 cert15ge_10 (.cons 11 cert15ge_11 (.cons 12 cert15ge_12 (.cons 13 cert15ge_13 (.cons 14 cert15ge_14 (.cons 15 cert15ge_15 .nil)))))))))))))))

def cert15le : Cert := .all (.cons 1 cert15le_1 (.cons 2 cert15le_2 (.cons 3 cert15le_3 (.cons 4 cert15le_4 (.cons 5 cert15le_5 (.cons 6 cert15le_6 (.cons 7 cert15le_7 (.cons 8 cert15le_8 (.cons 9 cert15le_9 (.cons 10 cert15le_10 (.cons 11 cert15le_11 (.cons 12 cert15le_12 (.cons 13 cert15le_13 (.cons 14 cert15le_14 (.cons 15 cert15le_15 .nil)))))))))))))))

theorem cert15ge_ok : chkGe (List.range' 1 15) 0 cert15ge = true := by
  unfold cert15ge
  refine chkGe_pick_of (by decide) (by decide) (by decide) (d := 1) (by decide)
    (chkLe_all_of (by decide) ?_)
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_2_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_3_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_4_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_5_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_6_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_7_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_8_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_9_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_10_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_11_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_12_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_13_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_14_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15ge_15_ok ?_
  exact chkLeList_nil_of _ _

theorem cert15le_ok : chkLe (List.range' 1 15) 0 cert15le = true := by
  unfold cert15le
  refine chkLe_all_of (by decide) ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_1_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_2_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_3_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_4_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_5_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_6_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_7_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_8_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_9_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_10_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_11_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_12_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_13_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_14_ok ?_
  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert15le_15_ok ?_
  exact chkLeList_nil_of _ _

theorem catchup_draw_15 : value (Finset.Icc 1 15) = .draw :=
  value_Icc_eq_draw_of_certs 15 cert15ge cert15le cert15ge_ok cert15le_ok

end CatchUpDeep

#print axioms CatchUpDeep.catchup_draw_15
