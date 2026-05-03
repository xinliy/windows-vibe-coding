# Windows Vibe Coding

Use this skill when a user wants help diagnosing, installing, or fixing a
Windows + WSL AI coding setup for Claude Code, OpenAI Codex, Gemini CLI,
VS Code, Docker, screenshots, terminals, or related agentic coding workflows.

## Core Rule

Diagnose first. Dry-run second. Install only after explicit user approval.

## Repo Assumption

The skill is intended to be used from the root of the `windows-vibe-coding`
repo. If the files are not present, ask the user to clone or extract the repo
first.

Expected files:

```text
Start-Here.ps1
scripts/doctor.ps1
scripts/doctor.sh
scripts/install-windows.ps1
scripts/install-wsl.sh
docs/installers.md
```

## Environment Detection

If running in WSL, prefer:

```bash
./scripts/doctor.sh --json
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(wslpath -w scripts/doctor.ps1)" -Json
```

If running in Windows PowerShell, prefer:

```powershell
.\scripts\doctor.ps1 -Json
```

If `powershell.exe` is available from WSL, use it to test Windows-side scripts.

## Diagnosis Flow

1. Run the WSL doctor when in WSL.
2. Run the Windows doctor when Windows PowerShell is reachable.
3. Parse JSON output when possible.
4. Summarize missing tools and risky configuration.
5. Recommend the smallest install group that fixes the current problem.

## Dry-Run Install Plans

Windows preview:

```powershell
.\scripts\install-windows.ps1 -Group minimal
.\scripts\install-windows.ps1 -Group all
```

From WSL:

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(wslpath -w scripts/install-windows.ps1)" -Group all
```

WSL preview:

```bash
./scripts/install-wsl.sh --group minimal
./scripts/install-wsl.sh --group node --group ai-cli
./scripts/install-wsl.sh --group all
```

## Installation Approval

Never run these without explicit user approval:

```powershell
.\scripts\install-windows.ps1 -Group all -Run
.\scripts\install-windows.ps1 -Group all -Run -Yes
```

```bash
./scripts/install-wsl.sh --group all --run
./scripts/install-wsl.sh --group all --run --yes
```

If the user approves installation, prefer confirmation prompts and avoid `-Yes`
or `--yes` unless the user explicitly asks for unattended execution.

## After Installation

Always re-run diagnosis:

```bash
./scripts/doctor.sh --json
```

```powershell
.\scripts\doctor.ps1 -Json
```

Then report:

- What changed.
- What is still missing.
- Which command to run next.

## Boundaries

Do not manually edit:

- Windows registry
- Windows PATH
- User shell profiles
- Docker Desktop settings
- VS Code settings

Use repo scripts and documented recipes unless the user explicitly asks for a
manual fix.
