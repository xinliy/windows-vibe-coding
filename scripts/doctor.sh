#!/usr/bin/env bash
set -u

ok() {
  printf '[OK]   %s\n' "$1"
}

miss() {
  printf '[MISS] %s\n' "$1"
  if [ "${2:-}" != "" ]; then
    printf '       %s\n' "$2"
  fi
}

has() {
  command -v "$1" >/dev/null 2>&1
}

echo "Windows Vibe Coding Doctor"
echo

if grep -qi microsoft /proc/version 2>/dev/null; then
  ok "Running inside WSL"
else
  miss "Running inside WSL" "Run this script from your WSL distro."
fi

case "$PWD" in
  /mnt/*)
    miss "Project path is in WSL filesystem" "Move active projects under ~/code for better performance."
    ;;
  *)
    ok "Project path is in WSL filesystem"
    ;;
esac

echo
echo "Linux tools:"

for cmd in git gh node npm code docker claude codex gemini; do
  if has "$cmd"; then
    version="$($cmd --version 2>/dev/null | head -n 1)"
    ok "$cmd ${version:+($version)}"
  else
    case "$cmd" in
      node|npm)
        miss "$cmd" "Install Node.js LTS inside WSL."
        ;;
      claude)
        miss "$cmd" "npm install -g @anthropic-ai/claude-code"
        ;;
      codex)
        miss "$cmd" "npm install -g @openai/codex"
        ;;
      gemini)
        miss "$cmd" "npm install -g @google/gemini-cli"
        ;;
      code)
        miss "$cmd" "Install VS Code on Windows and Remote - WSL extension."
        ;;
      docker)
        miss "$cmd" "Install Docker Desktop on Windows and enable WSL integration."
        ;;
      *)
        miss "$cmd"
        ;;
    esac
  fi
done
