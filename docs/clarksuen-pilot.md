# Clark-Suen pilot

Question: is the Clark-Suen inequality hard enough that a harness can help, or does a bare session prove it quickly?
Daniel expects it to be easy for the AI, so one bare run measures it before six runs are spent.

- Target: `clarksuen` (`clark_suen`, statement checks in `docs/preflight.md`).
- Branch: `run/cs-pilot`, the main branch without harness files, like the bare arm of the Green 72 run.
- Model: Claude Opus 5.5 at effort xhigh, environment `erdos-lean`.
- Caps: 20 USD and 4 hours.
- Decision rule: green in under 1 hour means Clark-Suen is too easy, and the next target is the stronger Suen-Tarr bound in the same file. Otherwise run the full 3 plus 3 on Clark-Suen.

Prompt:

```
Prove clark_suen in Solution.lean. Challenge.lean holds the frozen statement; it is the Clark-Suen inequality (2000) from formal-conjectures. Do not look up existing Lean formalizations; work from the mathematics. Build with: export PATH=/opt/lean/bin:$PATH && lake build Solution. When the proof builds with no sorry, commit with the message "submit(clarksuen): bare pilot" and push to your branch, then poll gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status until comparator/clarksuen is success or failure; the checker picks up the commit within a few minutes and a verdict takes about 30 minutes. On failure read the status description, fix, and submit again. Stop at success or after 4 hours.
```

## Result

Pending.
