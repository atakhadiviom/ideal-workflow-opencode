---
name: ideal-workflow
description: Model-optimized pipeline — Plan (GLM-5.1), Build (MiniMax M2.7), Review (Qwen3.6+). Auto-routes by mode and keyword.
license: MIT
compatibility: opencode
metadata:
  models: opencode-go
---

## What I do

Each OpenCode mode uses its optimized model. Alternatives can be swapped in
by editing `~/.config/opencode/opencode.json`.

| Mode | Agent | Default model | Alternative |
|------|-------|---------------|-------------|
| Plan (Tab) | Built-in plan | `opencode-go/glm-5.1` | `opencode-go/kimi-k2.6` |
| Build (Tab) | Built-in build | `opencode-go/minimax-m2.7` | `opencode-go/deepseek-v4-pro` |
| Review/Debug/Test | ideal-review | `opencode-go/qwen3.6-plus` | — |

The user switches modes via Tab — model switching is transparent.

## When to use me

Always active. The built-in `plan` and `build` agents are configured
with optimized models via opencode.json.

## Routing rules

- **Plan mode** (user hits Tab to Plan): GLM-5.1 + architecture prompt
- **Build mode** (user hits Tab to Build): MiniMax M2.7 + implementation prompt
- **Review/Debug/Test**: when user asks for "review", "debug", "test", "check",
  "audit", "quality", or similar — delegate to `ideal-review` subagent via the
  Task tool. Pass the relevant code/files as context.
