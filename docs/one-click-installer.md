# One-Click Installer Roadmap

The repo should eventually support a beginner-friendly installer, but the
installer must be built on top of reliable diagnostics and dry-run behavior.

## Target User Experience

Beginner flow:

1. Download `WindowsVibeCodingSetup.exe` or run a signed PowerShell bootstrapper.
2. Click "Diagnose".
3. Review missing components.
4. Click "Install recommended setup".
5. Re-run diagnosis and show what changed.

Power-user flow:

```powershell
irm https://raw.githubusercontent.com/<owner>/windows-vibe-coding/main/install.ps1 | iex
```

## Packaging Options

### Phase 1: PowerShell Bootstrapper

Best first release.

- Easy to inspect.
- Easy to update.
- Works without compiling an app.
- Can call `scripts/doctor.ps1` and `scripts/install-windows.ps1`.

Tradeoff: users may be nervous about copy-paste shell installers, so the README
must show exactly what it does.

### Phase 2: Zip Package

Provide a release asset:

```text
windows-vibe-coding-mvp.zip
  Start-Here.ps1
  scripts/
  docs/
```

This works well for users who do not have Git installed yet.

The MVP already includes `Start-Here.ps1` as the future package entrypoint. It
runs diagnosis first and prints the next commands without installing anything.

### Phase 3: Signed EXE

Build a small GUI or TUI wrapper.

- Shows diagnosis results from `doctor.ps1 -Json`.
- Offers install groups such as `minimal`, `ai-cli`, `docker`, and `frontend`.
- Requires code signing for trust.

Tradeoff: higher maintenance cost. Do this only after the scripts are stable.

## Safety Rules

- Never silently change system state.
- Always support dry-run.
- Always show exact commands before running them.
- Keep Windows and WSL installation steps separate.
- Re-run doctor after every install stage.
- Prefer official installers and package managers.

## MVP Installer Scope

The first installer should only:

- Check Windows version.
- Check WSL availability and default distro.
- Check WinGet availability.
- Offer to install Windows Terminal, PowerShell 7, Git, GitHub CLI, VS Code, and
  Docker Desktop.
- Tell the user to reboot when WSL requires it.
- Open WSL instructions after Windows setup completes.

## Current Script Contract

The installer scripts are now designed around the contract needed by a future
one-click package:

- Preview by default.
- Execute only with `-Run` or `--run`.
- Ask before every command unless `-Yes` or `--yes` is set.
- Install by named groups instead of one opaque full setup.

This means the one-click package can safely start by running a diagnosis and
showing the same command plan that power users can run manually.
