#!/bin/bash
set -u
RUNTIME_DIR="$(cd "$(dirname "$0")" && pwd)"
BASE_DIR="$(cd "$RUNTIME_DIR/.." && pwd)"
LOG_FILE="${TMPDIR:-/tmp}/hook_architect_launcher.log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "========================================"
echo "   HOOK ARCHITECT PRO - LINUX"
echo "========================================"
echo "Log: $LOG_FILE"
echo ""

APP_BIN="$RUNTIME_DIR/HookArchitectPro/HookArchitectPro"
if [ ! -x "$APP_BIN" ]; then
  echo "❌ ERROR: bundled app binary is missing or not executable: $APP_BIN"
  echo "Try re-extracting the ZIP, then run this launcher again."
  if [ -t 0 ]; then read -r -p "Press Enter to exit..."; fi
  exit 1
fi

if [ "${1:-}" = "--self-test" ]; then
  "$APP_BIN" --self-test
  exit $?
fi

echo "🚀 Launching Hook Architect Pro..."
exec "$APP_BIN" "$@"
