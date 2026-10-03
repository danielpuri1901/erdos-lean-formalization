# Worker task

You are a fresh worker. Model: Claude Opus 5.5, effort xhigh. Time box: {{minutes}} minutes.

Task {{task_id}}: {{task_scope}}
Target theorem(s): {{theorem_names}} in `Solution.lean`.
Statement file: `Challenge.lean` (read only).
Published proof to formalize: {{proof_source}}
Lemma plan: {{lemma_plan}}
What earlier attempts tried and why they failed (from the ledger): {{failed_approaches}}
Checker verdict on the last submitted commit, or "none": {{checker_description}}

This is a formal translation of the supplied published proof, not an independent mathematics attempt.
Copy the theorem signature verbatim.
Formalize the supplied argument's steps; do not substitute a different proof strategy.
If the supplied mathematics looks false or insufficient, stop and report it instead of inventing assumptions.

Your first action is `lake build Solution` (after `export PATH=/opt/lean/bin:$PATH`).
It shows every current error in full, including the ones the previous worker left.
Work only in `Solution.lean` (and `data/` if the task says so).
Count every build you run.
Commit after every green build with a message starting `wip({{task_id}}):`.
Stop at the time box even if unfinished.
When you stop, always commit the final state, even if the build is red, with the message `wip({{task_id}}): stop`.

`green` means `lake build Solution` succeeds and `Solution.lean` contains no `sorry`.
`partial` means you made progress but one of those two is still false; `stuck` means you made none.

Return exactly this report, nothing else:

status: green | partial | stuck
commit: <sha of your final commit>
sorries_before: <n>
sorries_after: <n>
builds: <number of builds you ran>
files_changed: <list>
tried: <2 lines max: what you tried>
blocking: <2 lines max: why it failed, with the exact goal or error>
math_concern: none | <2 lines max: which step of the supplied proof looks false or insufficient, and the goal or error that shows it>
