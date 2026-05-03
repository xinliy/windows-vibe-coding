# Development Steps

## Step 1: Repo Skeleton

Status: done.

- README in English and Chinese
- MVP roadmap
- Architecture notes
- Troubleshooting notes
- Initial recipes
- Windows and WSL doctor scripts
- Conservative install script placeholders

## Step 2: Make Doctor Scripts Actually Useful

Next implementation target.

- Improve Windows WSL detection output.
- Add Windows version detection.
- Add WSL default distro detection.
- Add Docker Desktop WSL integration hints.
- Add CLI login detection where practical.
- Add machine-readable summary mode.

## Step 3: Add Safe Install Modes

- Add `-WhatIf`/dry-run behavior for PowerShell.
- Add explicit confirmation before installing each package.
- Add package groups: `minimal`, `ai-cli`, `docker`, `frontend`.
- Keep Windows and WSL installation separate.

## Step 4: Document The Golden Path

- Windows first-time setup.
- WSL first-time setup.
- Existing WSL migration.
- Project location and path strategy.
- VS Code Remote - WSL workflow.

## Step 5: Add Shareable Assets

- Terminal screenshots.
- Before/after doctor output.
- Short GIF for setup flow.
- GitHub topics and launch checklist.

## Current MVP Acceptance Criteria

- A new user can read the README and understand the recommended architecture.
- A Windows user can run `scripts/doctor.ps1` without system changes.
- A WSL user can run `scripts/doctor.sh` without system changes.
- Missing tools produce concrete next commands.
- The repo is publishable even before full automation exists.
