# Lean Formalization Harness Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Stand up the trusted checker, the cloud environment, the harness scripts, and the measurement protocol, then run the Erdős 105 warm-up end to end through the external checker.

**Architecture:** Two repositories.
The agent repository (`erdos-lean-formalization`) is a Lean 4 project that depends on `formal-conjectures` at a pinned commit and holds `Challenge.lean` (frozen statement), `Solution.lean` (the agent's proof), the ledger, hooks, prompts, and the environment build workflow.
The checker repository (`erdos-lean-checker`) is never attached to an agent session; its GitHub Actions workflow checks out a named agent commit, overwrites `Challenge.lean` with its own frozen copy, builds, audits axioms, runs Comparator under landrun, and writes a commit status back.

**Tech Stack:** Lean 4 v4.33.1, Lake, Mathlib at the `formal-conjectures` pin, Comparator (tag `v4.33.0`), lean4export, landrun, GitHub Actions on `ubuntu-24.04`, Bash, Python 3 standard library, Claude Code cloud sessions.

**Spec:** `docs/superpowers/specs/2026-10-02-lean-formalization-harness-design.md`

## Global Constraints

- Lean toolchain is exactly `leanprover/lean4:v4.33.1`.
- `formal-conjectures` is pinned at commit `df3f12d7bd06` (2026-10-01); resolve the full SHA once and never float.
- Mathlib is whatever that `formal-conjectures` commit pins (`v4.33.1`, rev `0df444a360ea`); never require Mathlib directly.
- Permitted axioms in any accepted proof: `propext`, `Quot.sound`, `Classical.choice`. Nothing else, no `sorryAx`, no `Lean.ofReduceBool`.
- Forbidden in any committed proof file: `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by`, `skipKernelTC`, `unsafe`.
- The checker repository is never attached to a Claude Code session, and no agent session ever receives a token for it.
- Nothing is posted to erdosproblems.com or formal-conjectures without Daniel's explicit approval of the exact text.
- All Markdown prose: one sentence per line, no em dashes.
- Every cloud run is a plain cloud session or `claude --cloud`; never a Routine or a Project (credit terms).
- Commit messages end with `Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>` when Claude wrote the change; never add an agent as a co-author otherwise.

## Review Focus

1. A `Solution.lean` that proves a theorem with the right name but a different type (for example an extra hypothesis) must be rejected by Comparator; Task 3 fixture `bad/wrong_statement.lean` pins it.
2. A `Solution.lean` that redefines a definition the statement depends on must be rejected; Task 3 fixture `bad/redefine.lean` pins it.
3. A hook-bypassing edit to `Challenge.lean` in the agent repository must change nothing about the verdict, because the checker overwrites it; Task 2 step 7 pins it with a deliberately edited challenge.
4. A setup script that takes longer than five minutes silently loses the environment cache; Task 5 step 6 measures and records the time, and the pass criterion is under five minutes.
5. A worker report that claims success without a checker run must not advance the ledger; Task 7's `state.py` counts a task as done only when a `verdict=pass` row names a checker run URL.

---

## File structure

Agent repository `erdos-lean-formalization`:

- `lean-toolchain`, `lakefile.toml`, `lake-manifest.json`: the Lean project.
- `Challenge.lean`: frozen statement for the current target (copied from the checker repository; hook-protected).
- `Solution.lean`: the agent's proof for the current target.
- `solutions/<target>.lean`: archived accepted solutions.
- `Timing/NoThree.lean`: kernel timing experiment for Green 72.
- `data/`: witness data (JSON) with provenance.
- `scripts/witness.py`: fetches, decodes, verifies, and emits witnesses.
- `scripts/ledger.sh`, `scripts/state.py`: ledger and state.
- `scripts/hooks/guard.sh`: PreToolUse guard.
- `scripts/setup-cloud.sh`: the cloud setup script (also pasted into the environment dialog).
- `.claude/settings.json`: hooks and cache TTL.
- `.github/workflows/build.yml`: builds the project in CI.
- `.github/workflows/build-env.yml`: builds and publishes the environment artifact.
- `AGENTS.md`, `prompts/orchestrator.md`, `prompts/worker.md`: run instructions.
- `TASKS.md`, `LEDGER.md`, `STATE.json`: run state.
- `docs/cloud-environment.md`, `docs/cloud-probe.md`, `docs/burn-test.md`, `docs/preflight.md`: protocols and records.

Checker repository `erdos-lean-checker`:

- `challenge/<target>.lean`: frozen statements.
- `comparator/<target>.json`: Comparator config per target.
- `scripts/check.sh`: runs Comparator.
- `scripts/axioms/<target>.lean`: axiom audit per target.
- `tests/bad/<case>.lean`: negative fixtures.
- `.github/workflows/verify.yml`: the check, with a `negative` job.

---

### Task 1: Agent repository as a Lean project with a trivial challenge

**Files:**
- Create: `lean-toolchain`, `lakefile.toml`, `Challenge.lean`, `Solution.lean`, `.github/workflows/build.yml`
- Modify: `.gitignore` (keep `.lake/` ignored; add `lake-manifest.json` is committed, not ignored)

**Interfaces:**
- Produces: library names `Challenge` and `Solution` (root modules `Challenge.lean` and `Solution.lean`); theorem `challenge_trivial`; the `formal_conjectures` dependency.

- [ ] **Step 1: Resolve the pinned SHAs**

```bash
cd ~/Desktop/Projects/erdos-lean-formalization
FC_SHA=$(gh api repos/google-deepmind/formal-conjectures/commits/df3f12d7bd06 --jq .sha); echo "$FC_SHA"
```

Expected: a 40-character SHA starting with `df3f12d7bd06`.
Record it in `docs/preflight.md` under "Pins".

- [ ] **Step 2: Write the project files**

`lean-toolchain`:

```
leanprover/lean4:v4.33.1
```

`lakefile.toml` (replace `<FC_SHA>` with the value from step 1):

```toml
name = "erdos_lean"
version = "0.1.0"
defaultTargets = ["Challenge", "Solution"]

[leanOptions]
autoImplicit = false
relaxedAutoImplicit = false

[[require]]
name = "formal_conjectures"
git = "https://github.com/google-deepmind/formal-conjectures"
rev = "<FC_SHA>"

[[lean_lib]]
name = "Challenge"

[[lean_lib]]
name = "Solution"

[[lean_lib]]
name = "Timing"
```

`Challenge.lean`:

```lean
import FormalConjectures.GreensOpenProblems.«72»

/-- Trivial challenge used to prove the checker pipeline works end to end.
It unfolds the repository's own definition, so it also tests importing a
module-system file from formal-conjectures. -/
theorem challenge_trivial :
    Green72.NoKInLineFor 3 3 ↔ Green72.AllowedSetSize 3 3 = (3 - 1) * 3 := by
  sorry
```

`Solution.lean`:

```lean
import FormalConjectures.GreensOpenProblems.«72»

theorem challenge_trivial :
    Green72.NoKInLineFor 3 3 ↔ Green72.AllowedSetSize 3 3 = (3 - 1) * 3 :=
  Iff.rfl
```

`.github/workflows/build.yml`:

```yaml
name: build
on:
  push:
    branches: [main]
  pull_request:
  workflow_dispatch:
permissions:
  contents: read
jobs:
  build:
    runs-on: ubuntu-24.04
    timeout-minutes: 120
    steps:
      - uses: actions/checkout@34e114876b0b11c390a56381ad16ebd13914f8d5 # v4.3.1
      - name: Install elan
        run: |
          curl -sSfL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh \
            | sh -s -- -y --default-toolchain none
          echo "$HOME/.elan/bin" >> "$GITHUB_PATH"
      - name: Fetch dependencies and Mathlib cache
        run: |
          lake update --keep-toolchain 2>/dev/null || lake update
          lake exe cache get
      - name: Build
        run: |
          start=$(date +%s)
          lake build Challenge Solution
          echo "build_seconds=$(( $(date +%s) - start ))" | tee -a "$GITHUB_STEP_SUMMARY"
      - name: Axioms of the solution
        run: |
          cat > /tmp/Axioms.lean <<'EOF'
          import Solution
          #print axioms challenge_trivial
          EOF
          lake env lean /tmp/Axioms.lean | tee axioms.txt
          grep -q "depends on axioms: \[\]" axioms.txt || grep -q "does not depend on any axioms" axioms.txt
```

- [ ] **Step 3: Commit and push, then run the workflow**

```bash
cd ~/Desktop/Projects/erdos-lean-formalization
git add -A && git commit -m "build: Lean project skeleton with trivial challenge

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>" && git push
gh run watch "$(gh run list --workflow build.yml --limit 1 --json databaseId --jq '.[0].databaseId')" --exit-status
```

Expected: the run succeeds, the summary shows `build_seconds`, and `axioms.txt` shows `challenge_trivial` with no axioms.

- [ ] **Step 4: If the import of the module-system file fails**

Symptom: an error mentioning `module` or `public import` when elaborating `Challenge.lean`.
Fix: make both files module files by replacing the first line of each with:

```lean
module
public import FormalConjectures.GreensOpenProblems.«72»
```

and wrapping the theorem in `@[expose] public section` ... `end`.
Re-run step 3.
Record which form worked in `docs/preflight.md` under "Module system".

- [ ] **Step 5: Commit the generated `lake-manifest.json`**

The first `lake update` in CI does not commit the manifest.
Run the same `lake update` in a scratch GitHub Actions job, or copy the manifest the CI job printed, and commit it so later builds never float.
Add a CI step `git diff --exit-code lake-manifest.json` after `lake update` in `build.yml` so a floating manifest fails the build.

```bash
git add lake-manifest.json .github/workflows/build.yml
git commit -m "build: pin lake manifest

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>" && git push
```

---

### Task 2: Checker green on the trivial challenge

**Files:**
- Create in `erdos-lean-checker`: `challenge/trivial.lean`, `comparator/trivial.json`, `scripts/check.sh`, `scripts/axioms/trivial.lean`
- Modify: `.github/workflows/verify.yml` (replace the skeleton)

**Interfaces:**
- Consumes: agent repository commit SHA; library names `Challenge` and `Solution`.
- Produces: a commit status `comparator/<target>` on the agent commit; workflow inputs `agent_commit` and `target`.

- [ ] **Step 1: Daniel creates the read token (one-time, manual)**

In GitHub: Settings, Developer settings, Fine-grained tokens, new token named `erdos-checker`, repository access only `erdos-lean-formalization`, permissions `Contents: Read-only` and `Commit statuses: Read and write`, expiry 2026-11-30.
Then, in a terminal, Daniel runs and pastes the token when prompted:

```bash
gh secret set AGENT_REPO_TOKEN -R danielpuri1901/erdos-lean-checker
```

Never paste the token into chat.

- [ ] **Step 2: Resolve the Comparator pin**

```bash
COMP_SHA=$(gh api repos/leanprover/comparator/git/ref/tags/v4.33.0 --jq .object.sha)
gh api "repos/leanprover/comparator/git/tags/$COMP_SHA" --jq .object.sha 2>/dev/null || echo "$COMP_SHA"
```

Expected: a 40-character commit SHA (the second command resolves an annotated tag; if it errors, the first SHA is already the commit).
Record it in the checker README under "Pins".

- [ ] **Step 3: Write the frozen challenge, config, and scripts**

`challenge/trivial.lean`: byte-identical copy of the agent repository's `Challenge.lean` from Task 1.

`comparator/trivial.json`:

```json
{
  "challenge_module": "Challenge",
  "solution_module": "Solution",
  "theorem_names": ["challenge_trivial"],
  "permitted_axioms": ["propext", "Quot.sound", "Classical.choice"],
  "enable_nanoda": false
}
```

`scripts/axioms/trivial.lean`:

```lean
import Solution

/-- info: 'challenge_trivial' does not depend on any axioms -/
#guard_msgs in
#print axioms challenge_trivial
```

`scripts/check.sh`:

```bash
#!/usr/bin/env bash
# Runs Comparator on the agent checkout at $AGENT_DIR using $CONFIG.
set -euo pipefail
CONFIG="${1:?config path}"
AGENT_DIR="${AGENT_DIR:?agent checkout dir}"
COMPARATOR_BIN="${COMPARATOR_BIN:?}"
COMPARATOR_LEAN4EXPORT="${COMPARATOR_LEAN4EXPORT:?}"
COMPARATOR_LANDRUN="${COMPARATOR_LANDRUN:?}"
for b in "$COMPARATOR_BIN" "$COMPARATOR_LEAN4EXPORT" "$COMPARATOR_LANDRUN"; do
  [[ -x "$b" ]] || { echo "not executable: $b" >&2; exit 2; }
done
SHIM_DIR="$(mktemp -d)"
ln -sfn "$(readlink -f "$COMPARATOR_LANDRUN")" "$SHIM_DIR/landrun"
ln -sfn "$(readlink -f "$COMPARATOR_LEAN4EXPORT")" "$SHIM_DIR/lean4export"
CONFIG_ABS="$(readlink -f "$CONFIG")"
cd "$AGENT_DIR"
PATH="$SHIM_DIR:$PATH" exec lake env "$(readlink -f "$COMPARATOR_BIN")" "$CONFIG_ABS"
```

- [ ] **Step 4: Write the workflow**

`.github/workflows/verify.yml` (replace `<COMP_SHA>` with step 2's value):

```yaml
name: verify
on:
  workflow_dispatch:
    inputs:
      agent_commit:
        description: Commit of erdos-lean-formalization to verify
        required: true
      target:
        description: Target id (file stem in challenge/ and comparator/)
        required: true
permissions:
  contents: read
jobs:
  verify:
    runs-on: ubuntu-24.04
    timeout-minutes: 180
    env:
      TARGET: ${{ inputs.target }}
      AGENT_COMMIT: ${{ inputs.agent_commit }}
    steps:
      - uses: actions/checkout@34e114876b0b11c390a56381ad16ebd13914f8d5 # v4.3.1
      - name: Check out the agent repository at the commit under test
        uses: actions/checkout@34e114876b0b11c390a56381ad16ebd13914f8d5 # v4.3.1
        with:
          repository: danielpuri1901/erdos-lean-formalization
          ref: ${{ inputs.agent_commit }}
          path: agent
          token: ${{ secrets.AGENT_REPO_TOKEN }}
      - name: Report pending status
        run: |
          gh api -X POST "repos/danielpuri1901/erdos-lean-formalization/statuses/$AGENT_COMMIT" \
            -f state=pending -f context="comparator/$TARGET" -f target_url="$GITHUB_SERVER_URL/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID"
        env:
          GH_TOKEN: ${{ secrets.AGENT_REPO_TOKEN }}
      - name: Freeze the challenge
        run: |
          cp "challenge/$TARGET.lean" agent/Challenge.lean
          cp "scripts/axioms/$TARGET.lean" agent/AxiomCheck.lean
          rm -rf agent/.claude agent/scripts/hooks
      - name: Install elan
        run: |
          curl -sSfL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh \
            | sh -s -- -y --default-toolchain none
          echo "$HOME/.elan/bin" >> "$GITHUB_PATH"
      - name: Fetch dependencies and Mathlib cache
        working-directory: agent
        run: |
          lake update --keep-toolchain 2>/dev/null || lake update
          git diff --exit-code lake-manifest.json
          lake exe cache get
      - name: Build challenge and solution
        working-directory: agent
        run: lake build Challenge Solution
      - name: Axiom audit
        working-directory: agent
        run: lake env lean AxiomCheck.lean
      - name: Clone Comparator (pinned)
        run: |
          git clone https://github.com/leanprover/comparator .tools/comparator
          git -C .tools/comparator checkout <COMP_SHA>
      - name: Restore Comparator build cache
        uses: actions/cache@0057852bfaa89a56745cba8c7296529d2fc39830 # v4.3.0
        with:
          path: .tools/comparator/.lake
          key: comparator-<COMP_SHA>-${{ runner.os }}
      - name: Build Comparator and lean4export
        working-directory: .tools/comparator
        run: lake build lean4export comparator
      - uses: actions/setup-go@40f1582b2485089dde7abd97c1529aa768e1baff # v5.6.0
        with:
          go-version: 'stable'
      - name: Build landrun (pinned)
        run: GOBIN="$RUNNER_TEMP/landrun-bin" go install github.com/zouuup/landrun/cmd/landrun@5ed4a3db3a4a
      - name: Landrun smoke test
        run: |
          "$RUNNER_TEMP/landrun-bin/landrun" --best-effort --ro / --rw /dev \
            -ldd -add-exec /usr/bin/echo hello
      - name: Run Comparator
        id: comparator
        run: |
          AGENT_DIR="$PWD/agent" \
          COMPARATOR_BIN="$PWD/.tools/comparator/.lake/build/bin/comparator" \
          COMPARATOR_LEAN4EXPORT="$PWD/.tools/comparator/.lake/packages/lean4export/.lake/build/bin/lean4export" \
          COMPARATOR_LANDRUN="$RUNNER_TEMP/landrun-bin/landrun" \
          bash scripts/check.sh "comparator/$TARGET.json" | tee comparator.log
          grep -q "Your solution is okay!" comparator.log
      - name: Report final status
        if: always()
        run: |
          STATE=failure; [ "${{ steps.comparator.outcome }}" = "success" ] && STATE=success
          gh api -X POST "repos/danielpuri1901/erdos-lean-formalization/statuses/$AGENT_COMMIT" \
            -f state=$STATE -f context="comparator/$TARGET" -f target_url="$GITHUB_SERVER_URL/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID"
        env:
          GH_TOKEN: ${{ secrets.AGENT_REPO_TOKEN }}
      - name: Upload Comparator log
        if: always()
        uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4.6.2
        with:
          name: comparator-log-${{ inputs.target }}
          path: comparator.log
```

- [ ] **Step 5: Commit, push, and run on the Task 1 commit**

```bash
cd ~/Desktop/Projects/erdos-lean-checker
git add -A && git commit -m "ci: verify workflow with frozen challenge, axiom audit, Comparator, commit status

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>" && git push
AGENT_SHA=$(git -C ~/Desktop/Projects/erdos-lean-formalization rev-parse HEAD)
gh workflow run verify.yml -R danielpuri1901/erdos-lean-checker -f agent_commit="$AGENT_SHA" -f target=trivial
sleep 20; gh run watch -R danielpuri1901/erdos-lean-checker "$(gh run list -R danielpuri1901/erdos-lean-checker --workflow verify.yml --limit 1 --json databaseId --jq '.[0].databaseId')" --exit-status
gh api "repos/danielpuri1901/erdos-lean-formalization/commits/$AGENT_SHA/status" --jq '.statuses[] | .context + " " + .state'
```

Expected: the run is green, `comparator.log` contains `Your solution is okay!`, and the commit status `comparator/trivial` is `success`.

- [ ] **Step 6: If lean4export or Comparator rejects the v4.33.1 oleans**

Symptom: lean4export errors about an unknown olean version, or Comparator fails to parse the export.
Fix, in order: (a) in `.tools/comparator`, set `lean-toolchain` to `leanprover/lean4:v4.33.1` before `lake build` (add a `sed -i` step after the clone); (b) if lean4export still fails, pin `lean4export` to its `v4.33.0` tag commit by editing `.tools/comparator/lake-manifest.json` before the build; (c) if both fail, open an issue summary in `docs/preflight.md` and ask Daniel before trying a Comparator fork.
Record the outcome in the checker README "Pins".

- [ ] **Step 7: Prove the freeze (Review Focus 3)**

In the agent repository, on a throwaway branch, change `Challenge.lean` to `theorem challenge_trivial : True := by sorry` and make `Solution.lean` prove `theorem challenge_trivial : True := trivial`.
Push the branch and run `verify.yml` against that commit with `target=trivial`.
Expected: the run fails, because the checker overwrites `Challenge.lean` with the frozen statement and the solution no longer matches.
Delete the branch.
Record the run URL in `docs/preflight.md` under "Freeze test".

---

### Task 3: Negative fixtures for the checker

**Files:**
- Create in `erdos-lean-checker`: `tests/bad/sorry.lean`, `tests/bad/axiom.lean`, `tests/bad/native_decide.lean`, `tests/bad/wrong_statement.lean`, `tests/bad/redefine.lean`
- Modify: `.github/workflows/verify.yml` (add job `negative`)

**Interfaces:**
- Consumes: the trivial challenge from Task 2.
- Produces: proof that each cheating class is rejected.

- [ ] **Step 1: Write the five bad solutions**

`tests/bad/sorry.lean`:

```lean
import FormalConjectures.GreensOpenProblems.«72»
theorem challenge_trivial :
    Green72.NoKInLineFor 3 3 ↔ Green72.AllowedSetSize 3 3 = (3 - 1) * 3 := by
  sorry
```

`tests/bad/axiom.lean`:

```lean
import FormalConjectures.GreensOpenProblems.«72»
axiom cheat : Green72.NoKInLineFor 3 3 ↔ Green72.AllowedSetSize 3 3 = (3 - 1) * 3
theorem challenge_trivial :
    Green72.NoKInLineFor 3 3 ↔ Green72.AllowedSetSize 3 3 = (3 - 1) * 3 := cheat
```

`tests/bad/native_decide.lean`:

```lean
import FormalConjectures.GreensOpenProblems.«72»
theorem helper : (2 : Nat) + 2 = 4 := by native_decide
theorem challenge_trivial :
    Green72.NoKInLineFor 3 3 ↔ Green72.AllowedSetSize 3 3 = (3 - 1) * 3 :=
  have _ := helper
  Iff.rfl
```

`tests/bad/wrong_statement.lean`:

```lean
import FormalConjectures.GreensOpenProblems.«72»
theorem challenge_trivial (h : False) :
    Green72.NoKInLineFor 3 3 ↔ Green72.AllowedSetSize 3 3 = (3 - 1) * 3 :=
  h.elim
```

`tests/bad/redefine.lean`:

```lean
import FormalConjectures.GreensOpenProblems.«72»
namespace Green72
def NoKInLineFor (_k _N : Nat) : Prop := True
end Green72
theorem challenge_trivial :
    Green72.NoKInLineFor 3 3 ↔ Green72.AllowedSetSize 3 3 = (3 - 1) * 3 := by
  sorry
```

- [ ] **Step 2: Add the `negative` job**

Append to `verify.yml` under `jobs:`:

```yaml
  negative:
    if: inputs.target == 'trivial'
    runs-on: ubuntu-24.04
    timeout-minutes: 180
    strategy:
      fail-fast: false
      matrix:
        bad: [sorry, axiom, native_decide, wrong_statement, redefine]
    steps:
      - uses: actions/checkout@34e114876b0b11c390a56381ad16ebd13914f8d5 # v4.3.1
      - uses: actions/checkout@34e114876b0b11c390a56381ad16ebd13914f8d5 # v4.3.1
        with:
          repository: danielpuri1901/erdos-lean-formalization
          ref: ${{ inputs.agent_commit }}
          path: agent
          token: ${{ secrets.AGENT_REPO_TOKEN }}
      - name: Freeze challenge and plant the bad solution
        run: |
          cp challenge/trivial.lean agent/Challenge.lean
          cp "tests/bad/${{ matrix.bad }}.lean" agent/Solution.lean
      - name: Install elan
        run: |
          curl -sSfL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh \
            | sh -s -- -y --default-toolchain none
          echo "$HOME/.elan/bin" >> "$GITHUB_PATH"
      - name: Fetch dependencies and Mathlib cache
        working-directory: agent
        run: |
          lake update --keep-toolchain 2>/dev/null || lake update
          lake exe cache get
      - name: Build (allowed to fail; Comparator must still reject)
        working-directory: agent
        run: lake build Challenge Solution || true
      - name: Clone and build Comparator (pinned)
        run: |
          git clone https://github.com/leanprover/comparator .tools/comparator
          git -C .tools/comparator checkout <COMP_SHA>
          (cd .tools/comparator && lake build lean4export comparator)
      - uses: actions/setup-go@40f1582b2485089dde7abd97c1529aa768e1baff # v5.6.0
        with:
          go-version: 'stable'
      - name: Build landrun (pinned)
        run: GOBIN="$RUNNER_TEMP/landrun-bin" go install github.com/zouuup/landrun/cmd/landrun@5ed4a3db3a4a
      - name: Comparator must reject
        run: |
          set +e
          AGENT_DIR="$PWD/agent" \
          COMPARATOR_BIN="$PWD/.tools/comparator/.lake/build/bin/comparator" \
          COMPARATOR_LEAN4EXPORT="$PWD/.tools/comparator/.lake/packages/lean4export/.lake/build/bin/lean4export" \
          COMPARATOR_LANDRUN="$RUNNER_TEMP/landrun-bin/landrun" \
          bash scripts/check.sh comparator/trivial.json | tee comparator.log
          if grep -q "Your solution is okay!" comparator.log; then
            echo "FAIL: bad solution ${{ matrix.bad }} was accepted"; exit 1
          fi
          echo "rejected as expected"
```

Apply the same Comparator version fix from Task 2 step 6 here if it was needed.

- [ ] **Step 3: Commit, push, run, and record**

```bash
cd ~/Desktop/Projects/erdos-lean-checker
git add -A && git commit -m "ci: negative fixtures, Comparator must reject each cheating class

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>" && git push
AGENT_SHA=$(git -C ~/Desktop/Projects/erdos-lean-formalization rev-parse HEAD)
gh workflow run verify.yml -R danielpuri1901/erdos-lean-checker -f agent_commit="$AGENT_SHA" -f target=trivial
```

Expected: `verify` green, all five `negative` matrix jobs green (each printing `rejected as expected`).
Record the run URL in the checker README under "Negative tests".

---

### Task 4: Probe cloud session

**Files:**
- Create in agent repo: `scripts/setup-cloud.sh` (v0, probe only), `docs/cloud-environment.md`, `docs/cloud-probe.md`

**Interfaces:**
- Produces: facts for Task 5: working directory, user, home, disk, whether a release asset of the attached repository downloads, whether `cache.mathlib.org` is reachable.

- [ ] **Step 1: Publish a tiny release asset to probe against**

```bash
cd ~/Desktop/Projects/erdos-lean-formalization
echo "probe $(date -u +%FT%TZ)" > /tmp/probe.txt
gh release create probe-v0 /tmp/probe.txt --title "probe-v0" --notes "Probe asset for cloud GitHub proxy test" --latest=false
```

- [ ] **Step 2: Write the probe setup script**

`scripts/setup-cloud.sh`:

```bash
#!/bin/bash
# v0: probe only. Records facts about the cloud VM; never fails the session.
LOG=/tmp/cloud-probe.log
{
  echo "date=$(date -u +%FT%TZ)"
  echo "pwd=$PWD"; echo "user=$(whoami)"; echo "home=$HOME"
  echo "nproc=$(nproc)"; echo "mem=$(free -g | awk '/Mem/{print $2}')G"
  echo "disk=$(df -h / | awk 'NR==2{print $4}') free"
  echo "lakefile_in_pwd=$([ -f lakefile.toml ] && echo yes || echo no)"
  echo "curl_version=$(curl --version | head -1)"
  for u in \
    https://github.com/danielpuri1901/erdos-lean-formalization/releases/download/probe-v0/probe.txt \
    https://github.com/leanprover/lean4/releases/download/v4.33.1/lean-4.33.1-linux.tar.zst \
    https://cache.mathlib.org/ \
    https://release.lean-lang.org/ ; do
    code=$(curl -sS -o /dev/null -w '%{http_code}' -L --max-time 20 --head "$u" 2>&1 | tail -c 3)
    echo "head $u -> $code"
  done
  echo "env_remote=$CLAUDE_CODE_REMOTE"
} > "$LOG" 2>&1 || true
exit 0
```

- [ ] **Step 3: Write the environment settings doc**

`docs/cloud-environment.md`:

```markdown
# Cloud environment settings

Create one environment at claude.ai/code, environment selector, Add cloud environment.

- Name: `erdos-lean`
- Network access: Custom. Check "Also include default list of common package managers". Add:
  - `cache.mathlib.org`
  - `release.lean-lang.org`
  - `*.lean-lang.org`
- Environment variables (one per line):
  - `BASH_DEFAULT_TIMEOUT_MS=600000`
  - `BASH_MAX_TIMEOUT_MS=1800000`
- Setup script: paste the current contents of `scripts/setup-cloud.sh`.

Changing the setup script or the allowlist rebuilds the environment cache.
Resuming a session never re-runs the setup script.
```

- [ ] **Step 4: Commit and push; Daniel creates the environment and starts a session**

```bash
git add -A && git commit -m "cloud: probe setup script and environment settings

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>" && git push
```

Daniel creates the environment per `docs/cloud-environment.md` and starts a cloud session on the agent repository with this prompt: `Print the file /tmp/cloud-probe.log and stop.`

- [ ] **Step 5: Record the facts**

Copy the printed log into `docs/cloud-probe.md` with the session link.
Decision rules:
- `probe.txt -> 200` (or 302) means attached-repository release assets work; Task 5 hosts the artifact there.
- `probe.txt -> 403` means they do not; Task 5 hosts the artifact on S3 instead (Daniel provisions a bucket with public-read objects or presigned URLs, `*.amazonaws.com` is already trusted).
- `cache.mathlib.org -> 200/403/404` (any non-timeout) means the allowlist works; a timeout means the host is not allowed and the allowlist entry must be fixed before Task 5.
Commit `docs/cloud-probe.md`.

---

### Task 5: Environment artifact and real setup script

**Files:**
- Create in agent repo: `.github/workflows/build-env.yml`
- Modify: `scripts/setup-cloud.sh` (v1)

**Interfaces:**
- Produces: release `env-v1` with assets `env.tar.zst.part-aa`, `env.tar.zst.part-ab`, ... and `env.sha256`; a setup script that restores the toolchain to `/opt/lean` and the project `.lake` into the repository checkout.

- [ ] **Step 1: Write the artifact workflow**

`.github/workflows/build-env.yml`:

```yaml
name: build-env
on:
  workflow_dispatch:
    inputs:
      tag:
        description: Release tag to publish (for example env-v1)
        required: true
permissions:
  contents: write
jobs:
  build-env:
    runs-on: ubuntu-24.04
    timeout-minutes: 180
    steps:
      - uses: actions/checkout@34e114876b0b11c390a56381ad16ebd13914f8d5 # v4.3.1
      - name: Install the toolchain into /opt/lean (no elan)
        run: |
          sudo mkdir -p /opt/lean
          curl -sSfL -o /tmp/lean.tar.zst https://github.com/leanprover/lean4/releases/download/v4.33.1/lean-4.33.1-linux.tar.zst
          sudo tar --use-compress-program=unzstd -xf /tmp/lean.tar.zst -C /opt/lean --strip-components=1
          echo "/opt/lean/bin" >> "$GITHUB_PATH"
          /opt/lean/bin/lean --version
      - name: Fetch dependencies, cache, and build
        run: |
          lake update --keep-toolchain 2>/dev/null || lake update
          git diff --exit-code lake-manifest.json
          lake exe cache get
          lake build Challenge Solution Timing
      - name: Package
        run: |
          tar --use-compress-program="zstd -T0 -3" -cf env.tar.zst -C / opt/lean -C "$GITHUB_WORKSPACE" .lake
          split -b 1900m env.tar.zst env.tar.zst.part-
          sha256sum env.tar.zst > env.sha256
          ls -la env.tar.zst.part-* env.sha256 | tee -a "$GITHUB_STEP_SUMMARY"
      - name: Publish release
        env:
          GH_TOKEN: ${{ github.token }}
        run: |
          gh release create "${{ inputs.tag }}" env.tar.zst.part-* env.sha256 --title "${{ inputs.tag }}" --notes "Lean 4.33.1 toolchain plus built .lake for formal-conjectures pin" --latest=false
```

- [ ] **Step 2: Run it**

```bash
cd ~/Desktop/Projects/erdos-lean-formalization
git add -A && git commit -m "cloud: environment artifact workflow

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>" && git push
gh workflow run build-env.yml -f tag=env-v1
sleep 20; gh run watch "$(gh run list --workflow build-env.yml --limit 1 --json databaseId --jq '.[0].databaseId')" --exit-status
gh release view env-v1 --json assets --jq '.assets[] | .name + " " + (.size|tostring)'
```

Expected: a release with the split parts and `env.sha256`.
Record total size in `docs/cloud-probe.md`.
If a single part exceeds 2 GB the release upload fails; lower `split -b` to `1500m`.

- [ ] **Step 3: Write setup script v1**

`scripts/setup-cloud.sh` (if Task 4 showed 403 on release assets, replace `BASE` with the S3 base URL Daniel provides):

```bash
#!/bin/bash
# v1: restore the prebuilt Lean environment. Must finish in under 5 minutes.
set -u
LOG=/tmp/cloud-setup.log
BASE="https://github.com/danielpuri1901/erdos-lean-formalization/releases/download/env-v1"
start=$(date +%s)
{
  echo "pwd=$PWD user=$(whoami)"
  mkdir -p /tmp/env && cd /tmp/env
  curl -sSfL -O "$BASE/env.sha256"
  parts=$(curl -sSfL "https://api.github.com/repos/danielpuri1901/erdos-lean-formalization/releases/tags/env-v1" | grep -o 'env.tar.zst.part-[a-z]*' | sort -u)
  for p in $parts; do curl -sSfL -O "$BASE/$p" & done; wait
  cat env.tar.zst.part-* > env.tar.zst
  sha256sum -c env.sha256
  tar --use-compress-program=unzstd -xf env.tar.zst -C / opt/lean
  REPO=$(ls -d /home/*/erdos-lean-formalization /root/erdos-lean-formalization "$OLDPWD" 2>/dev/null | head -1)
  tar --use-compress-program=unzstd -xf env.tar.zst -C "$REPO" .lake
  echo 'export PATH=/opt/lean/bin:$PATH' > /etc/profile.d/lean.sh
  chmod -R a+rwX "$REPO/.lake" /opt/lean
  rm -rf /tmp/env
  echo "setup_seconds=$(( $(date +%s) - start ))"
} > "$LOG" 2>&1 || echo "setup failed, see $LOG" >> "$LOG"
exit 0
```

Also add a SessionStart hook so the PATH is set inside sessions and the build is checked (`.claude/settings.json` is written fully in Task 6; the hook entry is):

```json
{"matcher": "startup|resume", "hooks": [{"type": "command", "command": "bash \"$CLAUDE_PROJECT_DIR\"/scripts/session-start.sh"}]}
```

`scripts/session-start.sh`:

```bash
#!/bin/bash
[ "${CLAUDE_CODE_REMOTE:-}" = "true" ] || exit 0
export PATH=/opt/lean/bin:$PATH
cd "$CLAUDE_PROJECT_DIR" || exit 0
echo "lean: $(lean --version 2>&1)"
start=$(date +%s); lake build Challenge >/tmp/lake-check.log 2>&1; echo "lake build Challenge: exit $? in $(( $(date +%s) - start ))s"
tail -3 /tmp/cloud-setup.log 2>/dev/null
```

- [ ] **Step 4: Commit, push, update the environment, and start a session**

```bash
git add -A && git commit -m "cloud: setup script v1 restores the prebuilt environment

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>" && git push
```

Daniel pastes the new `scripts/setup-cloud.sh` into the environment's Setup script field (this rebuilds the cache) and starts a session with the prompt: `Print /tmp/cloud-setup.log, then run: export PATH=/opt/lean/bin:$PATH; time lake build Challenge Solution; and stop.`

- [ ] **Step 5: If the repository path guess is wrong**

Symptom: `tar` fails on `-C "$REPO"`.
Fix: use the `pwd` line from `docs/cloud-probe.md` as a literal path in the script.

- [ ] **Step 6: Record the measurement (Review Focus 4)**

Record `setup_seconds`, the `lake build` time, and the session link in `docs/cloud-probe.md`.
Pass criterion: `setup_seconds` under 300 and `lake build Challenge Solution` under 60 seconds on a fresh session.
If `setup_seconds` is over 300: start a second session and check whether `/tmp/cloud-setup.log` exists without a new `setup_seconds` (cached) or is regenerated (not cached); if not cached, move the download to S3 or shrink the artifact (drop `Timing`, keep only the oleans for the target's import closure) and repeat.

---

### Task 6: Repository settings and the guard hook

**Files:**
- Create: `.claude/settings.json`, `scripts/hooks/guard.sh`, `tests/test_guard.sh`

**Interfaces:**
- Produces: a PreToolUse guard that denies edits to `Challenge.lean` and `challenge/`, denies forbidden tokens in `Solution.lean` and `solutions/`, and logs denials to `LEDGER.md`.

- [ ] **Step 1: Write the failing test**

`tests/test_guard.sh`:

```bash
#!/usr/bin/env bash
set -u
cd "$(dirname "$0")/.."
G=scripts/hooks/guard.sh
fail=0
check() { # name, expected exit, json
  out=$(printf '%s' "$3" | bash "$G" 2>&1); code=$?
  if [ "$code" -ne "$2" ]; then echo "FAIL $1: exit $code, expected $2: $out"; fail=1; else echo "ok   $1"; fi
}
check deny_challenge 2 '{"tool_name":"Edit","tool_input":{"file_path":"/w/erdos-lean-formalization/Challenge.lean","old_string":"a","new_string":"b"}}'
check deny_sorry 2 '{"tool_name":"Write","tool_input":{"file_path":"/w/erdos-lean-formalization/Solution.lean","content":"theorem x : True := by sorry"}}'
check deny_native 2 '{"tool_name":"Edit","tool_input":{"file_path":"/w/erdos-lean-formalization/solutions/a.lean","old_string":"","new_string":"by native_decide"}}'
check deny_axiom 2 '{"tool_name":"Write","tool_input":{"file_path":"/w/erdos-lean-formalization/Solution.lean","content":"axiom bad : False"}}'
check allow_solution 0 '{"tool_name":"Write","tool_input":{"file_path":"/w/erdos-lean-formalization/Solution.lean","content":"theorem x : True := trivial"}}'
check allow_other 0 '{"tool_name":"Write","tool_input":{"file_path":"/w/erdos-lean-formalization/LEDGER.md","content":"sorry is a word here"}}'
exit $fail
```

- [ ] **Step 2: Run it to see it fail**

Run: `bash tests/test_guard.sh`
Expected: every line `FAIL` because `scripts/hooks/guard.sh` does not exist.

- [ ] **Step 3: Write the guard**

`scripts/hooks/guard.sh`:

```bash
#!/usr/bin/env bash
# PreToolUse guard. Reads the hook JSON on stdin. Exit 2 denies; the stderr line is shown to Claude.
set -u
input=$(cat)
read -r path text < <(printf '%s' "$input" | python3 -c '
import json,sys
d=json.load(sys.stdin); t=d.get("tool_input",{})
p=t.get("file_path","").replace("\\","/")
txt=t.get("content","")+"\n"+t.get("new_string","")
print(p, json.dumps(txt))
')
text=$(printf '%s' "$text" | python3 -c 'import json,sys; print(json.loads(sys.stdin.read()))')
log() { printf '| %s | guard | %s | %s |\n' "$(date -u +%FT%TZ)" "$1" "$path" >> "${CLAUDE_PROJECT_DIR:-.}/LEDGER.md" 2>/dev/null; }
case "$path" in
  */Challenge.lean|*/challenge/*)
    log "deny edit to frozen statement"; echo "Denied: $path is the frozen statement. Edit Solution.lean only." >&2; exit 2;;
  */Solution.lean|*/solutions/*)
    if printf '%s' "$text" | grep -q -E '\b(sorry|admit|native_decide|implemented_by|skipKernelTC|unsafe)\b|^\s*axiom\b|\baxiom\s+[A-Za-z_]'; then
      log "deny forbidden token"; echo "Denied: forbidden token (sorry, admit, axiom, native_decide, implemented_by, skipKernelTC, unsafe) in $path." >&2; exit 2
    fi;;
esac
exit 0
```

- [ ] **Step 4: Run the test to see it pass**

Run: `chmod +x scripts/hooks/guard.sh && bash tests/test_guard.sh`
Expected: six `ok` lines, exit 0.

- [ ] **Step 5: Write `.claude/settings.json`**

```json
{
  "promptCacheTtl": "1h",
  "subagentPromptCacheTtl": "1h",
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write|MultiEdit",
        "hooks": [
          { "type": "command", "command": "bash \"$CLAUDE_PROJECT_DIR\"/scripts/hooks/guard.sh" }
        ]
      }
    ],
    "SessionStart": [
      {
        "matcher": "startup|resume",
        "hooks": [
          { "type": "command", "command": "bash \"$CLAUDE_PROJECT_DIR\"/scripts/session-start.sh" }
        ]
      }
    ]
  }
}
```

- [ ] **Step 6: Commit**

```bash
git add -A && git commit -m "harness: PreToolUse guard, cache TTL, session start hook

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>" && git push
```

---

### Task 7: Ledger, state, and task queue

**Files:**
- Create: `TASKS.md`, `LEDGER.md`, `scripts/ledger.sh`, `scripts/state.py`, `tests/test_ledger.sh`

**Interfaces:**
- Produces: `scripts/ledger.sh add` with named flags; `STATE.json` with per-task `attempts`, `last_verdict`, `done`, and totals `minutes`, `cost_usd`; a task counts as done only on `verdict=pass` with a checker URL (Review Focus 5).

- [ ] **Step 1: Write the files**

`TASKS.md`:

```markdown
# Task queue

One line per task. Status is one of: todo, running, blocked, done.

| id | target | scope | status |
|----|--------|-------|--------|
| T0 | trivial | checker pipeline proof | done |
```

`LEDGER.md`:

```markdown
# Ledger (append only)

| time | task | attempt | commit | verdict | minutes | cost_usd | checker | note |
|------|------|---------|--------|---------|---------|----------|---------|------|
```

`scripts/ledger.sh`:

```bash
#!/usr/bin/env bash
# Usage: scripts/ledger.sh add --task T1 --attempt 1 --commit abc1234 --verdict fail|pass|stopped --minutes 25 --cost 3.10 [--checker URL] --note "text"
set -euo pipefail
cd "$(dirname "$0")/.."
[ "${1:-}" = "add" ] || { echo "usage: ledger.sh add --task ... " >&2; exit 2; }
shift
task= attempt= commit= verdict= minutes= cost= checker= note=
while [ $# -gt 0 ]; do
  case "$1" in
    --task) task=$2;; --attempt) attempt=$2;; --commit) commit=$2;; --verdict) verdict=$2;;
    --minutes) minutes=$2;; --cost) cost=$2;; --checker) checker=$2;; --note) note=$2;;
    *) echo "unknown flag $1" >&2; exit 2;;
  esac; shift 2
done
for v in task attempt commit verdict minutes cost; do [ -n "${!v}" ] || { echo "missing --$v" >&2; exit 2; }; done
case "$verdict" in pass|fail|stopped) ;; *) echo "verdict must be pass, fail, or stopped" >&2; exit 2;; esac
if [ "$verdict" = pass ] && [ -z "$checker" ]; then echo "a pass needs --checker URL" >&2; exit 2; fi
printf '| %s | %s | %s | %s | %s | %s | %s | %s | %s |\n' "$(date -u +%FT%TZ)" "$task" "$attempt" "$commit" "$verdict" "$minutes" "$cost" "${checker:--}" "${note//|/\/}" >> LEDGER.md
python3 scripts/state.py
```

`scripts/state.py`:

```python
#!/usr/bin/env python3
"""Rebuild STATE.json from LEDGER.md. Only this script writes STATE.json."""
import json, re, pathlib
root = pathlib.Path(__file__).resolve().parent.parent
rows = []
for line in (root / "LEDGER.md").read_text().splitlines():
    if not line.startswith("|") or line.startswith("| time") or line.startswith("|---"):
        continue
    cells = [c.strip() for c in line.strip().strip("|").split("|")]
    if len(cells) < 9 or cells[1] == "guard":
        continue
    rows.append(dict(zip(["time", "task", "attempt", "commit", "verdict", "minutes", "cost_usd", "checker", "note"], cells)))
tasks = {}
for r in rows:
    t = tasks.setdefault(r["task"], {"attempts": 0, "last_verdict": None, "done": False, "minutes": 0.0, "cost_usd": 0.0})
    t["attempts"] += 1
    t["last_verdict"] = r["verdict"]
    t["minutes"] += float(r["minutes"])
    t["cost_usd"] += float(r["cost_usd"])
    if r["verdict"] == "pass" and r["checker"].startswith("http"):
        t["done"] = True
state = {
    "tasks": tasks,
    "totals": {"minutes": sum(t["minutes"] for t in tasks.values()), "cost_usd": round(sum(t["cost_usd"] for t in tasks.values()), 2)},
    "denials": sum(1 for l in (root / "LEDGER.md").read_text().splitlines() if "| guard |" in l),
}
(root / "STATE.json").write_text(json.dumps(state, indent=2, sort_keys=True) + "\n")
print(json.dumps(state["totals"]))
```

`tests/test_ledger.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
tmp=$(mktemp -d); cp LEDGER.md "$tmp/LEDGER.bak"
trap 'cp "$tmp/LEDGER.bak" LEDGER.md; python3 scripts/state.py >/dev/null' EXIT
bash scripts/ledger.sh add --task TX --attempt 1 --commit aaa --verdict fail --minutes 10 --cost 1.5 --note "first"
bash scripts/ledger.sh add --task TX --attempt 2 --commit bbb --verdict pass --minutes 5 --cost 0.5 --note "no checker" && { echo "FAIL: pass without checker accepted"; exit 1; } || true
bash scripts/ledger.sh add --task TX --attempt 2 --commit bbb --verdict pass --minutes 5 --cost 0.5 --checker https://example/run/1 --note "green"
python3 - <<'EOF'
import json; s=json.load(open("STATE.json")); t=s["tasks"]["TX"]
assert t["attempts"]==2 and t["done"] is True and t["last_verdict"]=="pass", t
assert abs(s["totals"]["cost_usd"]-2.0)<1e-9, s["totals"]
print("ok ledger")
EOF
```

- [ ] **Step 2: Run the test**

Run: `chmod +x scripts/ledger.sh && bash tests/test_ledger.sh`
Expected: `ok ledger`, and `LEDGER.md` restored afterwards (the trap).

- [ ] **Step 3: Commit**

```bash
git add -A && git commit -m "harness: append-only ledger, STATE.json, task queue

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>" && git push
```

---

### Task 8: Run instructions, prompts, and the kill rule

**Files:**
- Create: `AGENTS.md`, `prompts/orchestrator.md`, `prompts/worker.md`, `docs/budget.md`

**Interfaces:**
- Consumes: `scripts/ledger.sh`, `STATE.json`, `TASKS.md`, the checker workflow name `verify.yml`.
- Produces: the worker report contract and the orchestrator loop rules the main run uses.

- [ ] **Step 1: Write `AGENTS.md`**

```markdown
# Agent instructions for erdos-lean-formalization

Read `docs/superpowers/specs/2026-10-02-lean-formalization-harness-design.md` once.

## Roles

The orchestrator session plans, dispatches one worker per attempt, records results, and pushes.
It never edits `Solution.lean` itself.
A worker is a fresh subagent that works on exactly one task from `TASKS.md`, time-boxed, and returns the report in `prompts/worker.md`.

## Rules that never bend

- `Challenge.lean` is frozen. Never edit it. The checker overwrites it anyway.
- Never write `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by`, `skipKernelTC`, or `unsafe` into `Solution.lean` or `solutions/`.
- Success is only a green `comparator/<target>` commit status from the checker repository on a pushed commit. Nothing printed in this session counts.
- After every attempt: commit, push, `scripts/ledger.sh add ...`, commit the ledger, push.
- Plateau rule: two attempts on one task with no reduction in the `sorry` count force a strategy change written in the ledger note; a third failure sets the task to `blocked`.
- Never mark a task impossible without three ledgered attempts.
- Kill rule: stop the run when `STATE.json` `totals.cost_usd` passes the cap in `docs/budget.md`, or when the wall clock passes the session cap, or when Daniel writes `STOP` in `STATE.json`.
- Workers return the first 20 error lines at most, never raw build logs.

## Commands

- Build: `export PATH=/opt/lean/bin:$PATH && lake build Challenge Solution`
- Count remaining sorries: `grep -c "sorry" Solution.lean || true`
- Axioms: `lake env lean AxiomCheck.lean` after copying the target's axiom file from the checker repository README.
- Ask the checker: Daniel (or a scheduled dispatch Daniel set up) runs `verify.yml` on the pushed commit; the orchestrator waits for the commit status `comparator/<target>` with `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status`.
```

- [ ] **Step 2: Write `prompts/worker.md`**

```markdown
# Worker task

You are a fresh worker. Model: Claude Opus 5.5, effort xhigh. Time box: {{minutes}} minutes.

Task {{task_id}}: {{task_scope}}
Target theorem(s): {{theorem_names}} in `Solution.lean`.
Statement file: `Challenge.lean` (read only).
Known approaches that failed (from the ledger): {{failed_approaches}}

Work only in `Solution.lean` (and `data/` if the task says so).
Build with `export PATH=/opt/lean/bin:$PATH && lake build Solution`.
Commit after every green build with a message starting `wip({{task_id}}):`.
Stop at the time box even if unfinished.

Return exactly this report, nothing else:

status: green | partial | stuck
commit: <sha or none>
sorries_before: <n>
sorries_after: <n>
files_changed: <list>
tried: <3 lines max>
blocking: <2 lines max: the exact goal or error, first 20 error lines appended below>
errors:
<first 20 lines of the last failing build, or "none">
```

- [ ] **Step 3: Write `prompts/orchestrator.md`**

```markdown
# Orchestrator loop

Model: Claude Fable 5.1. Keep your own context small: read reports, not logs.

Loop until the kill rule fires or `TASKS.md` has no `todo` tasks:

1. Read `STATE.json` and `TASKS.md`. Pick the first `todo` task; set it to `running`; commit.
2. Fill `prompts/worker.md` with the task, the time box (default 25 minutes), and the failed approaches from the ledger for that task.
3. Dispatch one worker subagent (model `opus`, effort `xhigh`) with that prompt. Wait.
4. Read the report. If `status: green`: push, note the commit in `TASKS.md`, and request a checker run (see AGENTS.md). Record the verdict with `scripts/ledger.sh add` once the commit status arrives. Set the task `done` only on `success`.
5. If `partial` or `stuck`: record the attempt (`verdict fail`, minutes, estimated cost from `docs/budget.md`), apply the plateau rule, and either re-dispatch with a changed strategy or set the task `blocked`.
6. Escalate to Claude Fable 5.1 at effort `max` (one bounded call, 20 minutes, at most three per run) only after the plateau rule fired, and only to produce a new lemma decomposition or a strategy note, never to write the proof.
7. Commit and push the ledger after every attempt.
```

- [ ] **Step 4: Write `docs/budget.md` (fill the numbers after Task 9)**

```markdown
# Budget and kill rule

Prices: Opus 5.5 $4 in / $20 out / $0.20 cache read per million tokens; Fable 5.1 $10 / $50 / $0.25.
Measured burn (Task 9): Opus 5.5 ____ USD/hour; Fable 5.1 ____ USD/hour.

Caps:
- Session cost cap: ____ USD (orchestrator stops dispatching when STATE.json totals.cost_usd exceeds it).
- Session wall-clock cap: ____ hours.
- Fable escalations: at most 3 per run, 20 minutes each.
- Worker time box: 25 minutes.
- Reserve: 20 USD of the credit is never scheduled.

Kill rule: any cap reached, or Daniel sets {"STOP": true} in STATE.json, ends the run; the orchestrator commits, pushes, and stops.
```

- [ ] **Step 5: Commit**

```bash
git add -A && git commit -m "harness: agent instructions, worker contract, orchestrator loop, budget template

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>" && git push
```

---

### Task 9: Burn test

**Files:**
- Create: `docs/burn-test.md`
- Modify: `docs/budget.md` (fill numbers)

**Interfaces:**
- Produces: dollars per hour for Opus 5.5 and Fable 5.1 in this environment; whether the cache TTL setting holds.

- [ ] **Step 1: Write the protocol**

`docs/burn-test.md`:

```markdown
# Burn test protocol

Fixed task prompt (same for both models):
"Read Challenge.lean. In Solution.lean, prove `challenge_trivial` by unfolding definitions without `Iff.rfl` (use `unfold` and `rfl` or `constructor`). Build with `export PATH=/opt/lean/bin:$PATH && lake build Solution`. Then write a 10-line explanation of `Green72.AllowedSetSize` in `docs/notes/allowedsetsize.md`. Stop after 15 minutes of work even if unfinished."

Procedure, per model:
1. Note the credit meter at claude.ai/code ("$X of $250 left") and the time.
2. Start a cloud session on this repository with the model set to the one under test, paste the prompt.
3. After the session stops (or at 15 minutes, stop it), note the credit meter and the time.
4. Record: model, minutes, dollars used, dollars per hour, whether `/usage` or the transcript showed cache re-writes (look for `cache_creation` growth across turns if visible).

Result table:

| model | minutes | USD used | USD/hour | notes |
|-------|---------|----------|----------|-------|
| claude-opus-5-5 | | | | |
| claude-fable-5-1 | | | | |
```

- [ ] **Step 2: Run both tests (Daniel starts the sessions; Claude records)**

Fill the table in `docs/burn-test.md`.
Then fill `docs/budget.md`: session cost cap = min(60 USD, 0.25 × remaining credit); session wall-clock cap = cost cap divided by the Opus USD/hour, rounded down to whole hours.

- [ ] **Step 3: Commit**

```bash
git add -A && git commit -m "docs: burn test results and budget caps

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>" && git push
```

---

### Task 10: Green 72 witness pipeline and kernel timing

**Files:**
- Create: `scripts/witness.py`, `data/green72/README.md`, `Timing/NoThree.lean`, `Timing.lean`, `tests/test_witness.py`

**Interfaces:**
- Produces: `data/green72/N.json` for N in 3..60 (fields `n`, `points`, `source`), the Lean checker `Timing.noThree`, and a measured kernel time for N = 60.

- [ ] **Step 1: Write the failing test**

`tests/test_witness.py`:

```python
import json, subprocess, sys, pathlib
sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent.parent / "scripts"))
import witness

def test_decode_flammenkamp():
    # n=10, encoding from the lookup form on 2026-10-02; 20 points, 2 per row
    pts = witness.decode("o09353478172812564609", 10)
    assert len(pts) == 20 and len(set(pts)) == 20
    assert all(0 <= x < 10 and 0 <= y < 10 for x, y in pts)
    assert witness.no_three_collinear(pts)

def test_rejects_collinear():
    assert not witness.no_three_collinear([(0, 0), (1, 1), (2, 2), (0, 1)])

def test_lean_literal():
    s = witness.lean_list([(0, 1), (2, 3)])
    assert s == "[(0, 1), (2, 3)]"
```

- [ ] **Step 2: Run it to see it fail**

Run: `python3 -m pytest tests/test_witness.py -q` (or `python3 -c "import tests.test_witness"` if pytest is absent; install nothing)
Expected: ImportError, `witness` not found.

- [ ] **Step 3: Write `scripts/witness.py`**

```python
#!/usr/bin/env python3
"""Fetch, decode, verify, and emit no-three-in-line witnesses for N in 3..60.

Sources:
- Flammenkamp's database lookup (one configuration per N), encoding described at
  https://wwwhomes.uni-bielefeld.de/achim/no3in/readme.html
- Prellberg's Table 1 (MIT) for N in {47, 49, 51, 53..60}:
  https://github.com/ThomasPrellberg/no-three-in-line---CP-SAT
Every witness is re-verified here with exact integer arithmetic before it is written.
"""
import ast, itertools, json, pathlib, re, sys, urllib.request, urllib.parse

ALPHABET = " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz#$%&@?!()[]<>{}=*+|-/~^_:;,."
LOOKUP = "https://wwwhomes.uni-bielefeld.de/cgi-bin/cgiwrap/achim/script_lookup?para=FIXED"
PRELLBERG = "https://raw.githubusercontent.com/ThomasPrellberg/no-three-in-line---CP-SAT/main/Table%201.txt"

def decode(code: str, n: int):
    """First char is the symmetry class; then 2n chars, column per chosen cell, rows top to bottom."""
    cols = code[1:1 + 2 * n]
    if len(cols) != 2 * n:
        raise ValueError(f"expected {2*n} position chars, got {len(cols)}")
    pts = []
    for i, ch in enumerate(cols):
        pts.append((ALPHABET.index(ch) - 1, i // 2))  # (x=column, y=row); ALPHABET[0] is the space placeholder
    return pts

def no_three_collinear(pts):
    for (x1, y1), (x2, y2), (x3, y3) in itertools.combinations(pts, 3):
        if x1 * y2 + x2 * y3 + x3 * y1 == x1 * y3 + x2 * y1 + x3 * y2:
            return False
    return True

def valid(pts, n):
    return len(pts) == 2 * n and len(set(pts)) == 2 * n and all(0 <= x < n and 0 <= y < n for x, y in pts) and no_three_collinear(pts)

def fetch_flammenkamp(n: int):
    data = urllib.parse.urlencode({"symm": "", "size": str(n), "index": "1", "send": "Do it"}).encode()
    req = urllib.request.Request(LOOKUP, data=data, headers={"User-Agent": "Mozilla/5.0"})
    html = urllib.request.urlopen(req, timeout=30).read().decode("latin-1")
    m = re.search(r"Encoding:\s*</?\w*>?\s*([^\s<]+)", html)
    if not m:
        raise RuntimeError(f"no encoding for n={n}")
    return decode(m.group(1), n), f"Flammenkamp database lookup size={n} index=1, encoding {m.group(1)}"

def fetch_prellberg():
    txt = urllib.request.urlopen(PRELLBERG, timeout=30).read().decode()
    out = {}
    for m in re.finditer(r"N=(\d+):\s*\n(\[.*?\])", txt, re.S):
        out[int(m.group(1))] = ast.literal_eval(m.group(2))
    return out

def lean_list(pts):
    return "[" + ", ".join(f"({x}, {y})" for x, y in pts) + "]"

def main(out_dir="data/green72", lo=3, hi=60):
    out = pathlib.Path(out_dir); out.mkdir(parents=True, exist_ok=True)
    prell = fetch_prellberg()
    for n in range(lo, hi + 1):
        if n in prell:
            pts, src = [tuple(p) for p in prell[n]], "Prellberg Table 1.txt (MIT), GitHub ThomasPrellberg/no-three-in-line---CP-SAT"
        else:
            pts, src = fetch_flammenkamp(n)
        if not valid(pts, n):
            raise SystemExit(f"witness for n={n} failed verification")
        (out / f"{n}.json").write_text(json.dumps({"n": n, "points": pts, "source": src}, indent=0) + "\n")
        print(n, "ok", src.split(",")[0])

if __name__ == "__main__":
    main(*(sys.argv[1:]))
```

Note on orientation: Flammenkamp's encoding lists columns per row; `(x, y)` here is `(column, row)`. Collinearity is symmetric under swapping axes, so either orientation is a valid witness.

- [ ] **Step 4: Run the tests, then generate the data**

Run: `python3 -m pytest tests/test_witness.py -q`
Expected: 3 passed.
Run: `python3 scripts/witness.py`
Expected: 58 lines `N ok <source>`; files `data/green72/3.json` through `60.json`.
If `decode` fails on the alphabet index for some N, print the encoding and fix the alphabet from the readme page (it is quoted in the docstring source).

- [ ] **Step 5: Write the Lean checker and the N = 60 timing file**

`Timing/NoThree.lean`:

```lean
/-- Nat-only collinearity test: three points are collinear iff the cross terms agree. -/
def collinear3 (p q r : Nat × Nat) : Bool :=
  p.1 * q.2 + q.1 * r.2 + r.1 * p.2 == p.1 * r.2 + q.1 * p.2 + r.1 * q.2

/-- True iff no three points of the list are collinear. -/
def noThree : List (Nat × Nat) → Bool
  | [] => true
  | p :: rest => pairsOk p rest && noThree rest
where
  pairsOk (p : Nat × Nat) : List (Nat × Nat) → Bool
    | [] => true
    | q :: rest => allOk p q rest && pairsOk p rest
  allOk (p q : Nat × Nat) : List (Nat × Nat) → Bool
    | [] => true
    | r :: rest => !collinear3 p q r && allOk p q rest

def inGrid (n : Nat) (l : List (Nat × Nat)) : Bool := l.all fun p => p.1 < n && p.2 < n
```

`Timing.lean` (root of the `Timing` library), generated by the next command so the literal is exact:

```bash
python3 - <<'EOF'
import json, sys
sys.path.insert(0, "scripts"); import witness
pts = json.load(open("data/green72/60.json"))["points"]
open("Timing.lean", "w").write(f"""import Timing.NoThree

def w60 : List (Nat × Nat) := {witness.lean_list(pts)}

set_option maxRecDepth 100000 in
example : noThree w60 = true ∧ inGrid 60 w60 = true ∧ w60.length = 120 := by decide
""")
EOF
```

- [ ] **Step 6: Measure the kernel time in CI**

Add a step to `.github/workflows/build.yml` after the build:

```yaml
      - name: Time the Green 72 N=60 kernel check
        run: |
          start=$(date +%s); lake build Timing; echo "timing_seconds=$(( $(date +%s) - start ))" | tee -a "$GITHUB_STEP_SUMMARY"
```

Commit, push, and read `timing_seconds` from the run summary.
Decision rule: under 600 seconds means `decide` is viable for every N; between 600 and 1800 means split the check per N into separate files; over 1800 means switch the certificate to a per-row structure (two points per row, check only cross-row triples through a precomputed slope table) and re-measure.
Record the number and the decision in `docs/preflight.md` under "Green 72 kernel time".

- [ ] **Step 7: Commit**

```bash
git add -A && git commit -m "green72: witness pipeline with exact verification, Nat-only kernel check, N=60 timing

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>" && git push
```

---

### Task 11: Erdős 105 warm-up through the checker

**Files:**
- Create in checker repo: `challenge/erdos105.lean`, `comparator/erdos105.json`, `scripts/axioms/erdos105.lean`
- Create in agent repo: `data/erdos105.json`, `scripts/verify_erdos105.py`, `docs/preflight.md` entry; replace `Challenge.lean` and `Solution.lean` for the target; `TASKS.md` rows
- Modify: `TASKS.md`, `LEDGER.md` (via script), `docs/preflight.md`

**Interfaces:**
- Consumes: everything above.
- Produces: a green `comparator/erdos105` status on an agent commit, and the first measured attempt rows in the ledger.

- [ ] **Step 1: Daniel audits the statement (human checkpoint)**

Daniel reads `FormalConjectures/ErdosProblems/105.lean` at the pin next to the English statement on erdosproblems.com/105 and writes three lines in `docs/preflight.md` under "Erdős 105 statement audit": what `ℝ²` is, what `line[ℝ, p, q]` is, and why the negated universal is the right thing to prove.
No agent run starts before this entry exists.

- [ ] **Step 2: Write the witness data and its verifier**

`data/erdos105.json`:

```json
{
  "source": "erdosproblems.com forum thread 105, post 8033 by Xichuan; affine form after (X:Y:Z) -> (X:Y:2X-Y+3Z), scaled by 840",
  "A": [[168,0],[280,560],[280,140],[420,630],[360,240],[504,672],[280,-280],[420,0],[840,840],[0,-840]],
  "B": [[0,420],[840,3360],[336,336],[280,0],[420,315],[-840,-2520]]
}
```

`scripts/verify_erdos105.py`:

```python
#!/usr/bin/env python3
"""Exact check: A not collinear, |A| = |B| + 4, disjoint, every line through two points of A meets B."""
import json, itertools, pathlib
d = json.loads((pathlib.Path(__file__).resolve().parent.parent / "data/erdos105.json").read_text())
A = [tuple(p) for p in d["A"]]; B = [tuple(p) for p in d["B"]]
def col(p, q, r): return (q[0]-p[0])*(r[1]-p[1]) - (q[1]-p[1])*(r[0]-p[0]) == 0
assert len(set(A)) == 10 and len(set(B)) == 6 and not set(A) & set(B) and len(A) == len(B) + 4
assert any(not col(A[0], A[1], r) for r in A[2:]), "A collinear"
missing = [(p, q) for p, q in itertools.combinations(A, 2) if not any(col(p, q, b) for b in B)]
assert not missing, missing
print("erdos105 witness ok: 45 lines, each meets B")
```

Run: `python3 scripts/verify_erdos105.py`
Expected: `erdos105 witness ok: 45 lines, each meets B`.

- [ ] **Step 3: Write the frozen challenge in the checker repository**

`challenge/erdos105.lean`:

```lean
import FormalConjectures.ErdosProblems.«105»

open EuclideanGeometry

/-- Erdős 105, variant `sub_four`, resolved negatively.
This is the negation of the universal statement in
`Erdos105.erdos_105.variants.sub_four` at formal-conjectures commit df3f12d7bd06. -/
theorem erdos_105_sub_four_false :
    ¬ ∀ A B : Finset ℝ², Disjoint A B → A.card = B.card + 4 →
      ¬ Collinear ℝ (A : Set ℝ²) →
      ∃ p ∈ A, ∃ q ∈ A, p ≠ q ∧ ∀ b ∈ B, b ∉ line[ℝ, p, q] := by
  sorry
```

`comparator/erdos105.json`:

```json
{
  "challenge_module": "Challenge",
  "solution_module": "Solution",
  "theorem_names": ["erdos_105_sub_four_false"],
  "permitted_axioms": ["propext", "Quot.sound", "Classical.choice"],
  "enable_nanoda": false
}
```

`scripts/axioms/erdos105.lean`:

```lean
import Solution

/-- info: 'erdos_105_sub_four_false' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in
#print axioms erdos_105_sub_four_false
```

If the proof ends up using fewer axioms, the `#guard_msgs` text must match exactly; adjust it to the actual output once the proof exists (the checker's Comparator step is the security, the audit step is documentation).

Commit and push the checker repository.

- [ ] **Step 4: Stage the agent repository**

Copy `challenge/erdos105.lean` to `Challenge.lean` in the agent repository (hooks allow this when done by Daniel or by a script outside a Claude Code session; do it with `cp` in a terminal).
Write `Solution.lean` as the statement with `sorry` so the project builds:

```lean
import FormalConjectures.ErdosProblems.«105»

open EuclideanGeometry

theorem erdos_105_sub_four_false :
    ¬ ∀ A B : Finset ℝ², Disjoint A B → A.card = B.card + 4 →
      ¬ Collinear ℝ (A : Set ℝ²) →
      ∃ p ∈ A, ∃ q ∈ A, p ≠ q ∧ ∀ b ∈ B, b ∉ line[ℝ, p, q] := by
  sorry
```

Add to `TASKS.md`:

```markdown
| E105-1 | erdos105 | define A and B as Finsets of ℝ² from data/erdos105.json; prove card, disjointness, and ¬Collinear | todo |
| E105-2 | erdos105 | lemma: for p ≠ q in ℝ² and b, `b ∈ line[ℝ, p, q]` from an explicit real t with b = t • (q -ᵥ p) +ᵥ p | todo |
| E105-3 | erdos105 | the 45-case check: for every pair in A exhibit the b and t; assemble `erdos_105_sub_four_false` | todo |
```

Commit and push (the Solution contains `sorry`, which is allowed on the staging commit made outside a session; the guard only runs inside sessions).
Rebuild the environment artifact as `env-v2` with `lake build Challenge Solution` on this commit and update the setup script's `BASE` to `env-v2`, so sessions start with the 105 import closure built.

- [ ] **Step 5: Run the orchestrator session**

Daniel starts a cloud session on the agent repository with model Claude Fable 5.1 and this prompt:

```
Follow AGENTS.md and prompts/orchestrator.md. Work the todo tasks in TASKS.md in order. Workers use model opus at effort xhigh with a 25-minute time box. When a worker reports green on E105-3, push and stop so Daniel can run the checker.
```

Daniel checks in every 60 minutes during this first run (read `STATE.json`, the last ledger rows, `git log --stat`).

- [ ] **Step 6: Checker run and ledger**

When the orchestrator reports a pushed green commit:

```bash
AGENT_SHA=<sha from the orchestrator>
gh workflow run verify.yml -R danielpuri1901/erdos-lean-checker -f agent_commit="$AGENT_SHA" -f target=erdos105
sleep 20; gh run watch -R danielpuri1901/erdos-lean-checker "$(gh run list -R danielpuri1901/erdos-lean-checker --workflow verify.yml --limit 1 --json databaseId --jq '.[0].databaseId')" --exit-status
RUN_URL=$(gh run list -R danielpuri1901/erdos-lean-checker --workflow verify.yml --limit 1 --json url --jq '.[0].url')
cd ~/Desktop/Projects/erdos-lean-formalization && git pull
bash scripts/ledger.sh add --task E105-3 --attempt <n> --commit "$AGENT_SHA" --verdict pass --minutes <m> --cost <usd> --checker "$RUN_URL" --note "comparator green"
git add -A && git commit -m "ledger: erdos105 checker verdict" && git push
```

Expected: `comparator/erdos105` status `success` on the agent commit; `STATE.json` shows `E105-3.done = true`.
If the checker fails while the session built green, the diff between the session's `Challenge.lean` and the frozen one, or a forbidden token, is the first thing to check; record the cause in the ledger note.

- [ ] **Step 7: Archive and record**

```bash
cp Solution.lean solutions/erdos105.lean
git add solutions/erdos105.lean && git commit -m "archive: accepted erdos105 solution" && git push
```

Write in `docs/preflight.md` under "Erdős 105 warm-up": attempts, minutes, dollars, failure types seen, denials counted, checker run URL, and what Daniel did versus the model.

---

## Later phases (separate plan)

The main run (Green 72 task queue, arms A and B, three runs per cell) and the write-up are planned after Task 11 produces real numbers for burn, build times, and worker behavior.
That plan starts from the measured `docs/budget.md` and the Task 10 kernel decision.
