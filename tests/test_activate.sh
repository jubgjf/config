#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/helpers.sh"
INSTALL="${CONFIG_HOME}/install.sh"

echo "=== test_activate ==="

# Test 1: Activate a simple entry
echo "  [1] Activate a simple entry (zsh)"
bash "$INSTALL" --activate zsh --force 2>&1 >/dev/null
assert_symlink "$HOME/.zshrc" "zshrc should be a symlink"
assert_symlink_target "$HOME/.zshrc" "$CONFIG_HOME/zsh/zshrc" "zshrc should point to config"

# Test 2: Idempotency -- activate again should not error
echo "  [2] Activate again (idempotency)"
output="$(bash "$INSTALL" --activate zsh --force 2>&1)"
ec=$?
assert_exit_code "$ec" 0 "idempotent activate should succeed"

# Test 3: Activate entry with host-specific override (ideavim)
echo "  [3] Activate entry with host-specific (ideavim)"
bash "$INSTALL" --activate ideavim --force 2>&1 >/dev/null
assert_symlink "${XDG_CONFIG_HOME}/ideavim" "ideavim should be a symlink"

# Test 4: Activate all entries
echo "  [4] Activate all entries"
source "${CONFIG_HOME}/config.sh"
all_args=""
for entry in "${CONFIG_ENTRIES[@]}"; do
  all_args+="$entry "
done
bash "$INSTALL" --activate $all_args --force 2>&1 >/dev/null

# Verify all are activated via --status
status_output="$(bash "$INSTALL" --status 2>&1)"
for entry in "${CONFIG_ENTRIES[@]}"; do
  assert_output_contains "$status_output" "✓ $entry" "all entries should be activated: $entry"
done

report_results
