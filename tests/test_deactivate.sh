#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/helpers.sh"
INSTALL="${CONFIG_HOME}/install.sh"

echo "=== test_deactivate ==="

# Setup: activate a few entries first
bash "$INSTALL" --activate fish zsh --force 2>&1 >/dev/null

# Test 1: Deactivate an activated entry
echo "  [1] Deactivate an activated entry (fish)"
bash "$INSTALL" --deactivate fish --force 2>&1 >/dev/null
assert_not_exists "${XDG_CONFIG_HOME}/fish" "fish symlink should be removed"

# Test 2: Deactivate an already-inactive entry (idempotency)
echo "  [2] Deactivate already-inactive entry (idempotency)"
output="$(bash "$INSTALL" --deactivate fish --force 2>&1)"
ec=$?
assert_exit_code "$ec" 0 "idempotent deactivate should succeed"

# Test 3: Deactivate zsh
echo "  [3] Deactivate zsh"
bash "$INSTALL" --deactivate zsh --force 2>&1 >/dev/null
assert_not_exists "$HOME/.zshrc" "zshrc symlink should be removed"

# Test 4: Status shows both as deactivated
echo "  [4] Status shows entries as deactivated"
status_output="$(bash "$INSTALL" --status 2>&1)"
# Fish and zsh should NOT have ✓
if echo "$status_output" | grep -q "✓ fish"; then
  echo "FAIL: fish should not be activated"
  (( FAIL_COUNT++ )) || true
else
  (( PASS_COUNT++ )) || true
fi
if echo "$status_output" | grep -q "✓ zsh"; then
  echo "FAIL: zsh should not be activated"
  (( FAIL_COUNT++ )) || true
else
  (( PASS_COUNT++ )) || true
fi

report_results
