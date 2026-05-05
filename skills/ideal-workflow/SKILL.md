---
name: ideal-workflow
description: Model-optimized pipeline — Plan (GLM-5.1), Build (MiniMax M2.7), Review (Qwen3.6+). Auto-routes by mode and keyword.
license: MIT
compatibility: opencode
metadata:
  models: opencode/go, opencode/zen
---

## What I do

Each OpenCode mode uses its optimized model:

| Mode | Agent | Model |
|------|-------|-------|
| Plan (Tab) | Built-in plan | GLM-5.1 |
| Build (Tab) | Built-in build | MiniMax M2.7 |
| Review/Debug/Test | @ideal-review | Qwen3.6+ |

The user switches modes via Tab — model switching is transparent.

## When to use me

Always active. The built-in `plan` and `build` agents are already configured
with the correct models and prompts via opencode.json.

## Routing rules

- **Plan mode** (user hits Tab to Plan): agent already has GLM-5.1 + architecture prompt
- **Build mode** (user hits Tab to Build): agent already has MiniMax M2.7 + implementation prompt
- **Review/Debug/Test**: when user asks for "review", "debug", "test", "check",
  "audit", "quality", or similar — delegate to `@ideal-review` via the Task tool.
  Pass the relevant code/files as context.
