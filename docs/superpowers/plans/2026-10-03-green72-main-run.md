# Green 72 Main Run Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Prepare and launch the Green 72 main run: six measured runs (three with the harness, arm B; three bare, arm A) that each try to prove the frozen statement of `Green72.no_three_in_line_le`, judged only by the external checker.

**Architecture:** Each run works on its own branch `run/<arm><n>` of the agent repository, cut from one staging commit, so runs never share a working state.
The checker's `check-submits` poller verifies `submit(green72):` commits on `main` and on every `run/*` branch.
Runs go one at a time, so the cloud credit meter attributes cost to exactly one run; the executor session (local) starts each run through Chrome and records the meter before and after.

**Tech Stack:** Lean 4 v4.33.1, formal-conjectures pin `df3f12d7bd06`, Comparator under landrun in GitHub Actions, Claude Code cloud sessions (environment `erdos-lean`), Python 3 standard library, Bash.

**Spec:** `docs/superpowers/specs/2026-10-02-lean-formalization-harness-design.md` (sections 3, 5, 6, 7).
Previous plan: `docs/superpowers/plans/2026-10-02-lean-formalization-harness.md`; its ledger holds every ruling made so far.

## Global Constraints

- Lean toolchain is exactly `leanprover/lean4:v4.33.1`; formal-conjectures stays at `df3f12d7bd06feb3f71ae37abae0ca7cb798d9b1`.
- Permitted axioms: `propext`, `Quot.sound`, `Classical.choice`. `native_decide` is banned; kernel checks use `decide +kernel`.
- Success is only a green `comparator/green72` commit status from the checker repository.
- Every cloud run is a plain cloud session; never a Routine or a Project.
- The checker repository is never attached to a cloud session.
- Both arms use Claude Opus 5.5 at effort xhigh (Fable 5.1's weekly limit is used up until 2026-10-04 01:00, and mixing models would confound the arms).
- Budget: about 247 USD of cloud credit before the warm-up; 20 USD reserve is never scheduled; run kill date 2026-10-24.
- Markdown prose: one sentence per line, no em dashes.
- Headline wording: "kernel-verified computer search result for a Green problem", never "solved an Erdős problem".

## Review Focus

1. A bare run (arm A) that edits `Challenge.lean` or the lakefile must still be judged against the frozen statement and build settings; the checker already overwrites both (Task 3 test reuses the freeze test idea on a `run/*` branch).
2. A `submit(green72):` commit on a `run/*` branch must be found by the poller exactly once; Task 3's unit test pins branch scanning and de-duplication.
3. A worker that hides an axiom in a new module under `Solution/` must be stopped by the guard early and rejected by Comparator in any case; Task 1 pins the guard.
4. The witness data module must match the verified JSON exactly; Task 2 regenerates it and compares.
5. A run that exceeds its cap must stop: arm B through `STATE.json` and the kill rule, arm A by the executor stopping the session; Task 5 writes the caps where both read them.

---

## File structure

Agent repository:

- `Solution/Green72/Witnesses.lean`: generated data module with the Nat collinearity checker and the 58 witness lists `w3` to `w60`.
- `scripts/witness.py`: gains `emit_lean()`, which writes that module from `data/green72/*.json`.
- `scripts/hooks/guard.sh`: also guards every file under `Solution/`.
- `docs/main-run.md`: protocol, caps, prompts, and the result table.
- Branches `run/b1`, `run/a1`, `run/b2`, `run/a2`, `run/b3`, `run/a3`, created from the staging commit; `run/a*` drop the harness files.

Checker repository:

- `challenge/green72.lean`, `comparator/green72.json`, `scripts/axioms/green72.lean`.
- `scripts/pending_submits.py`: scans `main` and `run/*` branches.

---

### Task 1: Guard covers modules under `Solution/`

**Files:**
- Modify: `scripts/hooks/guard.sh`, `tests/test_guard.sh`

- [ ] **Step 1: Write the failing test** (append before `exit $fail` in `tests/test_guard.sh`):

```bash
check deny_axiom_submodule 2 '{"tool_name":"Write","tool_input":{"file_path":"/w/erdos-lean-formalization/Solution/Green72/Lemmas.lean","content":"axiom bad : False"}}'
check allow_submodule 0 '{"tool_name":"Write","tool_input":{"file_path":"/w/erdos-lean-formalization/Solution/Green72/Lemmas.lean","content":"theorem x : True := trivial"}}'
```

and change the expected denial count in `denials_logged` from 5 to 6.

- [ ] **Step 2: Run it and watch `deny_axiom_submodule` fail**: `bash tests/test_guard.sh`.

- [ ] **Step 3: Implement**: in `scripts/hooks/guard.sh` change the case pattern `*/Solution.lean|*/solutions/*)` to `*/Solution.lean|*/Solution/*|*/solutions/*)`.

- [ ] **Step 4: Run** `bash tests/test_guard.sh`; expected all `ok`.

- [ ] **Step 5: Commit** on branch `main-run-prep`.

### Task 2: Witness data module and the `decide +kernel` axiom check

**Files:**
- Modify: `scripts/witness.py`, `tests/test_witness.py`, `Timing.lean`, `.github/workflows/build.yml`
- Create: `Solution/Green72/Witnesses.lean` (generated)

- [ ] **Step 1: Write the failing test** (append to `tests/test_witness.py`):

```python
def test_emit_lean_matches_json(tmp_path):
    out = tmp_path / "W.lean"
    witness.emit_lean(out_file=out, data_dir="data/green72")
    text = out.read_text()
    for n in (3, 17, 60):
        pts = json.load(open(f"data/green72/{n}.json"))["points"]
        assert f"def w{n} : List (ℕ × ℕ) := {witness.lean_list([tuple(p) for p in pts])}" in text
    assert "def noThree" in text and "namespace Green72Data" in text
```

- [ ] **Step 2: Run** `python3 -m pytest tests/test_witness.py -q`; expected 1 failure (`emit_lean` missing).

- [ ] **Step 3: Implement** `emit_lean(out_file="Solution/Green72/Witnesses.lean", data_dir="data/green72")` in `scripts/witness.py`: write a module docstring naming the sources, `namespace Green72Data`, the definitions of `collinear3`, `noThree` (with `pairsOk` and `allOk`), `inGrid` from `Timing/NoThree.lean`, and `def wN : List (ℕ × ℕ) := ...` for N from 3 to 60, then `end Green72Data`.
Add `python3 scripts/witness.py lean` as the command line entry.

- [ ] **Step 4: Run the tests** (expected 6 passed), then generate the module: `python3 scripts/witness.py lean`.

- [ ] **Step 5: Check that `decide +kernel` adds no axiom**: in `Timing.lean` replace the `example` with `theorem w60_ok : noThree w60 = true ∧ inGrid 60 w60 = true ∧ w60.length = 120 := by decide +kernel` followed by `#print axioms w60_ok`; in `build.yml` move the timing step before the axiom step.
Dispatch `build.yml` on the prep branch and read the log.
Expected: `'w60_ok' does not depend on any axioms` (or a subset of the permitted three).

- [ ] **Step 6: Commit.**

### Task 3: Checker target `green72` and branch scanning

**Files (checker repository):**
- Create: `challenge/green72.lean`, `comparator/green72.json`, `scripts/axioms/green72.lean`
- Modify: `scripts/pending_submits.py`, `tests/test_pending_submits.py`

- [ ] **Step 1: Write the failing test** (append to `tests/test_pending_submits.py`):

```python
def test_select_branches_dedupes_shared_commits():
    by_branch = {"main": [c("m1", "submit(green72): b")],
                 "run/a1": [c("a1", "submit(green72): a"), c("m1", "submit(green72): b")]}
    got = ps.select_branches(by_branch, {}, {"green72"})
    assert got == [{"sha": "m1", "target": "green72"}, {"sha": "a1", "target": "green72"}]

def test_watched_branches():
    assert ps.watched(["main", "run/b1", "run/a2", "freeze-test", "feature"]) == ["main", "run/b1", "run/a2"]
```

- [ ] **Step 2: Run** `python3 -m pytest tests/test_pending_submits.py -q`; expected 2 failures.

- [ ] **Step 3: Implement** `watched(names)` (keep `main` and names starting with `run/`, in order) and `select_branches(by_branch, statuses, targets)` (concatenate `select` per branch, dropping a sha already chosen); `main()` lists branches with `GET /repos/{repo}/branches?per_page=100`, fetches `commits?sha=<branch>&per_page=30` for each watched branch, and prints the matrix.

- [ ] **Step 4: Write the target files.**
`challenge/green72.lean`:

```lean
import FormalConjectures.GreensOpenProblems.«72»

/-! Frozen statement for the green72 target. The checker overwrites the agent's `Challenge.lean` with this file before every verdict. -/

/-- Green's Open Problem 72 for small grids: for 3 ≤ N ≤ 60 the pigeonhole bound 2N is attained.
This is `Green72.no_three_in_line_le` at formal-conjectures commit df3f12d7bd06, renamed so it does not clash with the imported declaration. -/
theorem green72_no_three_in_line_le {N : ℕ} (hN : 3 ≤ N) (hN' : N ≤ 60) :
    Green72.NoKInLineFor 3 N := by
  sorry
```

`comparator/green72.json`: the erdos105 file with `theorem_names` `["green72_no_three_in_line_le"]`.
`scripts/axioms/green72.lean`: the erdos105 audit with the theorem name replaced.

- [ ] **Step 5: Run the tests** (expected 4 passed), commit, push the checker.

### Task 4: Staging commit and run branches

**Files (agent repository, branch `main-run-prep`):**
- Modify: `Challenge.lean` (copy of `challenge/green72.lean`), `Solution.lean`, `TASKS.md`
- Create: `docs/main-run.md`

- [ ] **Step 1:** `Solution.lean` imports `Solution.Green72.Witnesses`, opens `Green72Data`, and holds the statement with `sorry`; plus the arm B skeleton below as lemma stubs with `sorry` (written outside any session, so the guard does not apply).

```lean
/-- The real points of a Nat witness. -/
noncomputable def toReal (p : ℕ × ℕ) : ℝ × ℝ := ((p.1 : ℝ), (p.2 : ℝ))

/-- Step 1: the Bool checker is sound for three distinct points of the list. -/
theorem cross_ne_of_noThree {l : List (ℕ × ℕ)} (h : noThree l = true) (hl : l.Nodup)
    {a b c : ℕ × ℕ} (ha : a ∈ l) (hb : b ∈ l) (hc : c ∈ l)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) : collinear3 a b c = false := by
  sorry

/-- Step 2: unequal cross terms mean three non-collinear real points. -/
theorem not_collinear_of_cross {a b c : ℕ × ℕ} (h : collinear3 a b c = false) :
    ¬ Collinear ℝ ({toReal a, toReal b, toReal c} : Set (ℝ × ℝ)) := by
  sorry

/-- Step 3: a verified witness list is an allowed set. -/
theorem allowedSet_of_witness {N : ℕ} {l : List (ℕ × ℕ)} (hl : l.Nodup)
    (hg : inGrid N l = true) (h3 : noThree l = true) :
    Green72.AllowedSet 3 N l.toFinset := by
  sorry

/-- Step 4: an allowed set of size 2N gives the equality. -/
theorem noKInLineFor_of_allowed {N : ℕ} {s : Finset (ℕ × ℕ)}
    (hs : Green72.AllowedSet 3 N s) (hc : s.card = 2 * N) : Green72.NoKInLineFor 3 N := by
  sorry
```

Step 5 of the lemma plan (per-N kernel facts in modules `Solution.Green72.W<N>`, then `interval_cases N`) stays prose in `TASKS.md`.

- [ ] **Step 2:** dispatch `build.yml` on `main-run-prep`; expected: the build succeeds with `sorry` warnings only.
If a stub does not elaborate, fix its statement until the build is green.

- [ ] **Step 3:** `TASKS.md` gets one row `G72 | green72 | prove green72_no_three_in_line_le with the lemma plan below | todo` and a `## green72` section: the published result (Flammenkamp's database and Prellberg's Table 1, verified exactly in `data/green72/`), the upper bound already in formal-conjectures (`Green72.allowedSetSize_le`), and the five-step plan above.

- [ ] **Step 4:** write `docs/main-run.md` (Task 5 gives its content), commit, and create the branches:

```bash
git branch run/b1 && git branch run/b2 && git branch run/b3
for a in a1 a2 a3; do
  git checkout -q -b run/$a main-run-prep
  git rm -q -r AGENTS.md prompts TASKS.md LEDGER.md STATE.json .claude/settings.json scripts/hooks scripts/ledger.sh scripts/state.py
  mkdir -p .claude && printf '%s\n' '{"hooks":{"SessionStart":[{"matcher":"startup|resume","hooks":[{"type":"command","command":"bash \"$CLAUDE_PROJECT_DIR\"/scripts/session-start.sh"}]}]}}' > .claude/settings.json
  git add -A && git commit -q -m "run: bare arm, harness removed"
done
git checkout -q main-run-prep
```

Push the branches only after the warm-up is green (Task 6), so the warm-up session never sees them.

### Task 5: Protocol, caps, and prompts (`docs/main-run.md`)

- [ ] Write `docs/main-run.md` with:
  - Order: `b1, a1, b2, a2, b3, a3`, one at a time.
  - Caps per run: arm B 35 USD and 4 hours; arm A 20 USD and 4 hours (70 to 30 split of about 165 USD).
  - Stop launching when the credit left is below the next run's cap plus the 20 USD reserve.
  - Arm B prompt: the warm-up orchestrator prompt with `erdos105` replaced by `green72`, the branch named, and the cap.
  - Arm A prompt: "Prove `green72_no_three_in_line_le` in `Solution.lean`. `Challenge.lean` holds the frozen statement. Witness data and a Nat collinearity checker are in `Solution/Green72/Witnesses.lean`; the data is verified. Build with `export PATH=/opt/lean/bin:$PATH && lake build Solution`. When the proof builds with no `sorry`, commit with the message `submit(green72): bare run` and push to this branch, then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until `comparator/green72` is success or failure. On failure read the description, fix, and submit again. Stop at success or after 4 hours."
  - Result table: run, arm, solved, minutes to green, USD (meter delta), attempts, submissions, cheats caught (`do not match` or `Illegal axiom` descriptions plus guard denials), failure classes.

### Task 6: Close the warm-up and launch run b1

- [ ] When `comparator/erdos105` is `success`: `git pull`, copy `Solution.lean` to `solutions/erdos105.lean`, record the warm-up in `docs/preflight.md` ("Erdős 105 warm-up": attempts, minutes, credit meter delta, failure classes, denials, checker run URL), commit, push.
- [ ] Rebase `main-run-prep` on `main`, merge it into `main`, recreate the `run/*` branches from the merged commit, push `main` and all `run/*` branches.
- [ ] Read the credit meter, start a cloud session on branch `run/b1` (Opus 5.5, effort xhigh, Auto) with the arm B prompt, and record the start in `docs/main-run.md`.
- [ ] Chain the remaining runs: when a run ends (green status, cap, or stop), read the meter, fill its row, and start the next run in order.
