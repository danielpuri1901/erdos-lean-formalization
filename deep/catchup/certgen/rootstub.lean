import Solution.CertRoot
namespace CatchUpDeep

open CatchUp
def cert15ge_2 : Cert := .leaf
theorem cert15ge_2_ok : chkGe (((List.range' 1 15).erase 1).erase 2) 1 cert15ge_2 = true := sorry
def cert15ge_3 : Cert := .leaf
theorem cert15ge_3_ok : chkGe (((List.range' 1 15).erase 1).erase 3) 2 cert15ge_3 = true := sorry
def cert15ge_4 : Cert := .leaf
theorem cert15ge_4_ok : chkGe (((List.range' 1 15).erase 1).erase 4) 3 cert15ge_4 = true := sorry
def cert15ge_5 : Cert := .leaf
theorem cert15ge_5_ok : chkGe (((List.range' 1 15).erase 1).erase 5) 4 cert15ge_5 = true := sorry
def cert15ge_6 : Cert := .leaf
theorem cert15ge_6_ok : chkGe (((List.range' 1 15).erase 1).erase 6) 5 cert15ge_6 = true := sorry
def cert15ge_7 : Cert := .leaf
theorem cert15ge_7_ok : chkGe (((List.range' 1 15).erase 1).erase 7) 6 cert15ge_7 = true := sorry
def cert15ge_8 : Cert := .leaf
theorem cert15ge_8_ok : chkGe (((List.range' 1 15).erase 1).erase 8) 7 cert15ge_8 = true := sorry
def cert15ge_9 : Cert := .leaf
theorem cert15ge_9_ok : chkGe (((List.range' 1 15).erase 1).erase 9) 8 cert15ge_9 = true := sorry
def cert15ge_10 : Cert := .leaf
theorem cert15ge_10_ok : chkGe (((List.range' 1 15).erase 1).erase 10) 9 cert15ge_10 = true := sorry
def cert15ge_11 : Cert := .leaf
theorem cert15ge_11_ok : chkGe (((List.range' 1 15).erase 1).erase 11) 10 cert15ge_11 = true := sorry
def cert15ge_12 : Cert := .leaf
theorem cert15ge_12_ok : chkGe (((List.range' 1 15).erase 1).erase 12) 11 cert15ge_12 = true := sorry
def cert15ge_13 : Cert := .leaf
theorem cert15ge_13_ok : chkGe (((List.range' 1 15).erase 1).erase 13) 12 cert15ge_13 = true := sorry
def cert15ge_14 : Cert := .leaf
theorem cert15ge_14_ok : chkGe (((List.range' 1 15).erase 1).erase 14) 13 cert15ge_14 = true := sorry
def cert15ge_15 : Cert := .leaf
theorem cert15ge_15_ok : chkGe (((List.range' 1 15).erase 1).erase 15) 14 cert15ge_15 = true := sorry
def cert15le_1 : Cert := .leaf
theorem cert15le_1_ok : chkGe ((List.range' 1 15).erase 1) 1 cert15le_1 = true := sorry
def cert15le_2 : Cert := .leaf
theorem cert15le_2_ok : chkGe ((List.range' 1 15).erase 2) 2 cert15le_2 = true := sorry
def cert15le_3 : Cert := .leaf
theorem cert15le_3_ok : chkGe ((List.range' 1 15).erase 3) 3 cert15le_3 = true := sorry
def cert15le_4 : Cert := .leaf
theorem cert15le_4_ok : chkGe ((List.range' 1 15).erase 4) 4 cert15le_4 = true := sorry
def cert15le_5 : Cert := .leaf
theorem cert15le_5_ok : chkGe ((List.range' 1 15).erase 5) 5 cert15le_5 = true := sorry
def cert15le_6 : Cert := .leaf
theorem cert15le_6_ok : chkGe ((List.range' 1 15).erase 6) 6 cert15le_6 = true := sorry
def cert15le_7 : Cert := .leaf
theorem cert15le_7_ok : chkGe ((List.range' 1 15).erase 7) 7 cert15le_7 = true := sorry
def cert15le_8 : Cert := .leaf
theorem cert15le_8_ok : chkGe ((List.range' 1 15).erase 8) 8 cert15le_8 = true := sorry
def cert15le_9 : Cert := .leaf
theorem cert15le_9_ok : chkGe ((List.range' 1 15).erase 9) 9 cert15le_9 = true := sorry
def cert15le_10 : Cert := .leaf
theorem cert15le_10_ok : chkGe ((List.range' 1 15).erase 10) 10 cert15le_10 = true := sorry
def cert15le_11 : Cert := .leaf
theorem cert15le_11_ok : chkGe ((List.range' 1 15).erase 11) 11 cert15le_11 = true := sorry
def cert15le_12 : Cert := .leaf
theorem cert15le_12_ok : chkGe ((List.range' 1 15).erase 12) 12 cert15le_12 = true := sorry
def cert15le_13 : Cert := .leaf
theorem cert15le_13_ok : chkGe ((List.range' 1 15).erase 13) 13 cert15le_13 = true := sorry
def cert15le_14 : Cert := .leaf
theorem cert15le_14_ok : chkGe ((List.range' 1 15).erase 14) 14 cert15le_14 = true := sorry
def cert15le_15 : Cert := .leaf
theorem cert15le_15_ok : chkGe ((List.range' 1 15).erase 15) 15 cert15le_15 = true := sorry

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
