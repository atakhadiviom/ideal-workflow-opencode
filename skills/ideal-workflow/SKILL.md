---
name: ideal-workflow
description: Model-optimized pipeline — Plan (GLM-5.1), Build (MiniMax M2.7), Review (Qwen3.6+). Auto-routes by mode and keyword.
license: MIT
compatibility: opencode
metadata:
  models: opencode/go, opencode/zen
---

## What I do

Each OpenCode mode uses its optimized model. Alternatives can be swapped in
by editing `~/.config/opencode/opencode.json`.

| Mode | Agent | Default model | Alternative |
|------|-------|---------------|-------------|
| Plan (Tab) | Built-in plan | GLM-5.1 | Kimi K2.6 |
| Build (Tab) | Built-in build | MiniMax M2.7 | DeepSeek V4 Pro |
| Review/Debug/Test | @ideal-review | Qwen3.6+ | — |

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

## Swapping alternatives

To switch Plan to Kimi K2.6 or Build to DeepSeek V4 Pro:
```json
{
  "agent": {
    "plan": { "model": "opencode/kimi-k2-6" },
    "build": { "model": "opencode/deepseek-v4-pro" }
  }
}
```
