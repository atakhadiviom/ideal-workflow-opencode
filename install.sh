#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"

echo "Installing ideal-workflow-opencode..."

mkdir -p "$CONFIG_DIR/agents" "$CONFIG_DIR/skills"

ln -sfn "$REPO_DIR/agents/ideal-plan.md"   "$CONFIG_DIR/agents/ideal-plan.md"
ln -sfn "$REPO_DIR/agents/ideal-build.md"  "$CONFIG_DIR/agents/ideal-build.md"
ln -sfn "$REPO_DIR/agents/ideal-review.md" "$CONFIG_DIR/agents/ideal-review.md"
ln -sfn "$REPO_DIR/skills/ideal-workflow"  "$CONFIG_DIR/skills/ideal-workflow"

echo "Installed. Restart OpenCode to activate."
echo ""
echo "Usage in OpenCode TUI:"
echo '  "Ideal workflow: add JWT auth to the API"'
echo ""
echo "Models used per phase:"
echo "  Plan:   opencode/glm-5-1  (edit ~/.config/opencode/agents/ideal-plan.md to switch)"
echo "  Build:  opencode/minimax-m2-7"
echo "  Review: opencode/qwen-3-6-plus"
