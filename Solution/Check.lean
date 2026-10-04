import FormalConjectures.Paper.ClaudesCycles

/-! Finite model of the cube digraph for `m = 2` on `Fin 8`, and the kernel check that no three
pointwise-distinct direction tables all give Hamiltonian paths from `0`. -/

namespace CC2

/-- `flipT b n` flips bit `b` of `n`. -/
def flipT (b : Fin 3) (n : Fin 8) : Fin 8 :=
  ![![1, 0, 3, 2, 5, 4, 7, 6], ![2, 3, 0, 1, 6, 7, 4, 5], ![4, 5, 6, 7, 0, 1, 2, 3]] b n

/-- One step along the direction table `t`. -/
def step (t : Fin 8 → Fin 3) (n : Fin 8) : Fin 8 := flipT (t n) n

/-- The first `k` points of the orbit of `x`. -/
def orb (t : Fin 8 → Fin 3) : Nat → Fin 8 → List (Fin 8)
  | 0, _ => []
  | k + 1, x => x :: orb t k (step t x)

/-- The eight vertices. -/
def allY : List (Fin 8) := [0, 1, 2, 3, 4, 5, 6, 7]

/-- The orbit of `0` under `step t` visits every vertex within 8 steps. -/
def hamB (t : Fin 8 → Fin 3) : Bool := allY.all fun y => (orb t 8 0).contains y

/-- A direction table given as a list. -/
def tab (l : List (Fin 3)) (n : Fin 8) : Fin 3 := l.getD n.val 0

/-- The third value of `Fin 3` when `x ≠ y`. -/
def third (x y : Fin 3) : Fin 3 := -(x + y)

theorem third_eq : ∀ x y z : Fin 3, x ≠ y → x ≠ z → y ≠ z → z = third x y := by decide

/-- All direction tables with prefix `p0, p1, p2` (243 of them). -/
def allLp (p0 p1 p2 : Fin 3) : List (List (Fin 3)) :=
  (List.finRange 3).flatMap fun a3 => (List.finRange 3).flatMap fun a4 => (List.finRange 3).flatMap fun a5 => (List.finRange 3).flatMap fun a6 => (List.finRange 3).flatMap fun a7 => [[p0, p1, p2, a3, a4, a5, a6, a7]]

/-- The 54 direction tables whose orbit from `0` is a Hamiltonian path. -/
def hamL : List (List (Fin 3)) :=
  [[0, 1, 0, 2, 1, 0, 2, 1],
    [0, 1, 1, 2, 1, 0, 2, 1],
    [0, 1, 2, 0, 0, 0, 0, 1],
    [0, 1, 2, 0, 0, 1, 1, 0],
    [0, 1, 2, 0, 0, 1, 1, 1],
    [0, 1, 2, 0, 0, 1, 1, 2],
    [0, 1, 2, 0, 1, 0, 0, 1],
    [0, 1, 2, 0, 2, 0, 0, 1],
    [0, 1, 2, 2, 1, 0, 2, 1],
    [0, 2, 0, 0, 1, 0, 0, 2],
    [0, 2, 0, 2, 1, 0, 2, 0],
    [0, 2, 0, 2, 1, 0, 2, 1],
    [0, 2, 0, 2, 1, 0, 2, 2],
    [0, 2, 1, 0, 1, 0, 0, 2],
    [0, 2, 2, 0, 0, 1, 1, 2],
    [0, 2, 2, 0, 1, 0, 0, 2],
    [0, 2, 2, 0, 1, 1, 1, 2],
    [0, 2, 2, 0, 2, 1, 1, 2],
    [1, 0, 0, 2, 0, 2, 1, 0],
    [1, 0, 2, 1, 0, 1, 1, 2],
    [1, 1, 0, 2, 0, 2, 1, 0],
    [1, 1, 2, 1, 0, 1, 1, 2],
    [1, 1, 2, 2, 0, 2, 1, 0],
    [1, 1, 2, 2, 0, 2, 1, 1],
    [1, 1, 2, 2, 0, 2, 1, 2],
    [1, 2, 0, 1, 0, 1, 1, 0],
    [1, 2, 0, 1, 1, 0, 0, 0],
    [1, 2, 0, 1, 1, 0, 0, 1],
    [1, 2, 0, 1, 1, 0, 0, 2],
    [1, 2, 0, 1, 1, 1, 1, 0],
    [1, 2, 0, 1, 2, 1, 1, 0],
    [1, 2, 0, 2, 0, 2, 1, 0],
    [1, 2, 2, 1, 0, 0, 0, 2],
    [1, 2, 2, 1, 0, 1, 1, 2],
    [1, 2, 2, 1, 1, 0, 0, 2],
    [1, 2, 2, 1, 2, 0, 0, 2],
    [2, 0, 0, 1, 0, 1, 2, 0],
    [2, 0, 0, 2, 1, 2, 2, 1],
    [2, 1, 0, 0, 1, 2, 0, 1],
    [2, 1, 0, 1, 0, 1, 2, 0],
    [2, 1, 0, 2, 0, 2, 2, 0],
    [2, 1, 0, 2, 1, 2, 2, 1],
    [2, 1, 1, 0, 1, 2, 0, 1],
    [2, 1, 1, 2, 0, 2, 2, 0],
    [2, 1, 2, 0, 0, 2, 0, 0],
    [2, 1, 2, 0, 0, 2, 0, 1],
    [2, 1, 2, 0, 0, 2, 0, 2],
    [2, 1, 2, 0, 1, 2, 0, 1],
    [2, 1, 2, 2, 0, 2, 2, 0],
    [2, 2, 0, 1, 0, 1, 2, 0],
    [2, 2, 0, 1, 1, 1, 2, 0],
    [2, 2, 0, 1, 1, 1, 2, 1],
    [2, 2, 0, 1, 1, 1, 2, 2],
    [2, 2, 0, 2, 1, 2, 2, 1]]

/-- The test that `check1` runs on every table. -/
def ok1 (l : List (Fin 3)) : Bool := !hamB (tab l) || hamL.contains l

theorem check1_000 : (allLp 0 0 0).all ok1 = true := by
  decide +kernel

theorem check1_001 : (allLp 0 0 1).all ok1 = true := by
  decide +kernel

theorem check1_002 : (allLp 0 0 2).all ok1 = true := by
  decide +kernel

theorem check1_010 : (allLp 0 1 0).all ok1 = true := by
  decide +kernel

theorem check1_011 : (allLp 0 1 1).all ok1 = true := by
  decide +kernel

theorem check1_012 : (allLp 0 1 2).all ok1 = true := by
  decide +kernel

theorem check1_020 : (allLp 0 2 0).all ok1 = true := by
  decide +kernel

theorem check1_021 : (allLp 0 2 1).all ok1 = true := by
  decide +kernel

theorem check1_022 : (allLp 0 2 2).all ok1 = true := by
  decide +kernel

theorem check1_100 : (allLp 1 0 0).all ok1 = true := by
  decide +kernel

theorem check1_101 : (allLp 1 0 1).all ok1 = true := by
  decide +kernel

theorem check1_102 : (allLp 1 0 2).all ok1 = true := by
  decide +kernel

theorem check1_110 : (allLp 1 1 0).all ok1 = true := by
  decide +kernel

theorem check1_111 : (allLp 1 1 1).all ok1 = true := by
  decide +kernel

theorem check1_112 : (allLp 1 1 2).all ok1 = true := by
  decide +kernel

theorem check1_120 : (allLp 1 2 0).all ok1 = true := by
  decide +kernel

theorem check1_121 : (allLp 1 2 1).all ok1 = true := by
  decide +kernel

theorem check1_122 : (allLp 1 2 2).all ok1 = true := by
  decide +kernel

theorem check1_200 : (allLp 2 0 0).all ok1 = true := by
  decide +kernel

theorem check1_201 : (allLp 2 0 1).all ok1 = true := by
  decide +kernel

theorem check1_202 : (allLp 2 0 2).all ok1 = true := by
  decide +kernel

theorem check1_210 : (allLp 2 1 0).all ok1 = true := by
  decide +kernel

theorem check1_211 : (allLp 2 1 1).all ok1 = true := by
  decide +kernel

theorem check1_212 : (allLp 2 1 2).all ok1 = true := by
  decide +kernel

theorem check1_220 : (allLp 2 2 0).all ok1 = true := by
  decide +kernel

theorem check1_221 : (allLp 2 2 1).all ok1 = true := by
  decide +kernel

theorem check1_222 : (allLp 2 2 2).all ok1 = true := by
  decide +kernel

theorem check1 (p0 p1 p2 : Fin 3) : (allLp p0 p1 p2).all ok1 = true := by
  fin_cases p0 <;> fin_cases p1 <;> fin_cases p2
  exacts [check1_000, check1_001, check1_002, check1_010, check1_011, check1_012, check1_020, check1_021, check1_022, check1_100, check1_101, check1_102, check1_110, check1_111, check1_112, check1_120, check1_121, check1_122, check1_200, check1_201, check1_202, check1_210, check1_211, check1_212, check1_220, check1_221, check1_222]

theorem check2 : hamL.all (fun a => hamL.all fun b =>
    !(List.zipWith (fun x y => x != y) a b).all id ||
      !hamL.contains (List.zipWith third a b)) = true := by
  decide +kernel

theorem mem_allLp (a : Fin 8 → Fin 3) :
    [a 0, a 1, a 2, a 3, a 4, a 5, a 6, a 7] ∈ allLp (a 0) (a 1) (a 2) := by
  simp only [allLp, List.mem_flatMap, List.mem_finRange, true_and, List.mem_singleton]
  exact ⟨a 3, a 4, a 5, a 6, a 7, rfl⟩

theorem tab_eq (a : Fin 8 → Fin 3) : tab [a 0, a 1, a 2, a 3, a 4, a 5, a 6, a 7] = a := by
  funext i; fin_cases i <;> rfl

theorem ham_mem (a : Fin 8 → Fin 3) (h : hamB a = true) :
    [a 0, a 1, a 2, a 3, a 4, a 5, a 6, a 7] ∈ hamL := by
  have h1 := List.all_eq_true.mp (check1 (a 0) (a 1) (a 2)) _ (mem_allLp a)
  rw [ok1, tab_eq, h] at h1
  simpa using h1

theorem no_three (a b c : Fin 8 → Fin 3) (hab : ∀ n, a n ≠ b n) (hac : ∀ n, a n ≠ c n)
    (hbc : ∀ n, b n ≠ c n) (ha : hamB a = true) (hb : hamB b = true) (hc : hamB c = true) :
    False := by
  have h2 := List.all_eq_true.mp (List.all_eq_true.mp check2 _ (ham_mem a ha)) _ (ham_mem b hb)
  have hc_eq : ∀ n, third (a n) (b n) = c n := fun n =>
    (third_eq _ _ _ (hab n) (hac n) (hbc n)).symm
  simp only [List.zipWith_cons_cons, List.zipWith_nil_left, hc_eq] at h2
  have hc' := ham_mem c hc
  simp [hab, hc'] at h2

end CC2
