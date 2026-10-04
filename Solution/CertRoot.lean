import Solution.Cert

/-! Small lemmas for assembling a certificate check from separately checked children. -/

namespace CatchUpDeep

theorem chkGe_pick_of {l : List ℕ} {g x d : ℕ} {c : Cert} (hx : x ∈ l) (hs : ¬ l.sum < g)
    (hgx : g ≤ x) (hd : x - g = d) (hc : chkLe (l.erase x) d c = true) :
    chkGe l g (.pick x c) = true := by
  subst hd
  simp only [chkGe, hx, hs, hgx, hc, decide_true, decide_false, Bool.not_false, if_true,
    Bool.and_self]

theorem chkLe_all_of {l : List ℕ} {g : ℕ} {cs : CertList}
    (hk : (l.all fun x => decide (x ∈ cs.keys)) = true) (hr : chkLeList l g cs = true) :
    chkLe l g (.all cs) = true := by
  simp only [chkLe, hk, hr, Bool.and_self]

theorem chkLeList_cons_ge {l : List ℕ} {g x d : ℕ} {c : Cert} {rest : CertList} (hx : x ∈ l)
    (hgx : g ≤ x) (hd : x - g = d) (hc : chkGe (l.erase x) d c = true)
    (hr : chkLeList l g rest = true) : chkLeList l g (.cons x c rest) = true := by
  subst hd
  simp only [chkLeList, hx, hgx, hc, hr, decide_true, if_true, Bool.and_self]

theorem chkLeList_nil_of (l : List ℕ) (g : ℕ) : chkLeList l g .nil = true := by
  simp only [chkLeList]

end CatchUpDeep
