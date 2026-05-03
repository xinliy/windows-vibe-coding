# Claude Code Instructions

This repo configures a Windows + WSL AI coding environment. Follow the same
safety model as `AGENTS.md`.

## Default Behavior

Run diagnosis first. Use dry-run installers second. Never execute installation
commands unless the user explicitly approves.

## Diagnosis

From WSL:

```bash
./scripts/doctor.sh --json
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(wslpath -w scripts/doctor.ps1)" -Json
```

From Windows PowerShell:

```powershell
.\scripts\doctor.ps1 -Json
```

## Dry-Run Install Plans

From WSL:

```bash
./scripts/install-wsl.sh --group all
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(wslpath -w scripts/install-windows.ps1)" -Group all
```

From Windows PowerShell:

```powershell
.\scripts\install-windows.ps1 -Group all
```

## Do Not Do This Without Approval

```powershell
.\scripts\install-windows.ps1 -Group all -Run -Yes
```

```bash
./scripts/install-wsl.sh --group all --run --yes
```
