#!/usr/bin/env bash
set -euo pipefail

echo "Windows Vibe Coding WSL Installer"
echo
echo "MVP installer is conservative. It prints recommended commands instead of changing your system."
echo

cat <<'COMMANDS'
sudo apt update
sudo apt install -y build-essential curl git unzip

# Install Node.js LTS using your preferred version manager or distro package.
# Then install AI coding CLIs:
npm install -g @anthropic-ai/claude-code
npm install -g @openai/codex
npm install -g @google/gemini-cli

claude login
codex login
gemini
COMMANDS

echo
echo "Run ./scripts/doctor.sh before and after installation."
