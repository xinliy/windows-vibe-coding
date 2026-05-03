#!/usr/bin/env bash
set -u

JSON=0
if [ "${1:-}" = "--json" ]; then
  JSON=1
fi

RESULTS=()

json_escape() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

record() {
  local category="$1"
  local name="$2"
  local ok_value="$3"
  local value="${4:-}"
  local hint="${5:-}"

  RESULTS+=("{\"category\":\"$(json_escape "$category")\",\"name\":\"$(json_escape "$name")\",\"ok\":$ok_value,\"value\":\"$(json_escape "$value")\",\"hint\":\"$(json_escape "$hint")\"}")
}

ok() {
  local category="$1"
  local name="$2"
  local value="${3:-}"
  record "$category" "$name" true "$value" ""
  if [ "$JSON" -eq 0 ]; then
    if [ "$value" != "" ]; then
      printf '[OK]   %s (%s)\n' "$name" "$value"
    else
      printf '[OK]   %s\n' "$name"
    fi
  fi
}

miss() {
  local category="$1"
  local name="$2"
  local hint="${3:-}"
  record "$category" "$name" false "" "$hint"
  if [ "$JSON" -eq 0 ]; then
    printf '[MISS] %s\n' "$name"
    if [ "$hint" != "" ]; then
      printf '       %s\n' "$hint"
    fi
  fi
}

has() {
  command -v "$1" >/dev/null 2>&1
}

version_of() {
  "$1" --version 2>/dev/null | head -n 1
}

if [ "$JSON" -eq 0 ]; then
  echo "Windows Vibe Coding Doctor"
  echo
fi

if grep -qi microsoft /proc/version 2>/dev/null; then
  ok "system" "Running inside WSL"
else
  miss "system" "Running inside WSL" "Run this script from your WSL distro."
fi

if [ -r /etc/os-release ]; then
  # shellcheck source=/dev/null
  distro="$(. /etc/os-release && printf '%s %s' "${NAME:-Linux}" "${VERSION_ID:-}")"
  ok "system" "Linux distro" "$distro"
fi

case "$PWD" in
  /mnt/*)
    miss "filesystem" "Project path is in WSL filesystem" "Move active projects under ~/code for better performance."
    ;;
  *)
    ok "filesystem" "Project path is in WSL filesystem" "$PWD"
    ;;
esac

if [ "$JSON" -eq 0 ]; then
  echo
  echo "Linux tools:"
fi

for cmd in git gh node npm code docker claude codex gemini; do
  if has "$cmd"; then
    version="$(version_of "$cmd")"
    ok "linux-tools" "$cmd" "$version"
  else
    case "$cmd" in
      node|npm)
        miss "linux-tools" "$cmd" "Install Node.js LTS inside WSL."
        ;;
      claude)
        miss "linux-tools" "$cmd" "npm install -g @anthropic-ai/claude-code"
        ;;
      codex)
        miss "linux-tools" "$cmd" "npm install -g @openai/codex"
        ;;
      gemini)
        miss "linux-tools" "$cmd" "npm install -g @google/gemini-cli"
        ;;
      code)
        miss "linux-tools" "$cmd" "Install VS Code on Windows and Remote - WSL extension."
        ;;
      docker)
        miss "linux-tools" "$cmd" "Install Docker Desktop on Windows and enable WSL integration."
        ;;
      *)
        miss "linux-tools" "$cmd"
        ;;
    esac
  fi
done

if has docker; then
  if docker info >/dev/null 2>&1; then
    ok "docker" "Docker daemon reachable"
  else
    miss "docker" "Docker daemon reachable" "Start Docker Desktop and enable WSL integration for this distro."
  fi
fi

if has gh; then
  if gh auth status >/dev/null 2>&1; then
    ok "auth" "GitHub CLI authenticated"
  else
    miss "auth" "GitHub CLI authenticated" "Run: gh auth login"
  fi
fi

if has npm; then
  prefix="$(npm config get prefix 2>/dev/null)"
  case "$prefix" in
    /usr|/usr/local)
      miss "node" "npm global prefix avoids sudo friction" "Consider using fnm, nvm, or another Node version manager. Current prefix: $prefix"
      ;;
    *)
      ok "node" "npm global prefix avoids sudo friction" "$prefix"
      ;;
  esac
fi

if [ "$JSON" -eq 1 ]; then
  printf '{"tool":"windows-vibe-coding-doctor","platform":"wsl","generatedAt":"%s","results":[%s]}\n' \
    "$(date -Iseconds)" "$(IFS=,; echo "${RESULTS[*]}")"
else
  missing=0
  for result in "${RESULTS[@]}"; do
    case "$result" in
      *'"ok":false'*) missing=$((missing + 1)) ;;
    esac
  done
  echo
  printf 'Summary: %s issue(s) found.\n' "$missing"
fi
