# ideal-workflow-opencode

**Plan → Build → Review** pipeline with automatic model switching per mode.

No trigger phrases needed. Just use OpenCode normally — models switch automatically based on the mode you're in.

## Model routing

| When you... | Mode | Model |
|---|---|---|
| Hit **Tab** to Plan mode | Plan | GLM-5.1 |
| Start typing (Build mode) | Build | MiniMax M2.7 |
| Say "review", "debug", "test", "check" | @ideal-review | Qwen3.6+ |

## How it works

Three mechanisms work together:

1. **Built-in `plan` agent overridden** — uses GLM-5.1 + architecture prompt (read-only)
2. **Built-in `build` agent overridden** — uses MiniMax M2.7 + implementation prompt
3. **`@ideal-review` subagent** — Qwen3.6+ invoked automatically when you ask for review/debug/test

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/atakhadiviom/ideal-workflow-opencode/main/install.sh | bash
```

Or clone and run manually:

```bash
git clone https://github.com/atakhadiviom/ideal-workflow-opencode
cd ideal-workflow-opencode
./install.sh
```

Restart OpenCode after installing.

## Customize models

Edit `~/.config/opencode/opencode.json`:

```json
{
  "agent": {
    "plan": { "model": "opencode/kimi-k2-6" },
    "build": { "model": "opencode/deepseek-v4-pro" }
  }
}
```

## Requirements

- OpenCode with Zen or Go plan
- Run `opencode models opencode` to verify model availability

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/atakhadiviom/ideal-workflow-opencode/main/uninstall.sh | bash
```

## Files

```
~/.config/opencode/
├── opencode.json           # Agent overrides (plan + build models/prompts)
├── prompts/
│   ├── plan.txt            # Plan system prompt (read-only)
│   └── build.txt           # Build system prompt (full access)
├── agents/
│   └── ideal-review.md     # Review subagent (read-only, Qwen3.6+)
└── skills/
    └── ideal-workflow/
        └── SKILL.md        # Auto-detected, routes debug/test/review
```
