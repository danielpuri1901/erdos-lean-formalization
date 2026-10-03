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
