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
