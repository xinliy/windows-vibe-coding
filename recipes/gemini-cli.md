# Gemini CLI Recipe

## Install

Inside WSL:

```bash
npm install -g @google/gemini-cli
```

## Basic Usage

```bash
cd ~/code/my-project
gemini
```

On first run, Gemini CLI opens a browser window for Google account
authentication. This opens on the Windows side — that is expected behavior in
WSL.

## Verify

```bash
gemini --version
```

## Common Issues

**`gemini: command not found` after install**

Your npm global bin directory may not be in `PATH`. Check:

```bash
npm config get prefix
```

Add `$(npm config get prefix)/bin` to your `PATH` in `~/.bashrc` or `~/.zshrc`.

**Browser does not open for authentication**

WSL2 can open Windows browsers via `wslview` or `xdg-open` if `wslu` is
installed:

```bash
sudo apt install wslu
```

After installing, retry `gemini` to trigger the auth flow again.

**Quota or rate limit errors**

Gemini CLI uses the free Gemini API tier by default. Switch to a paid API key
if you hit limits:

```bash
export GEMINI_API_KEY=your-key-here
gemini
```
