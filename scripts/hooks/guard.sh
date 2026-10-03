#!/usr/bin/env bash
# PreToolUse guard. Reads the hook JSON on stdin. Exit 2 denies; the stderr line is shown to Claude.
set -u
input=$(cat)
read -r path text < <(printf '%s' "$input" | python3 -c '
import json,sys
d=json.load(sys.stdin); t=d.get("tool_input",{})
p=t.get("file_path","").replace("\\","/")
txt="\n".join([t.get("content",""), t.get("new_string","")] + [e.get("new_string","") for e in t.get("edits",[])])
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
