# ideal-workflow-opencode

Wire OpenCode's Plan → Build → Review pipeline to the best available OpenCode Go models — installed in one command, customizable anytime.

## Model routing

| Phase | Trigger | Default (pipe install) |
|---|---|---|
| Plan | Tab | `opencode-go/glm-5.1` |
| Build | Default | `opencode-go/minimax-m2.7` |
| Review / Debug / Test | Say "review this" | `opencode-go/qwen3.6-plus` |

## Install

**One-liner (pipe mode)** — uses recommended defaults, no prompts:

```bash
curl -fsSL https://raw.githubusercontent.com/atakhadiviom/ideal-workflow-opencode/main/install.sh | bash
```

**Interactive** — pick a model for each phase from your available models:

```bash
~/.config/opencode/ideal-workflow-src/install.sh
```

Re-run the interactive installer anytime to swap models.

## How it works

- Built-in `plan` agent overridden with your chosen model + architecture prompt
- Built-in `build` agent overridden with your chosen model + implementation prompt
- `ideal-review` subagent invoked automatically when you say "review", "debug", or "test"
- Skill auto-detected — no trigger phrases needed

## Requirements

- OpenCode Go plan (models are on the `opencode-go` provider)
- `git` must be available for the one-liner install
- Run `opencode models opencode-go` to see your available models

## Files

```
~/.config/opencode/
├── opencode.json              # Generated config with your model picks
├── prompts/
│   ├── plan.txt               # Plan phase system prompt
│   └── build.txt              # Build phase system prompt
├── skills/
│   └── ideal-workflow/
│       └── SKILL.md           # Routes debug/test/review to ideal-review
└── ideal-workflow-src/        # Cloned repo (used by pipe-mode install)
    └── install.sh             # Re-run to change models interactively
```
