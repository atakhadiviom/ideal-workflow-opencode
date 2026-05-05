# ideal-workflow-opencode

Three-phase **Plan → Build → Review** pipeline for OpenCode with automatic model switching.

Uses the optimal model for each phase via OpenCode subagents:

| Phase | Agent | Model |
|-------|-------|-------|
| Plan | `@ideal-plan` | GLM-5.1 or Kimi K2.6 |
| Build | `@ideal-build` | MiniMax M2.7 or DeepSeek V4 Pro |
| Review | `@ideal-review` | Qwen3.6 Plus |

## How it works

No plugins, no CLI commands. Just type in OpenCode TUI:

```
Ideal workflow: add JWT authentication to the API
```

The primary agent detects the trigger phrase via the `ideal-workflow` skill,
then automatically:
1. Invokes `@ideal-plan` (GLM-5.1) to produce an architecture plan
2. Implements the feature itself (Build)
3. Invokes `@ideal-review` (Qwen3.6 Plus) to audit code quality
4. Fixes any blocking issues found

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/<your-org>/ideal-workflow-opencode/main/install.sh | bash
```

Or clone and run manually:

```bash
git clone https://github.com/<your-org>/ideal-workflow-opencode
cd ideal-workflow-opencode
./install.sh
```

Restart OpenCode after installing.

## Customize models

Edit the agent files in `~/.config/opencode/agents/` to change models:

```yaml
# ideal-plan.md — switch to Kimi K2.6
model: opencode/kimi-k2-6

# ideal-build.md — switch to DeepSeek V4 Pro
model: opencode/deepseek-v4-pro
```

## Requirements

- OpenCode with Zen or Go plan (required models are only available via these plans)
- Run `opencode /models` to verify model availability

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/<your-org>/ideal-workflow-opencode/main/uninstall.sh | bash
```

Or run `./uninstall.sh` from the cloned repo.

## Files

```
~/.config/opencode/
├── agents/
│   ├── ideal-plan.md       # Plan subagent (read-only)
│   ├── ideal-build.md      # Build subagent (full access)
│   └── ideal-review.md     # Review subagent (read-only)
└── skills/
    └── ideal-workflow/
        └── SKILL.md        # Auto-detected orchestration skill
```
