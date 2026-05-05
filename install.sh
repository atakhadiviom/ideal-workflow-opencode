#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"

echo "╔══════════════════════════════════════════╗"
echo "║  ideal-workflow-opencode installer       ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# --- Fetch models from opencode-go ---
echo "Fetching available models from opencode-go..."
MODELS=$(opencode models opencode-go 2>/dev/null || true)
if [ -z "$MODELS" ]; then
  echo "ERROR: Could not fetch models. Make sure OpenCode is configured."
  exit 1
fi

# Build arrays (bash 3+ compatible)
mapfile -t MODEL_IDS <<< "$MODELS"

echo ""
echo "Available models:"
for i in "${!MODEL_IDS[@]}"; do
  printf "  %2d) %s\n" $((i+1)) "${MODEL_IDS[$i]}"
done
echo ""

# -- Phase 1: Plan --
echo "────────────────────────────────────────"
echo "Select model for PLAN phase (architecture planning, read-only):"
echo "  Recommended: opencode-go/glm-5.1"
echo "  Alternative: opencode-go/kimi-k2.6"
echo ""
PS3="Pick a number for Plan: "
select PLAN_MODEL in "${MODEL_IDS[@]}"; do
  if [ -n "$PLAN_MODEL" ]; then
    echo "  → Plan: $PLAN_MODEL"
    break
  fi
done

echo ""

# -- Phase 2: Build --
echo "────────────────────────────────────────"
echo "Select model for BUILD phase (implementation, full access):"
echo "  Recommended: opencode-go/minimax-m2.7"
echo "  Alternative: opencode-go/deepseek-v4-pro"
echo ""
PS3="Pick a number for Build: "
select BUILD_MODEL in "${MODEL_IDS[@]}"; do
  if [ -n "$BUILD_MODEL" ]; then
    echo "  → Build: $BUILD_MODEL"
    break
  fi
done

echo ""

# -- Phase 3: Review --
echo "────────────────────────────────────────"
echo "Select model for REVIEW phase (code review, read-only):"
echo "  Recommended: opencode-go/qwen3.6-plus"
echo "  Alternative: opencode-go/qwen3.5-plus"
echo ""
PS3="Pick a number for Review: "
select REVIEW_MODEL in "${MODEL_IDS[@]}"; do
  if [ -n "$REVIEW_MODEL" ]; then
    echo "  → Review: $REVIEW_MODEL"
    break
  fi
done

echo ""

# --- Confirm ---
echo "╔══════════════════════════════════════════╗"
echo "║  Summary                                 ║"
echo "╠══════════════════════════════════════════╣"
printf "║  Plan:   %-33s ║\n" "$PLAN_MODEL"
printf "║  Build:  %-33s ║\n" "$BUILD_MODEL"
printf "║  Review: %-33s ║\n" "$REVIEW_MODEL"
echo "╚══════════════════════════════════════════╝"
echo ""

# --- Install files ---
mkdir -p "$CONFIG_DIR/agents" "$CONFIG_DIR/skills" "$CONFIG_DIR/prompts"

ln -sfn "$REPO_DIR/prompts/plan.txt"  "$CONFIG_DIR/prompts/plan.txt"
ln -sfn "$REPO_DIR/prompts/build.txt" "$CONFIG_DIR/prompts/build.txt"
ln -sfn "$REPO_DIR/skills/ideal-workflow" "$CONFIG_DIR/skills/ideal-workflow"

# --- Generate opencode.json ---
CONFIG_FILE="$CONFIG_DIR/opencode.json"

cat > "$CONFIG_FILE" <<JSONEOF
{
  "\$schema": "https://opencode.ai/config.json",
  "agent": {
    "plan": {
      "model": "$PLAN_MODEL",
      "prompt": "{file:$CONFIG_DIR/prompts/plan.txt}",
      "permission": { "edit": "deny", "bash": "deny" }
    },
    "build": {
      "model": "$BUILD_MODEL",
      "prompt": "{file:$CONFIG_DIR/prompts/build.txt}"
    },
    "ideal-review": {
      "model": "$REVIEW_MODEL",
      "mode": "subagent",
      "permission": { "edit": "deny", "bash": "deny" }
    }
  }
}
JSONEOF

echo "Written $CONFIG_FILE"
echo ""
echo "╔══════════════════════════════════════════╗"
echo "║  Installed! Restart OpenCode to activate.║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "Usage:"
echo "  Hit Tab for Plan mode  → $PLAN_MODEL"
echo "  Default Build mode     → $BUILD_MODEL"
echo "  Say \"review this\"      → $REVIEW_MODEL"
echo ""
echo "Re-run this installer anytime to swap models."
