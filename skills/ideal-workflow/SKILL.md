---
name: ideal-workflow
description: Three-phase Plan (GLM-5.1) → Build (MiniMax M2.7) → Review (Qwen3.6+) pipeline with automatic model switching
license: MIT
compatibility: opencode
metadata:
  models: opencode/go, opencode/zen
---

## What I do

Automates the full development lifecycle for a feature in one shot:

1. **Plan** — Delegates to `@ideal-plan` (GLM-5.1 / Kimi K2.6) to produce an architecture plan
2. **Build** — You implement the feature following the plan
3. **Review** — Delegates to `@ideal-review` (Qwen3.6+) to audit code quality

Each subagent uses a different model optimized for its phase. The user sees a
single session — model switching is transparent.

## When to use me

Use this when the user's message starts with or contains any of:
- "ideal workflow"
- "pipeline:"
- "full stack:"
- "plan, build, review"

## Workflow

1. Invoke `@ideal-plan` via the **Task tool** with:
   - The user's feature request
   - Instructions to read relevant files and produce an architecture plan
   - Ask it to return the plan in the structured format

2. Read the plan output. Implement the feature yourself (you are the Build agent
   with edit permissions). Follow the plan exactly.

3. Invoke `@ideal-review` via the **Task tool** with:
   - The architecture plan (so it knows what was intended)
   - The diff of changes made
   - Ask it to return a review report

4. If the review report contains BLOCKING issues, fix them.
   If MINOR issues, mention them to the user.

5. Present a completion summary:
   - What was built
   - Models used per phase
   - Review outcome
