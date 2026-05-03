# Agent Workflows

This repo can be used directly by Claude Code, Codex, or another coding agent
after the user has already installed one of them.

## Files For Agents

- `AGENTS.md`: general instructions for coding agents.
- `CLAUDE.md`: Claude Code specific instructions.
- `agent/skills/windows-vibe-coding/SKILL.md`: portable skill description.

## Recommended Prompt

Use this from the repo root:

```text
Read AGENTS.md and help me diagnose this Windows + WSL AI coding setup.
Run doctor scripts first, only use dry-run install plans, and ask before
executing anything that changes the system.
```

For Claude Code:

```text
Read CLAUDE.md and diagnose my Windows vibe coding setup. Do not install
anything until you show me the plan and I approve it.
```

## Agent Safety Contract

Agents should:

- Run `doctor.ps1 -Json` and `doctor.sh --json` first.
- Prefer dry-run installers.
- Avoid `-Run`, `-Yes`, `--run`, and `--yes` without explicit user approval.
- Re-run diagnosis after every install stage.
- Report concrete next commands.

## Why This Exists

Many users who need this setup may already have Claude Code or Codex installed
but still have a messy Windows/WSL environment. The agent instructions let those
tools use this repo safely instead of inventing ad hoc install commands.
