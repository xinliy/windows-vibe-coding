# Recommended Architecture

Use Windows for the desktop shell, browser, editor UI, and Docker Desktop.
Use WSL for project files, Git operations, package managers, and AI coding CLIs.

## Why WSL

Most AI coding CLIs and developer toolchains behave more predictably in a
Linux-like environment. WSL also avoids many Windows path, shell, and permission
edge cases.

## File Location

Prefer:

```text
~/code/my-project
```

Avoid for active development:

```text
/mnt/c/Users/<you>/code/my-project
```

Working under the WSL filesystem is usually faster and avoids many permission
and file-watching problems.

## CLI Location

Install these inside WSL:

- Node.js LTS
- Claude Code
- OpenAI Codex
- Gemini CLI
- Project package managers

Keep these on Windows:

- Windows Terminal
- VS Code
- Docker Desktop
- Browser authentication
