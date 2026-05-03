#!/usr/bin/env bash
set -euo pipefail

RUN=0
YES=0
INSTALL_GROUPS=("minimal")

usage() {
  cat <<'USAGE'
Windows Vibe Coding WSL Installer

Usage:
  ./scripts/install-wsl.sh [--group minimal|node|ai-cli|frontend|all] [--run] [--yes]

Default behavior is a dry run. No system changes are made unless --run is set.

Examples:
  ./scripts/install-wsl.sh
  ./scripts/install-wsl.sh --group all
  ./scripts/install-wsl.sh --group minimal --group ai-cli --run
  ./scripts/install-wsl.sh --group all --run --yes
USAGE
}

is_valid_group() {
  case "$1" in
    minimal|node|ai-cli|frontend|all) return 0 ;;
    *) return 1 ;;
  esac
}

INSTALL_GROUPS=()
while [ "$#" -gt 0 ]; do
  case "$1" in
    --group)
      if [ "$#" -lt 2 ]; then
        echo "Missing value for --group" >&2
        exit 2
      fi
      if ! is_valid_group "$2"; then
        echo "Unknown group: $2" >&2
        usage
        exit 2
      fi
      INSTALL_GROUPS+=("$2")
      shift 2
      ;;
    --run)
      RUN=1
      shift
      ;;
    --yes)
      YES=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 2
      ;;
  esac
done

if [ "${#INSTALL_GROUPS[@]}" -eq 0 ]; then
  INSTALL_GROUPS=("minimal")
fi

has_group() {
  local wanted="$1"
  local group
  for group in "${INSTALL_GROUPS[@]}"; do
    if [ "$group" = "$wanted" ] || [ "$group" = "all" ]; then
      return 0
    fi
  done
  return 1
}

confirm() {
  if [ "$YES" -eq 1 ]; then
    return 0
  fi

  local answer
  read -r -p "Run this command? [y/N] " answer
  case "$answer" in
    y|Y|yes|YES) return 0 ;;
    *) return 1 ;;
  esac
}

run_step() {
  local name="$1"
  local why="$2"
  local command="$3"

  printf '\n%s\n' "$name"
  printf '  %s\n' "$why"
  printf '  %s\n' "$command"

  if [ "$RUN" -eq 0 ]; then
    return 0
  fi

  if confirm; then
    bash -lc "$command"
  else
    printf '  skipped\n'
  fi
}

echo "Windows Vibe Coding WSL Installer"
echo

if [ "$RUN" -eq 0 ]; then
  echo "Dry run. No system changes will be made."
  echo "Add --run to execute. Add --yes to skip per-command prompts."
else
  echo "Run mode enabled. Commands may change this WSL distro."
fi

echo
echo "Groups: ${INSTALL_GROUPS[*]}"

if ! grep -qi microsoft /proc/version 2>/dev/null; then
  echo
  echo "[WARN] This does not look like WSL. The script can still run, but this repo targets WSL."
fi

if has_group "minimal"; then
  run_step \
    "Update apt package lists" \
    "Keeps Ubuntu package metadata current." \
    "sudo apt update"

  run_step \
    "Install base developer packages" \
    "Build tools and common utilities required by many projects." \
    "sudo apt install -y build-essential ca-certificates curl git unzip"
fi

if has_group "node"; then
  run_step \
    "Install fnm" \
    "Installs a Node.js version manager under your user account." \
    "curl -fsSL https://fnm.vercel.app/install | bash"

  run_step \
    "Install Node.js LTS with fnm" \
    "Installs the current LTS Node.js version for AI coding CLIs." \
    "export PATH=\"\$HOME/.local/share/fnm:\$PATH\"; eval \"\$(fnm env --shell bash)\"; fnm install --lts; fnm default lts-latest; node --version; npm --version"
fi

if has_group "ai-cli"; then
  run_step \
    "Install Claude Code" \
    "Installs Anthropic Claude Code globally via npm." \
    "npm install -g @anthropic-ai/claude-code"

  run_step \
    "Install OpenAI Codex" \
    "Installs OpenAI Codex globally via npm." \
    "npm install -g @openai/codex"

  run_step \
    "Install Gemini CLI" \
    "Installs Gemini CLI globally via npm." \
    "npm install -g @google/gemini-cli"
fi

if has_group "frontend"; then
  run_step \
    "Enable Corepack" \
    "Enables package-manager shims for pnpm and yarn on supported Node versions." \
    "corepack enable"
fi

echo
echo "After installation, run:"
echo "  ./scripts/doctor.sh"
