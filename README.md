# ideal-workflow-opencode

Interactive model selector for OpenCode's Plan → Build → Review pipeline.

When you install, it asks you to pick a model for each phase from all your
available OpenCode Go models.

## Model routing

| Mode | Model |
|---|---|
| Plan (Tab) | Your pick (e.g. GLM-5.1, Kimi K2.6) |
| Build (Tab) | Your pick (e.g. MiniMax M2.7, DeepSeek V4 Pro) |
| Review/Debug/Test | Your pick (e.g. Qwen3.6+) |

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/atakhadiviom/ideal-workflow-opencode/main/install.sh | bash
```

You'll be prompted to pick a model for each phase from your available models.

Re-run anytime to swap models.

## How it works

- Built-in `plan` agent overridden with your chosen model + architecture prompt
- Built-in `build` agent overridden with your chosen model + implementation prompt
- `ideal-review` subagent invoked automatically when you say "review", "debug", "test"
- Skill auto-detected — no trigger phrases needed

## Requirements

- OpenCode Go plan (models are on the `opencode-go` provider)
- Run `opencode models opencode-go` to see available models

## Files

```
~/.config/opencode/
├── opencode.json           # Generated config with your model picks
├── prompts/
│   ├── plan.txt            # Plan system prompt
│   └── build.txt           # Build system prompt
└── skills/
    └── ideal-workflow/
        └── SKILL.md        # Routes debug/test/review to ideal-review
```
