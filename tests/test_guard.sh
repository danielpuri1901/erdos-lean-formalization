#!/usr/bin/env bash
set -u
cd "$(dirname "$0")/.."
G=scripts/hooks/guard.sh
# The guard logs denials to $CLAUDE_PROJECT_DIR/LEDGER.md; keep test denials out of the real ledger.
CLAUDE_PROJECT_DIR=$(mktemp -d); export CLAUDE_PROJECT_DIR
fail=0
check() { # name, expected exit, json
  out=$(printf '%s' "$3" | bash "$G" 2>&1); code=$?
  if [ "$code" -ne "$2" ]; then echo "FAIL $1: exit $code, expected $2: $out"; fail=1; else echo "ok   $1"; fi
}
check deny_challenge 2 '{"tool_name":"Edit","tool_input":{"file_path":"/w/erdos-lean-formalization/Challenge.lean","old_string":"a","new_string":"b"}}'
check deny_sorry 2 '{"tool_name":"Write","tool_input":{"file_path":"/w/erdos-lean-formalization/Solution.lean","content":"theorem x : True := by sorry"}}'
check deny_native 2 '{"tool_name":"Edit","tool_input":{"file_path":"/w/erdos-lean-formalization/solutions/a.lean","old_string":"","new_string":"by native_decide"}}'
check deny_axiom 2 '{"tool_name":"Write","tool_input":{"file_path":"/w/erdos-lean-formalization/Solution.lean","content":"axiom bad : False"}}'
check deny_multiedit 2 '{"tool_name":"MultiEdit","tool_input":{"file_path":"/w/erdos-lean-formalization/Solution.lean","edits":[{"old_string":"a","new_string":"b"},{"old_string":"c","new_string":"by sorry"}]}}'
check allow_solution 0 '{"tool_name":"Write","tool_input":{"file_path":"/w/erdos-lean-formalization/Solution.lean","content":"theorem x : True := trivial"}}'
check allow_other 0 '{"tool_name":"Write","tool_input":{"file_path":"/w/erdos-lean-formalization/LEDGER.md","content":"sorry is a word here"}}'
[ "$(grep -c '| guard |' "$CLAUDE_PROJECT_DIR/LEDGER.md" 2>/dev/null)" = 5 ] && echo "ok   denials_logged" || { echo "FAIL denials_logged: expected 5 guard rows"; fail=1; }
exit $fail
