# Windows Vibe Coding Setup

面向 Windows + WSL 用户的一站式 AI coding 环境配置项目，覆盖 Claude Code、OpenAI Codex、Gemini CLI、VS Code、Docker、MCP、截图粘贴和常见踩坑。

这个 repo 的目标不是做个人 dotfiles，而是做一个可读、可检查、可逐步执行的 Windows AI coding 标准环境。

## MVP 目标

第一版先解决三件事：

1. 讲清楚推荐的 Windows + WSL 架构。
2. 提供 `doctor` 检查脚本，定位常见问题。
3. 提供分阶段安装脚本，用户可以先读再运行。

## 快速开始

Windows PowerShell:

```powershell
.\Start-Here.ps1
```

或者直接运行 Windows doctor：

```powershell
.\scripts\doctor.ps1
```

机器可读输出：

```powershell
.\scripts\doctor.ps1 -Json
```

WSL:

```bash
./scripts/doctor.sh
```

机器可读输出：

```bash
./scripts/doctor.sh --json
```

安装脚本分开执行：

```powershell
.\scripts\install-windows.ps1
```

```bash
./scripts/install-wsl.sh
```

两个安装器默认都是 dry-run，只打印计划命令，不会改系统。

显式选择安装分组：

```powershell
.\scripts\install-windows.ps1 -Group minimal
.\scripts\install-windows.ps1 -Group all -Run
```

```bash
./scripts/install-wsl.sh --group minimal
./scripts/install-wsl.sh --group node --group ai-cli --run
```

完整分组和安全规则见 [docs/installers.md](docs/installers.md)。

## 推荐技术栈

- Windows 11
- WSL 2 + Ubuntu 24.04 LTS
- Windows Terminal
- PowerShell 7
- Git 和 GitHub CLI
- VS Code + Remote - WSL
- WSL 内安装 Node.js LTS
- WSL 内安装 Claude Code、OpenAI Codex、Gemini CLI
- Docker Desktop + WSL integration

## 当前状态

早期 MVP。当前脚本偏保守：诊断脚本是安全的，安装脚本默认 dry-run，只有显式加运行参数才会执行。

## 一键安装包方向

后续可以提供面向小白用户的一键安装入口。建议先做可读的 PowerShell
bootstrapper 和 zip release，等脚本稳定后再做签名 EXE。路线见
[docs/one-click-installer.md](docs/one-click-installer.md)。
