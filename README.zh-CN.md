# Windows Vibe Coding

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![shellcheck](https://github.com/xinliy/windows-vibe-coding/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/xinliy/windows-vibe-coding/actions/workflows/shellcheck.yml)

**让 Windows 在 vibe coding 上一样出色。**

大多数 AI coding 工具默认以 Mac 为标准。这个 repo 补上这个差距——帮你把
WSL 配对，检测缺什么、装什么，覆盖 Claude Code、Codex、Gemini CLI、VS Code
和 Docker，每一步都可以先看再执行。

[English](README.md) · [中文](README.zh-CN.md)

## 运行效果

![demo](demo-doctor.gif)

```
Windows Vibe Coding Doctor

[OK]   Running inside WSL
[OK]   Linux distro (Ubuntu 24.04 LTS)
[OK]   Project path is in WSL filesystem (/home/user/code/my-project)

Linux tools:
[OK]   git (git version 2.43.0)
[OK]   gh (gh version 2.47.0)
[OK]   node (v20.12.0)
[OK]   npm (10.5.0)
[MISS] claude
       npm install -g @anthropic-ai/claude-code
[MISS] codex
       npm install -g @openai/codex
[OK]   docker (Docker version 26.0.0)
[OK]   Docker daemon reachable

Summary: 2 issue(s) found.
```

## 这个项目做什么

1. 讲清楚推荐的 Windows + WSL 架构。
2. 用一条 `doctor` 命令诊断你的环境。
3. 提供分步安装脚本，可以先读再运行。

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

## 安全原则

诊断脚本只读，不改系统。安装脚本默认 dry-run，打印所有计划命令后等待确认。加 `-Run` / `--run` 才会执行，加 `-Yes` / `--yes` 跳过逐步确认。

## 一键安装包方向

后续提供面向新手的一键安装入口：先做可读的 PowerShell bootstrapper 和 zip release，脚本稳定后再做签名 EXE。路线见
[docs/one-click-installer.md](docs/one-click-installer.md)。

## 已经装了 Claude Code 或 Codex？

这个 repo 提供了 agent 指令文件，已有的 coding agent 可以安全地帮你跑诊断和预览安装计划：

- [AGENTS.md](AGENTS.md)
- [CLAUDE.md](CLAUDE.md)
- [agent/skills/windows-vibe-coding/SKILL.md](agent/skills/windows-vibe-coding/SKILL.md)

说明见 [docs/agent-workflows.md](docs/agent-workflows.md)。
