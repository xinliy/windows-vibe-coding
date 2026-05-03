# MVP Plan

## Positioning

`windows-vibe-coding` should become the default starting point for developers
who want a reliable AI coding CLI workflow on Windows with WSL.

## Phase 1: Trustworthy Skeleton

- Create English and Chinese README files.
- Document the recommended architecture.
- Add non-destructive doctor scripts for Windows and WSL.
- Add conservative install scripts with dry-run defaults.
- Add recipes for Claude Code, Codex, Gemini CLI, and screenshots.

## Phase 2: Useful Doctor

- Detect WSL installation and version.
- Detect default distro.
- Detect whether the project path is under `/mnt/c`.
- Detect Git, GitHub CLI, Node.js, npm, Docker, VS Code, and common CLIs.
- Print concrete remediation commands.

## Phase 3: Incremental Installation

- Install Windows Terminal, PowerShell 7, Git, VS Code, and Docker Desktop via
  WinGet where available.
- Install Ubuntu via WSL if missing.
- Install Node.js LTS inside WSL.
- Install Claude Code, Codex, and Gemini CLI inside WSL.

Current implementation:

- Installers are dry-run by default.
- Windows installer supports `minimal`, `docker`, and `all`.
- WSL installer supports `minimal`, `node`, `ai-cli`, `frontend`, and `all`.

## Phase 4: Workflow Polish

- Add screenshot and clipboard recipes.
- Add Windows Terminal profile recommendations.
- Add VS Code Remote - WSL settings.
- Add Docker Desktop WSL integration checks.
- Add MCP setup examples.

## Phase 5: Launch

- Add screenshots/GIFs.
- Add badges and topics.
- Publish GitHub repo.
- Share with Chinese and English developer communities.
