# Installer Usage

The install scripts are conservative by design. They preview commands by
default and only make changes when explicitly asked.

## Windows Installer

Preview the minimal Windows setup:

```powershell
.\scripts\install-windows.ps1 -Group minimal
```

Run it with confirmation before each command:

```powershell
.\scripts\install-windows.ps1 -Group minimal -Run
```

Run every command without prompts:

```powershell
.\scripts\install-windows.ps1 -Group all -Run -Yes
```

Groups:

- `minimal`: WSL, Windows Terminal, PowerShell 7, Git, GitHub CLI, VS Code
- `docker`: Docker Desktop
- `all`: `minimal` and `docker`

## WSL Installer

Preview the minimal WSL setup:

```bash
./scripts/install-wsl.sh --group minimal
```

Preview a full setup:

```bash
./scripts/install-wsl.sh --group all
```

Run Node and AI CLI installation with confirmation before each command:

```bash
./scripts/install-wsl.sh --group node --group ai-cli --run
```

Run every command without prompts:

```bash
./scripts/install-wsl.sh --group all --run --yes
```

Groups:

- `minimal`: apt update, build tools, certificates, curl, git, unzip
- `node`: fnm and Node.js LTS
- `ai-cli`: Claude Code, OpenAI Codex, Gemini CLI
- `frontend`: Corepack for package manager shims
- `all`: all groups

## Safety Model

- Dry-run is the default.
- `-Run` or `--run` is required before commands execute.
- Each command asks for confirmation unless `-Yes` or `--yes` is set.
- Windows setup and WSL setup stay separate.
- Run the doctor scripts before and after installation.
