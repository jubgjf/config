#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/helpers.sh"
INSTALL="${CONFIG_HOME}/install.sh"

echo "=== test_status ==="

# Test 1: Status with nothing activated
echo "  [1] Status with nothing activated"
status_output="$(bash "$INSTALL" --status 2>&1)"
assert_output_contains "$status_output" "╔" "should have top border"
assert_output_contains "$status_output" "╚" "should have bottom border"
assert_output_contains "$status_output" "alacritty" "should list alacritty"
assert_output_contains "$status_output" "zsh" "should list zsh"

# No entry should be checked
source "${CONFIG_HOME}/config.sh"
for entry in "${CONFIG_ENTRIES[@]}"; do
  if echo "$status_output" | grep -q "✓ $entry"; then
    echo "FAIL: $entry should not be activated"
    (( FAIL_COUNT++ )) || true
  else
    (( PASS_COUNT++ )) || true
  fi
done

# Test 2: Status after activating some entries
echo "  [2] Status after partial activation"
bash "$INSTALL" --activate fish zsh --force 2>&1 >/dev/null
status_output="$(bash "$INSTALL" --status 2>&1)"
assert_output_contains "$status_output" "✓ fish" "fish should be activated"
assert_output_contains "$status_output" "✓ zsh" "zsh should be activated"

# Test 3: Diff mode -- activate shows +
echo "  [3] Diff mode shows + for newly activated"
diff_output="$(bash "$INSTALL" --activate lsd --force 2>&1)"
assert_output_contains "$diff_output" "+ lsd" "should show + for lsd"
assert_output_contains "$diff_output" "✓ fish" "fish should still be ✓"

# Test 4: Diff mode -- deactivate shows -
echo "  [4] Diff mode shows - for deactivated"
diff_output="$(bash "$INSTALL" --deactivate fish --force 2>&1)"
assert_output_contains "$diff_output" "- fish" "should show - for fish"

report_results
