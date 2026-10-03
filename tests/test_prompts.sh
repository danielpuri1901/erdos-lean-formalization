#!/usr/bin/env bash
# Checks the run instructions carry the feedback-loop rules (worker, orchestrator, AGENTS.md).
set -u
cd "$(dirname "$0")/.."
fail=0
has()  { grep -qiF -- "$2" "$1" && echo "ok   $1 has: $2" || { echo "FAIL $1 lacks: $2"; fail=1; }; }
lacks(){ grep -qiF -- "$2" "$1" && { echo "FAIL $1 still has: $2"; fail=1; } || echo "ok   $1 lacks: $2"; }
W=prompts/worker.md; O=prompts/orchestrator.md; A=AGENTS.md
has   $W 'first action is `lake build Solution`'
has   $W 'wip({{task_id}}): stop'
has   $W 'even if the build is red'
has   $W '{{checker_description}}'
has   $W 'tried:'
has   $W 'blocking:'
lacks $W '{{last_diagnostic}}'
lacks $W '20 error lines'
lacks $W '20 lines'
lacks $O 'last diagnostic'
lacks $O '20 error lines'
has   $O 'submit(<target>):'
has   $O 'description'
has   $O 'cheat=1'
has   $O '"do not match"'
has   $O '"Illegal axiom"'
has   $O 'tried='
has   $O 'blocking='
lacks $A '20 error lines'
lacks $A 'Daniel (or a scheduled dispatch'
has   $A 'submit(<target>):'
exit $fail
