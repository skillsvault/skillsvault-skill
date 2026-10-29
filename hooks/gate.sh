#!/bin/sh
# Hands the hook payload to the skillsvault CLI's gate, which decides against
# the organisation's signed policy bundle on this machine (no network call).
#
# Does nothing when:
#   - the CLI isn't installed (install: https://skillsvault.io/docs/cli), or
#   - the gate is already wired in .claude/settings.json by `skillsvault
#     install-hook`, so one invocation isn't gated and logged twice.
command -v skillsvault >/dev/null 2>&1 || exit 0
for f in "${CLAUDE_PROJECT_DIR:-.}/.claude/settings.json" "${CLAUDE_PROJECT_DIR:-.}/.claude/settings.local.json" "$HOME/.claude/settings.json"; do
  [ -f "$f" ] && grep -q 'skillsvault gate' "$f" 2>/dev/null && exit 0
done
exec skillsvault gate
