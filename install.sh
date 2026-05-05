#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"

echo "Installing ideal-workflow-opencode..."

mkdir -p "$CONFIG_DIR/agents" "$CONFIG_DIR/skills" "$CONFIG_DIR/prompts"

# Agents
ln -sfn "$REPO_DIR/agents/ideal-review.md" "$CONFIG_DIR/agents/ideal-review.md"

# Prompts (used by overridden built-in agents)
ln -sfn "$REPO_DIR/prompts/plan.txt"  "$CONFIG_DIR/prompts/plan.txt"
ln -sfn "$REPO_DIR/prompts/build.txt" "$CONFIG_DIR/prompts/build.txt"

# Skill
ln -sfn "$REPO_DIR/skills/ideal-workflow" "$CONFIG_DIR/skills/ideal-workflow"

# Merge agent overrides into opencode.json
CONFIG_FILE="$CONFIG_DIR/opencode.json"
FRAGMENT="$REPO_DIR/opencode.json"

if [ -f "$CONFIG_FILE" ]; then
  if command -v jq &>/dev/null; then
    merged=$(jq -s '.[0] as $existing | .[1] as $fragment
      | $existing * $fragment' "$CONFIG_FILE" "$FRAGMENT")
    echo "$merged" > "$CONFIG_FILE"
    echo "Merged agent config into $CONFIG_FILE"
  else
    echo "WARNING: jq not found. Add this to $CONFIG_FILE manually:"
    cat "$FRAGMENT"
  fi
else
  cp "$FRAGMENT" "$CONFIG_FILE"
  echo "Created $CONFIG_FILE"
fi

echo ""
echo "Installed. Restart OpenCode to activate."
echo ""
echo "Model routing:"
echo "  Plan (Tab)   → GLM-5.1 (read-only)"
echo "  Build (Tab)  → MiniMax M2.7 (full access)"
echo "  @ideal-review → Qwen3.6+ (read-only)"
echo ""
echo "Review/debug/test keywords auto-route to @ideal-review."
