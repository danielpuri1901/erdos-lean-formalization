# Lessons

Read this before you write Lean.
Add one line for each problem that cost you time, with the fix.

- Build with `export PATH=/opt/lean/bin:$PATH && lake build Solution`.
  Never run `lake update` or `lake exe cache get`: the packages are prebuilt.
- The first import of a formal-conjectures module compiles it, which takes minutes; start that build early.
- File names that are numbers need guillemets in the import: `import FormalConjectures.OEIS.«77408»`.
- formal-conjectures files use the Lean module system; a plain `import` of the module is enough in `Solution.lean`.
- `ℕ` needs Mathlib notation in scope; `Nat` always works.
- Use `decide +kernel` for finite checks.
  `native_decide` is banned.
- One `decide +kernel` over about 280 thousand cases used 5.5 GB; split large checks into chunks of about 10 thousand cases.
- A `noncomputable` definition built from `sInf` cannot be evaluated by `decide`.
  Prove a bridge lemma to a computable version first, as `dom_num_eq_computable` does in `FormalConjecturesForMathlib/Combinatorics/SimpleGraph/Domination.lean`.
- A theorem restated under the name of an imported declaration clashes; pick a new name.
- `push_cast` in a goal (not hypotheses) can rewrite `↑(l.sum)` into `(l.map Nat.cast).sum`, so `omega` sees two atoms; use `simp only [Nat.cast_zero, Nat.cast_one]` plus `linarith` instead.
- `omega` treats `q + 1 + 1` and `q + 2` inside a product as different atoms; state helper inequalities in exactly the form `rcases` produced.
- `Nat.pos_pow_of_pos` no longer exists; use `by positivity`. `push_neg` is deprecated; use `not_lt.mp`.
- `norm_num` evaluates `Nat.digits 10 <literal>` and `n ∣ <literal>`, so `⟨by norm_num, by norm_num, by norm_num⟩` proves membership in a 0/1-multiple set; 98 such cases built in about 15 s.
- Mathlib has `Nat.nine_dvd_iff`, `Nat.eleven_dvd_iff` (alternating sum over ℤ), `Nat.base_pow_length_digits_le`, `Nat.digits_def'`, `Nat.ofDigits_digits`: enough for digit-sum lower bounds.
