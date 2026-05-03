# Agent Instructions

Use this file when an AI coding agent is helping a user configure this repo.

## Mission

Help the user diagnose and configure a Windows + WSL AI coding environment for
Claude Code, OpenAI Codex, Gemini CLI, VS Code, Docker, and related workflows.

## Safety Rules

- Default to diagnosis and dry-run installation.
- Do not run `-Run`, `-Yes`, `--run`, or `--yes` without explicit user approval.
- Show the user the planned commands before executing anything that changes the
  system.
- Prefer the repo scripts over hand-written setup commands.
- Keep Windows-side and WSL-side setup separate.
- Do not edit user shell profiles, Windows registry, PATH, or Docker settings
  directly unless the user explicitly asks and the change is documented.

## Recommended Flow

1. Identify whether the agent is running in WSL, Windows PowerShell, or another
   shell.
2. Run Windows diagnosis when available:

   ```bash
   powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(wslpath -w scripts/doctor.ps1)" -Json
   ```

   Or from Windows PowerShell:

   ```powershell
   .\scripts\doctor.ps1 -Json
   ```

3. Run WSL diagnosis:

   ```bash
   ./scripts/doctor.sh --json
   ```

4. Summarize missing items in plain language.
5. Preview installation plans only:

   ```powershell
   .\scripts\install-windows.ps1 -Group minimal
   ```

   ```bash
   ./scripts/install-wsl.sh --group minimal --group node --group ai-cli
   ```

6. Ask before running any install command.
7. Re-run doctor scripts after each install stage.

## Useful Commands

Windows dry-run from WSL:

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(wslpath -w scripts/install-windows.ps1)" -Group all
```

WSL dry-run:

```bash
./scripts/install-wsl.sh --group all
```

## Reporting

When reporting results:

- Lead with missing or risky items.
- Include the exact command the user can run next.
- Mention whether a command was a dry-run or actually changed the system.
- Keep notes concise enough for a beginner to act on.
