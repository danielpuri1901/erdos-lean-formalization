# Sweep a077408: reverse and add in base 3, start 103

```
result: partial
claim: (Lean) for every n < 1000, a n is not a base-3 palindrome. (Paper, not in Lean) Lemma P: x + rev3(x) is a base-3 palindrome iff every mirrored digit pair of x has d_i + d_{L-1-i} <= 2, or x is a palindrome with digits in {0,2}. Hence the conjecture is equivalent to "every term a(n) has a mirrored digit pair with sum >= 3".
lean: Solution.lean, A077408Sweep.no_palindrome_below_1000 (uses revAux_eq, revBase_eq_revAux, a_succ_eq_step, check_sound, check_103_1000); no sorry; axioms propext, Classical.choice, Quot.sound
computed: no palindrome among a(0..999999) (C digit arrays, search.c; final term has 597449 base-3 digits; checksum at step 5999 cross-checked with independent Python); Lemma P exhaustively for all x with <= 18 base-3 digits (lemma_p.c) and <= 13 digits (independent lemma_p.py); starts 1..102 all reach a palindrome within 18 steps
next idea: Formalize Lemma P in Lean (carry normalization of a symmetric digit list plus the bridge IsBasePalindrome <-> digit list is a palindrome). That turns the conjecture into the cleaner statement "no term is carry-free", where carry-free means all d_i + d_{L-1-i} <= 2. Then look for an invariant on the carry pattern of x + rev3(x) that survives one more step, for example a statement about the carry word of a(n) (always containing some carried position whose mirror carries differently) that propagates under the map. The outer-digit window will not do (see dead ends).
dead ends: (1) a self-similar block pattern as in the binary Lychrel proof for 10110_2: none up to 100000 steps; runs of equal digits per digit stay >= 0.397. (2) modular obstructions (mod 2, mod 4): palindromes of odd length take every residue. (3) a finite-state invariant on a bounded window of outer digits: the first heavy mirrored pair sits as deep as 38 from the ends (step 18963), with roughly geometric depth distribution. (4) speeding up the Lean kernel check with small constant fuel: same time, because fuel is not the bottleneck.
confidence: high because the bounded claim is kernel-checked with standard axioms only; the search is cross-checked by two implementations; and Lemma P has a short paper proof that agrees with exhaustive enumeration up to 18 digits. The full conjecture remains open.
```


start: 1791104952 (date -u +%s), 2026-10-04 09:09 UTC

## Phase A: understanding

### Statement (from the Lean source `FormalConjectures/OEIS/77408.lean`)

- `revBase b n := Nat.ofDigits b (Nat.digits b n).reverse`.
  `Nat.digits b n` is little-endian with no leading zeros (and `digits b 0 = []`).
  Reversing and re-reading gives the usual digit reversal; trailing zeros of `n` vanish.
- `IsBasePalindrome b n := n = revBase b n`.
- `a 0 = 103`, `a (n+1) = a n + revBase 3 (a n)`.
- `conjecture (n : ℕ) : ¬ IsBasePalindrome 3 (a n)`.

In words: no term of the base-3 reverse-and-add trajectory of 103 = 10211_3 is a base-3 palindrome.

### Edge cases

- `n = 0`: `a 0 = 103 = 10211_3`, which is not a palindrome. The statement covers `n = 0` too, consistent with the docstring.
- `revBase 3 0 = 0`, so 0 would count as a palindrome, but `a n ≥ 103` for all `n` (it is increasing).
- Trailing zeros: if `a n` ends in digit 0, `revBase` has fewer digits, so `a n ≠ revBase 3 (a n)`. This matches the usual convention that such numbers are not palindromes.
- No subtraction, division, `sInf` or `sSup` appears. No hypotheses.

### Red team

- Parity: 3 ≡ 1 (mod 2), so `n ≡ rev(n) ≡ digit sum (mod 2)`, and every `a n` with `n ≥ 1` is even. Palindromes can be even, so this gives nothing.
- Mod 4 (3 ≡ -1): an even-length palindrome is ≡ 0 (mod 4), but odd-length palindromes can take any residue. No modular obstruction is visible, which is expected because the problem is open.
- The Lean `revBase` equals the textbook digit reversal, `IsBasePalindrome` is the textbook palindrome property, and `a` is the trajectory from 103.
- statement check: matches.
- Note: the docstring's "smallest number" claim (no smaller start fails) is NOT part of the Lean statement. The Lean statement concerns only the trajectory of 103.

### Small cases reproduced (own code, `traj.py`)

- a(0..14) = 103, 230, 436, 776, 2424, 3856, 7400, 20856, 30928, 60920, 220248, 242704, 432896, 857152, 1460408. Matches the problem file.
- Starts 1..102 all reach a palindrome. The worst is 18 steps (53, and 79 ties). Matches.
- The base-3 digit strings of the first 60 terms show no regular block pattern (see `traj.py` output).
  `runs.py`: the maximum run of equal digits up to step 3000 jumps around (for example 35 at step 1114, then 9 at step 1200).
  So there is no sign of the self-similar block structure that proves the binary Lychrel case of 10110_2.
- `lake build Solution` with the import passes (the module was already compiled; 7 s).

## Phase B: try to break it

Clock at start of phase B: 1791105040 (+88 s).

- `search.c`: plain digit-array reverse-and-add in base 3, checks every term with a two-pointer palindrome test.
  Cross-check: at step 5999 (3582 digits), value mod 1e9+7 = 47550255 from both `search.c` and independent Python big-integer code. They agree.
- Run `./search 1000000` (log in `search_1e6.log`): no palindrome among a(0..999999). The final term has 597449 base-3 digits. Wall time was about 12 minutes.
- `structure.c` over steps 0..99999, no palindrome:
  - Runs of equal digits per digit never drop below 0.397 (minimum at step 203). There is no low-complexity block structure, unlike the provable binary Lychrel case 10110_2, whose terms have O(1) runs.
  - The longest outer prefix that matches the reversed suffix is 37 digits (step 18964, length 11323).
    This is well above the ~10 a random string would give, because x + rev(x) is symmetric before carries (see Phase C). It is still tiny compared with the length.
- Structured candidates: the trajectory is one fixed sequence, so the only "candidates" are later terms. There is no family to choose from.

## Phase C: try to prove it

Clock at start of phase C: about 1791105122 (+170 s). The bounded Lean check was written early because it was cheap.

### C1. Lemma P: when is x + rev(x) a base-3 palindrome? (proved on paper)

Notation: x has L base-3 digits d_0 … d_{L-1} (little-endian, d_{L-1} ≥ 1).
s_i = d_i + d_{L-1-i} ∈ [0,4], so s is symmetric (s_i = s_{L-1-i}).
Carries: c_0 = 0, and s_i + c_i = e_i + 3 c_{i+1} with e_i ∈ {0,1,2}.
Since s_i + c_i ≤ 5, every c_i ∈ {0,1}. y = x + rev(x) has digits e_0 … e_{L-1}, plus e_L = 1 when c_L = 1 (overflow).

**Lemma P.** y is a base-3 palindrome iff
(N) s_i ≤ 2 for all i ("x is carry-free"), or
(O) x is itself a palindrome with all digits in {0,2}.

Proof.
- (N) ⇒ palindrome: there are no carries, so e_i = s_i, which is symmetric.
- (O) ⇒ palindrome: x = 2z, where z is a {0,1}-palindrome of length L.
  y = 2x = 4z = z + 3z has digits z_k + z_{k-1} ≤ 2 (no carries), for k = 0..L.
  That sequence is symmetric under k ↔ L-k because z is a palindrome.
- Palindrome, no overflow (c_L = 0, so y has L digits): e_i = e_{L-1-i}.
  Subtracting the two carry equations gives c_i - c_{L-1-i} = 3(c_{i+1} - c_{L-i}).
  The left side is in {-1,0,1}, so both sides are 0.
  So c_{i+1} = c_{L-i} = c_{i-1} for 1 ≤ i ≤ L-1, and c_1 = c_L = 0 (take i = 0).
  With c_0 = 0, all carries are 0, so s_i = e_i ≤ 2. That is (N).
- Palindrome, overflow (c_L = 1 = e_L, y has L+1 digits): e_k = e_{L-k}.
  - At k = 0: s_0 = 1 + 3c_1.
  - For 1 ≤ k ≤ L-1, using s_{L-k} = s_{k-1}: s_k + c_k - 3c_{k+1} = s_{k-1} + c_{L-k} - 3c_{L-k+1}.
  - Telescoping gives, for 0 ≤ m ≤ L-1, with A_m = c_1+…+c_m, B_m = c_{L-m+1}+…+c_L and D_m = A_m - B_m:
    s_m = 2D_m + c_{L-m} + 3c_{m+1}, hence e_m = 2D_m + c_{L-m} + c_m ∈ [0,2].
  - Let m be minimal with c_{m+1} ≠ c_{L-m}. Then m ≤ L-2, because the pairs for m and L-1-m are the same pair. Also D_m = 0, so D_{m+1} = c_{m+1} - c_{L-m} = ±1.
    - If D_{m+1} = 1: e_{m+1} = 2 + c_{L-m-1} + c_{m+1} ≤ 2 forces c_{m+1} = 0, but c_{m+1} = 1. Contradiction.
    - If D_{m+1} = -1: e_{m+1} ≥ 0 forces c_{m+1} = 1, but c_{m+1} = 0. Contradiction.
  - So the carries are symmetric, D ≡ 0, and s_m = 4c_{m+1} ∈ {0,4}.
    Then d_m = d_{L-1-m} ∈ {0,2}, which is (O). ∎

Computer check of Lemma P (independent of the proof):
- `lemma_p.py`: exact set equality for every x with L ≤ 13 digits. 0 mismatches.
- `lemma_p.c`: exact set equality for every x with L ≤ 18 digits. 0 mismatches.
- `density.c`: the palindrome counts for L ≤ 17 split as 6^{⌊L/2⌋} or 3·6^{L/2-1} (no overflow, which equals #(N)) and 2^{⌈L/2⌉-1} (overflow, which equals #(O)).

### C2. Reduction of the conjecture (proved on paper from Lemma P)

**Corollary.** `∀ n, ¬ IsBasePalindrome 3 (a n)` ⟺ every term a(n) has a "heavy" mirrored pair: some i with d_i + d_{L-1-i} ≥ 3.

Proof.
- (⇐) By induction: a(0) = 10211_3 is not a palindrome. If a(n) is not a palindrome, (O) fails. (N) fails by hypothesis. So by Lemma P, a(n+1) is not a palindrome.
- (⇒) If some a(n) were carry-free, (N) would make a(n+1) a palindrome. ∎

So the problem is equivalent to: the reverse-and-add map never produces a carry-free term from 103.

### C3. What the reduction does not give (dead end)

`heavy.c` over 100000 steps: the first heavy pair (counted from the outside) sits at depth 0 in 40% of terms.
The depth distribution decays roughly geometrically (ratio about 2/3, the chance a random pair is light).
The maximum depth is 38 (step 18963, length 11323).
So the heavy pair is not pinned to a bounded window at the ends, and a finite-state "outer digits" invariant cannot work.
The carries that reach the outer digits come from the chaotic middle.

### C4. Lemma status

- Lemma P, no-overflow half: proved on paper.
- Lemma P, overflow half: proved on paper.
- Corollary (reduction): proved on paper.
- "No term of the trajectory is carry-free": unknown. This is the open problem itself.
  Heuristically, a random term of length L is carry-free with probability about (2/3)^{L/2}, and Σ over the trajectory (L ≈ 0.6 k) converges fast.

### C5. Lean (Solution.lean, all in namespace `A077408Sweep`)

1. `revAux`: base-3 digit reversal by structural recursion on fuel (kernel friendly; `Nat.digits` is not used at evaluation time).
2. `revAux_eq`: with fuel ≥ n, `revAux fuel n acc = ofDigits 3 (digits 3 n).reverse + acc * 3^len`.
3. `revBase_eq_revAux`: `revBase 3 n = revAux n n 0`.
4. `check`, `check_sound`: `check (a m) k = true → ∀ i < k, ¬ IsBasePalindrome 3 (a (m + i))`.
5. `check_103_1000 : check 103 1000 = true` by `decide +kernel` (about 55 s of kernel time).
6. `no_palindrome_below_1000 (n) (hn : n < 1000) : ¬ IsBasePalindrome 3 (a n)`.
   `#print axioms`: [propext, Classical.choice, Quot.sound]. No sorry or native_decide.
- Bound choice: 1000 steps builds in about 60 s. The kernel cost grows about quadratically: 200 steps take 10 s and 1000 take 60 s.
  A constant-fuel variant (`revAux 1000 x 0` with an in-checker bound `x < 3^F`) took the same time, so fuel is not the bottleneck.
  I kept 1000 so a checker can rebuild in about a minute. Decision recorded here.
- Lemma P is not formalized. It would need a carry-normalization of digit lists and the bridge `IsBasePalindrome ↔ digits palindrome`. I estimate 200+ lines, which does not fit the remaining time. Decision: leave it on paper.

## Phase D

End clock: see the commit time. The report block is at the top. (Elapsed at first draft of this report: 14 minutes.)
Formalizing Lemma P (an estimated 200+ lines of carry and digit-list Lean) would not have fit safely in the remaining time.
A half-finished `sorry` skeleton in `Solution.lean` would have muddied the sorry-free deliverable.
