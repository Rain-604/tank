#!/usr/bin/env bash
set -euo pipefail

# Simple local CI script for TankAssignment
# - builds the project
# - runs cppcheck if available
# - runs the executable under Xvfb (headless)

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="${SCRIPT_DIR}/.."
cd "${ROOT}/tank_assignment"

echo "== Build =="
make -j$(nproc)

echo "== Static analysis (cppcheck) =="
if command -v cppcheck >/dev/null 2>&1; then
  cppcheck --enable=warning,performance,portability,style \
           --suppress=missingIncludeSystem -I ../common --force . || true
else
  echo "cppcheck not installed; skipping static analysis"
fi

echo "== Run (headless) =="
if command -v xvfb-run >/dev/null 2>&1; then
  xvfb-run --auto-servernum --server-args='-screen 0 1280x720x24' ./TankAssignment || {
    echo "Executable failed"; exit 1; }
else
  echo "xvfb-run not found; attempting direct run (may fail without display)"
  ./TankAssignment || { echo "Executable failed"; exit 1; }
fi

echo "All checks passed"
