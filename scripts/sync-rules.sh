#!/bin/bash
# Regenerate Cursor rules from the canonical Markdown sources.
# Run after editing CLAUDE.md or modules/*.md so Claude Code and Cursor stay in sync.
# Usage: ./scripts/sync-rules.sh

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RULES_DIR="$REPO_ROOT/.cursor/rules"
mkdir -p "$RULES_DIR"

# gen <source.md> <dest.mdc> <alwaysApply> <description>
gen() {
  local src="$1" dest="$2" always="$3" desc="$4"
  if [ ! -f "$src" ]; then
    echo "error: $src not found" >&2
    exit 1
  fi
  {
    echo "---"
    echo "description: $desc"
    echo "alwaysApply: $always"
    echo "---"
    echo ""
    echo "<!-- Generated from ${src#"$REPO_ROOT"/} by scripts/sync-rules.sh — do not edit directly. -->"
    echo ""
    cat "$src"
  } > "$dest"
  echo "synced: ${src#"$REPO_ROOT"/} → ${dest#"$REPO_ROOT"/}"
}

# Core rules — always on.
gen "$REPO_ROOT/CLAUDE.md" "$RULES_DIR/main.mdc" "true" \
    "Core rules — how the assistant works in this project (always on)."

# Sysadmin module — loaded on demand by Cursor when the task matches.
gen "$REPO_ROOT/modules/sysadmin.md" "$RULES_DIR/sysadmin.mdc" "false" \
    "Sysadmin / terminal / server administration — load for system config, package management, SSH, daemons, or server work."
