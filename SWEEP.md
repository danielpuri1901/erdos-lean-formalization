# Sweep: one bounded attempt on one open problem

You have one open problem and 60 minutes.
The session prompt names the problem id; its file is `problems/<id>.md`.
The statement is tagged open in formal-conjectures, so nobody may have a proof.
Most attempts will not solve it.
An honest "stuck, and here is how far I got" is a good result.
A false claim of success is the worst result.

## Rules

- Time box: 60 minutes of wall clock.
  Write `date -u +%s` into the notes when you start, and check the clock before each phase.
  At minute 50, stop working and write the report.
- Work in `sweep/<id>/` (notes, search code) and in `Solution.lean` (Lean).
- Commit and push after every phase with the message `sweep(<id>): phase A` (or B, C).
  If the session dies, the notes survive.
- A result you report as proved contains no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`.
- Do not edit `problems/`, `SWEEP.md`, `Challenge.lean`, `lakefile.toml`, `lake-manifest.json` or `lean-toolchain`.
- Do not search the web for solutions and do not look for existing formalizations.
  Work from the mathematics and from computation.
  A published result that you remember goes into the notes marked "from memory, unverified".
- Use the tools already on the machine (Python 3 standard library, a C compiler if present).
  Do not spend time installing packages.
- Every computation has a hard time limit, for example `timeout 600 python3 search.py`.
- Do not ask questions.
  Decide, and write the decision into the notes.
- Ignore `Solution/Green72`, `data/` and `Timing*`: they are leftovers from an earlier target.

## Phase A: understand (about 10 minutes)

1. Read `problems/<id>.md` and the Lean source file it names.
2. Start `export PATH=/opt/lean/bin:$PATH && lake build Solution` in the background after you put the problem's `import` into `Solution.lean`.
   The first build compiles the formal-conjectures module and can take several minutes.
3. Write into `sweep/<id>/NOTES.md`: the statement in your own words, and every definition it uses, read from the Lean source and not from the docstring.
4. Check the edge cases: empty type, zero, one, natural-number subtraction, division, `sInf` or `sSup` of an empty or unbounded set, hypotheses that can never hold.
5. Red-team the statement.
   Does the Lean statement say what the docstring says?
   Is it true or false for a trivial reason?
   Write "statement check: matches", or describe the gap exactly.
   A real gap is a valuable finding; prove it in Lean if you can.
6. Reproduce the small-case numbers from the problem file with your own code.
   If your numbers differ, find out why before you go on.

## Phase B: try to break it (about 15 minutes)

- Search for a counterexample beyond the range already checked.
- Prefer structured candidates (extremal families, known troublemakers) over blind enumeration.
- Record every range you searched and the result, exactly.
- Check a candidate counterexample a second time with independent code before you believe it.

## Phase C: try to prove it (about 20 minutes)

- Write the argument in plain mathematics first, in the notes.
  No Lean yet.
- List the lemmas the argument needs and mark each one: proved on paper, plausible, or unknown.
- Formalize only when every lemma is proved on paper, or when you hold a verified counterexample.
- When you formalize, build a skeleton first.
  Step 1: definitions and notation.
  Step 2: every lemma stated in Lean with `sorry`; `lake build Solution` must pass.
  Step 3: each line of the written proof becomes one Lean line, still closed by `sorry`.
  Step 4: fill the `sorry`s one at a time.
- Keep the Lean proof aligned line by line with the written argument, so a person can read and debug it.
- Do not restate the imported theorem under its own name; use a new name, and state the negation when you disprove.
- When the whole problem is out of reach, a proved special case or a proved reduction is still worth recording.
  State exactly what it covers.

## Phase D: report (the last 10 minutes)

Put this block at the top of `sweep/<id>/NOTES.md`:

```
result: solved | disproved | statement-flaw | partial | stuck
claim: <the exact statement you established, or "none">
lean: <file and theorem names that build with no sorry, or "none">
computed: <what was only checked by computer, with ranges>
next idea: <the most promising next step, one paragraph>
dead ends: <approaches that failed, so nobody repeats them>
confidence: <low | medium | high> because <reason>
```

Then append one line per Lean or tooling problem that cost you time to `LESSONS.md`.
Commit with the message `sweep(<id>): done <result>` and push.
Then stop.

## What counts

- `solved` and `disproved` need a Lean theorem that builds with no `sorry`.
  A computer search that finds nothing is `partial` or `stuck`, never `solved`.
- A human and a separate checker review every `solved`, `disproved` and `statement-flaw` before anyone repeats the claim.
