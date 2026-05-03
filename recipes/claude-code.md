# Claude Code Recipe

## Install

Inside WSL:

```bash
npm install -g @anthropic-ai/claude-code
claude login
```

Verify:

```bash
claude --version
```

## Basic Usage

```bash
cd ~/code/my-project
claude
```

Always run Claude Code from inside WSL, not from a Windows path like `/mnt/c/...`.
File watching and performance are significantly better under the WSL filesystem.

## Recommended CLAUDE.md

Drop a `CLAUDE.md` at your project root to give Claude persistent context:

```markdown
# Project

Short description of what this project does.

## Stack

- Node.js 20 / TypeScript
- PostgreSQL via Docker

## Common Tasks

- `npm test` — run tests
- `npm run lint` — lint
- `docker compose up -d` — start local DB
```

Claude Code reads this file automatically when you start a session.

## MCP Servers

Claude Code supports MCP (Model Context Protocol) servers for tools like
filesystem access, web search, and custom integrations.

List configured servers:

```bash
claude mcp list
```

Add a server (example: filesystem access):

```bash
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem ~/code
```

MCP config is stored in `~/.claude/mcp.json`.

## Common Issues

**`claude: command not found` after install**

Your npm global bin directory may not be in `PATH`. Check:

```bash
npm config get prefix
# e.g. /home/user/.local/share/fnm/node-versions/v20.12.0/installation
```

Add the bin path to `~/.bashrc` or `~/.zshrc`:

```bash
export PATH="$(npm config get prefix)/bin:$PATH"
```

**Slow response or timeout in WSL**

Check that your project is under `~/code/`, not `/mnt/c/...`. Run the doctor:

```bash
./scripts/doctor.sh
```

**Auth loop / `claude login` keeps failing**

Open `https://claude.ai` in your Windows browser first, sign in, then retry
`claude login` in WSL. The OAuth flow opens a Windows browser window — this is
expected.
