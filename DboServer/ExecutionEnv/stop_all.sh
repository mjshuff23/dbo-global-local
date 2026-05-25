#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WIN_SCRIPT="$(wslpath -w "$SCRIPT_DIR/stop_all.ps1")"

powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "$WIN_SCRIPT" "$@"
