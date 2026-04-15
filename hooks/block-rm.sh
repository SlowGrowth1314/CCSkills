#!/bin/bash
# block-rm.sh - Prevent dangerous rm commands in Claude Code
# Usage: Configure as PreToolUse hook in ~/.claude/settings.json

input=$(cat)
tool_name=$(echo "$input" | jq -r '.tool_name')
tool_input=$(echo "$input" | jq -r '.tool_input')

if [ "$tool_name" = "Bash" ]; then
  command=$(echo "$tool_input" | jq -r '.command // empty')
  if echo "$command" | grep -qE '(^|[;&|]\s*)rm\s'; then
    echo "BLOCKED: rm command detected. Use mv <file> ~/.Trash/ instead." >&2
    exit 2
  fi
fi

exit 0