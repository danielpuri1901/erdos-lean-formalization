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

Session `session_01DskXZYGFpgPjwQ7gu2U3ZM`, launched 2026-10-03 at 21:49 UTC with the credit meter at 223 USD.

Green: commit `34b9afe` (first submission, 21:58 UTC, 10 minutes after launch), checker verdict "Your solution is okay!" at 22:11 UTC ([checker run](https://github.com/danielpuri1901/erdos-lean-checker/actions/runs/37156965900)).
Minutes to green: 22. Cost: about 2 USD (meter 223 to 221 USD). Submissions: 1.
The proof is 125 lines and follows the paper: a minimum dominating set of G splits the vertices into cells, and two counting claims give γ(G)γ(H) ≤ |D| + |D|.
By the decision rule, Clark-Suen is too easy for a harness comparison; Daniel predicted this.
