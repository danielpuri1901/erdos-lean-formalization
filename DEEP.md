# Deep attempt on one open problem

This is stage 2.
Stage 1 gave this problem one hour.
Its notes are in `sweep/<id>/NOTES.md`, and its Lean work is in `Solution.lean` and `Solution/`.
You now have about four hours and many attempts.
The goal is a complete Lean proof, or a Lean disproof, of the statement in `problems/<id>.md`.
The most likely outcome is still that the problem stays open.
Two things must not happen: a false claim, and four hours that leave no usable record.

## Roles

You are the manager.
You plan, you keep the notebook, and you check every result.
Workers are fresh subagents with model `opus`.
Each worker gets one item and 30 minutes.
A worker knows nothing except what your brief tells it, so the brief carries everything it needs.
You may think about the mathematics yourself between attempts.
Write what you conclude into the notebook before you act on it.
At most two workers run at the same time, and only on items that do not depend on each other.

## The notebook

`deep/<id>/NOTEBOOK.md` is the memory of this run.
Create it first, from the stage 1 notes, with these sections:

1. Target: the exact Lean statement, and the working reformulation you are trying to prove.
2. Route: the current proof plan as a numbered list of lemmas.
   Each lemma has a status: open, proved on paper, reviewed, proved in Lean, or refuted.
3. Facts: computed facts with exact ranges and the file that produced them.
4. Attempts: a numbered log.
   Each entry has the item, the worker's result, what was tried, what blocked it, the files, and the minutes used.
5. Dead ends: approaches that are ruled out, and why.

Write `date -u +%s` at the top as the start time.
Commit and push after every attempt with the message `deep(<id>): attempt <n> <result>`.

## The loop

1. Check the stop conditions.
2. Choose the next item.
   Prefer the item that tells you soonest whether the current route can work.
   Test a lemma on more cases before you try to prove it.
   Prove the smallest unproved lemma before the big one.
3. Write the brief: the goal as one precise statement, the context copied from the notebook (definitions, lemmas it may use, dead ends), the definition of done, the deadline in epoch seconds, and the report format below.
4. When the worker returns, check the result yourself.
   A Lean result: run `export PATH=/opt/lean/bin:$PATH && lake build Solution` and look for `sorry`.
   A paper proof: give it to a second fresh worker whose only job is to find a gap. Mark it "reviewed" only after that.
   A computation: read the code, and rerun a small part with independent code.
5. Update the notebook, commit, push.

Worker report format:

```
result: proved-in-lean | proved-on-paper | refuted | partial | stuck
statement: <the exact statement established or refuted>
tried: <two lines>
blocking: <two lines>
files: <paths>
```

## Rules for proofs

- Write the argument in plain mathematics before any Lean.
- Lean work is skeleton first.
  Step 1: definitions and notation.
  Step 2: every lemma stated with `sorry`; the build must pass.
  Step 3: each line of the written proof becomes one Lean line, still closed by `sorry`.
  Step 4: fill the `sorry`s one at a time.
- Keep the Lean aligned with the route in the notebook; put the lemma numbers in comments.
- The final theorem must have exactly the imported statement: `theorem <new name>.{u} : type_of% @<Imported.name>.{u} := ...` (see `LESSONS.md`).
- Nothing reported as proved contains `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`.
- Do not edit `problems/`, `DEEP.md`, `SWEEP.md`, `Challenge.lean`, `lakefile.toml`, `lake-manifest.json` or `lean-toolchain`.
- Do not search the web for solutions and do not look for existing formalizations.
  A published result that you remember is "from memory, unverified", and it is not a lemma until it is proved here or found in Mathlib.
- Every computation has a hard time limit.
  Start anything longer than a minute in the background, and stop it by process id.
- Do not ask questions.
  Decide, and write the decision into the notebook.

## When stuck

- Two attempts in a row on one item with no progress: change the approach or the item, and write the change into the notebook.
- Three: mark the item blocked.
- When the key lemma of the route is blocked or refuted: write a new route, or stop.
- A refuted lemma is progress.
  Record the counterexample.

## Stop

Stop when one of these holds:

- The target is proved or disproved in Lean.
- Four hours of wall clock have passed since the start time in the notebook.
- Ten attempts are logged.
- The file `STOP` exists on the remote branch. Check before each attempt: `git fetch -q origin && git cat-file -e origin/$(git branch --show-current):STOP`.
- No route is left that you believe in. Say so plainly.

Then put this block at the top of the notebook:

```
result: solved | disproved | partial | stuck
claim: <the exact statement established, or "none">
lean: <file and theorem names that build with no sorry, or "none">
computed: <what was only checked by computer, with ranges>
route: <the best route and where it stands>
next idea: <the most promising next step, one paragraph>
dead ends: <approaches that failed>
confidence: <low | medium | high> because <reason>
```

Append what cost you time to `LESSONS.md`.
Commit with the message `deep(<id>): done <result>`, push, and stop.

A human and a separate checker review every `solved` and `disproved` before anyone repeats the claim.
