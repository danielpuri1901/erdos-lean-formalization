# Worker task

You are a fresh worker. Model: Claude Opus 5.5, effort xhigh. Time box: {{minutes}} minutes.

Task {{task_id}}: {{task_scope}}
Target theorem(s): {{theorem_names}} in `Solution.lean`.
Statement file: `Challenge.lean` (read only).
Published proof to formalize: {{proof_source}}
Lemma plan: {{lemma_plan}}
Known approaches that failed (from the ledger): {{failed_approaches}}
Last diagnostic (first 20 error lines of the previous attempt, or "none"): {{last_diagnostic}}

This is a formal translation of the supplied published proof, not an independent mathematics attempt.
Copy the theorem signature verbatim.
Formalize the supplied argument's steps; do not substitute a different proof strategy.
If the supplied mathematics looks false or insufficient, stop and report it instead of inventing assumptions.

Work only in `Solution.lean` (and `data/` if the task says so).
Build with `export PATH=/opt/lean/bin:$PATH && lake build Solution`.
Count every build you run.
Commit after every green build with a message starting `wip({{task_id}}):`.
Stop at the time box even if unfinished.

Return exactly this report, nothing else:

status: green | partial | stuck
commit: <sha or none>
sorries_before: <n>
sorries_after: <n>
builds: <number of builds you ran>
files_changed: <list>
tried: <3 lines max>
blocking: <2 lines max: the exact goal or error, first 20 error lines appended below>
math_concern: none | <2 lines max: which step of the supplied proof looks false or insufficient, and the goal or error that shows it>
errors:
<first 20 lines of the last failing build, or "none">
