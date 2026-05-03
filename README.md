# Windows Vibe Coding

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![shellcheck](https://github.com/xinliy/windows-vibe-coding/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/xinliy/windows-vibe-coding/actions/workflows/shellcheck.yml)

One command tells you exactly what's missing from your Windows + WSL AI coding
setup. Another installs what you need — step by step, dry-run by default.

Covers Claude Code, OpenAI Codex, Gemini CLI, VS Code, Docker, MCP, and common
WSL gotchas. Opinionated but inspectable.

[English](README.md) · [中文](README.zh-CN.md)

## What It Looks Like

![demo](demo.gif)

```
Windows Vibe Coding Doctor

[OK]   Running inside WSL
[OK]   Linux distro (Ubuntu 24.04 LTS)
[OK]   Project path is in WSL filesystem (/home/user/code/my-project)

Linux tools:
[OK]   git (git version 2.43.0)
[OK]   gh (gh version 2.47.0)
[OK]   node (v20.12.0)
[OK]   npm (10.5.0)
[MISS] claude
       npm install -g @anthropic-ai/claude-code
[MISS] codex
       npm install -g @openai/codex
[OK]   docker (Docker version 26.0.0)
[OK]   Docker daemon reachable

Summary: 2 issue(s) found.
```

## What This Repo Does

1. Explains the recommended Windows + WSL architecture.
2. Diagnoses your setup with a single `doctor` command.
3. Installs missing tools in readable, dry-run steps you approve before running.

## Quick Start

From Windows PowerShell:

```powershell
.\Start-Here.ps1
```

Or run the Windows doctor directly:

```powershell
.\scripts\doctor.ps1
```

Machine-readable output:

```powershell
.\scripts\doctor.ps1 -Json
```

From WSL:

```bash
./scripts/doctor.sh
```

Machine-readable output:

```bash
./scripts/doctor.sh --json
```

Install scripts are intentionally separate:

```powershell
.\scripts\install-windows.ps1
```

```bash
./scripts/install-wsl.sh
```

Both installers are dry-run by default. They print planned commands without
changing the system.

Run selected groups explicitly:

```powershell
.\scripts\install-windows.ps1 -Group minimal
.\scripts\install-windows.ps1 -Group all -Run
```

```bash
./scripts/install-wsl.sh --group minimal
./scripts/install-wsl.sh --group node --group ai-cli --run
```

See [docs/installers.md](docs/installers.md) for all groups and safety rules.

## Recommended Stack

- Windows 11
- WSL 2 with Ubuntu 24.04 LTS
- Windows Terminal
- PowerShell 7
- Git and GitHub CLI
- VS Code with Remote - WSL
- Node.js LTS inside WSL
- Claude Code, OpenAI Codex, and Gemini CLI inside WSL
- Docker Desktop with WSL integration

## Project Layout

```text
windows-vibe-coding/
  Start-Here.ps1
  docs/
    mvp.md
    architecture.md
    troubleshooting.md
  recipes/
    claude-code.md
    codex.md
    gemini-cli.md
    screenshots.md
  scripts/
    doctor.ps1
    doctor.sh
    install-windows.ps1
    install-wsl.sh
```

## Safety Model

Diagnosis is read-only. Installers are dry-run by default: they print every
planned command before running anything. Use `-Run` / `--run` to execute, and
`-Yes` / `--yes` to skip per-command prompts.

## One-Click Installer Direction

The long-term goal is a beginner-friendly installer. The first package will be
a readable PowerShell bootstrapper and zip release, then a signed EXE once the
scripts are stable. See [docs/one-click-installer.md](docs/one-click-installer.md).

## Already Have Claude Code Or Codex?

This repo includes agent instructions so an existing coding agent can help run
diagnosis and preview setup plans safely:

- [AGENTS.md](AGENTS.md)
- [CLAUDE.md](CLAUDE.md)
- [agent/skills/windows-vibe-coding/SKILL.md](agent/skills/windows-vibe-coding/SKILL.md)

See [docs/agent-workflows.md](docs/agent-workflows.md).

## License

MIT
