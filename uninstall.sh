#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"

echo "Uninstalling ideal-workflow-opencode..."

# Remove agents
rm -f "$CONFIG_DIR/agents/ideal-review.md"

# Remove prompts
rm -f "$CONFIG_DIR/prompts/plan.txt" "$CONFIG_DIR/prompts/build.txt"

# Remove skill
rm -rf "$CONFIG_DIR/skills/ideal-workflow"

# Remove agent config from opencode.json
CONFIG_FILE="$CONFIG_DIR/opencode.json"
if [ -f "$CONFIG_FILE" ]; then
  if command -v jq &>/dev/null; then
    cleaned=$(jq 'del(.agent.plan, .agent.build)' "$CONFIG_FILE")
    echo "$cleaned" > "$CONFIG_FILE"
    echo "Removed agent overrides from $CONFIG_FILE"
  else
    echo "WARNING: jq not found. Remove 'agent.plan' and 'agent.build' from $CONFIG_FILE manually."
  fi
fi

echo "Uninstalled."
