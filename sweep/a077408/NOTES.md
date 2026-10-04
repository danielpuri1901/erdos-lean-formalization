# Sweep a077408: reverse and add in base 3, start 103

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
- Run `./search 1000000` (log in `search_1e6.log`): see the result line below (filled in when the run finishes).
- `structure.c` over steps 0..99999, no palindrome:
  - Runs of equal digits per digit never drop below 0.397 (minimum at step 203). There is no low-complexity block structure, unlike the provable binary Lychrel case 10110_2, whose terms have O(1) runs.
  - The longest outer prefix that matches the reversed suffix is 37 digits (step 18964, length 11323).
    This is well above the ~10 a random string would give, because x + rev(x) is symmetric before carries (see Phase C). It is still tiny compared with the length.
- Structured candidates: the trajectory is one fixed sequence, so the only "candidates" are later terms. There is no family to choose from.
