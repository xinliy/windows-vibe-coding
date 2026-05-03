# Windows Vibe Coding Setup

A practical Windows + WSL setup for Claude Code, OpenAI Codex, Gemini CLI,
VS Code, Docker, MCP, screenshots, and sane AI coding workflows.

This repo is being built as an opinionated, inspectable setup kit for developers
who use Windows as their main machine but want Linux-first AI coding workflows
inside WSL.

## MVP Goal

The first version focuses on three things:

1. Explain the recommended Windows + WSL architecture clearly.
2. Detect common setup problems with a `doctor` command.
3. Provide incremental install scripts that users can read before running.

## Quick Start

From Windows PowerShell:

```powershell
.\scripts\doctor.ps1
```

From WSL:

```bash
./scripts/doctor.sh
```

Install scripts are intentionally separate:

```powershell
.\scripts\install-windows.ps1
```

```bash
./scripts/install-wsl.sh
```

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

## Status

Early MVP. The current scripts are conservative and mostly diagnostic. The
project will add automated installation step by step.

## License

MIT
