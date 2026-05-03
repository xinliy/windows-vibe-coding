# OpenAI Codex Recipe

## Install

Inside WSL:

```bash
npm install -g @openai/codex
```

Set your API key:

```bash
export OPENAI_API_KEY=sk-...
```

Add the export to `~/.bashrc` or `~/.zshrc` to persist it.

## Basic Usage

```bash
cd ~/code/my-project
codex
```

## Common Issues

**`codex: command not found` after install**

Your npm global bin directory may not be in `PATH`. Check:

```bash
npm config get prefix
```

Add `$(npm config get prefix)/bin` to your `PATH` in `~/.bashrc`.

**API key not found**

Codex reads `OPENAI_API_KEY` from the environment. Verify it is set:

```bash
echo $OPENAI_API_KEY
```

If empty, re-export it or add it to your shell profile.

**Running from `/mnt/c/...` is slow**

Move the project into the WSL filesystem:

```bash
mkdir -p ~/code
cp -r /mnt/c/Users/<you>/code/my-project ~/code/
cd ~/code/my-project
codex
```
