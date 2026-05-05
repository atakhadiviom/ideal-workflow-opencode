#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"

echo "Uninstalling ideal-workflow-opencode..."

rm -f "$CONFIG_DIR/agents/ideal-plan.md"
rm -f "$CONFIG_DIR/agents/ideal-build.md"
rm -f "$CONFIG_DIR/agents/ideal-review.md"
rm -rf "$CONFIG_DIR/skills/ideal-workflow"

echo "Uninstalled."
