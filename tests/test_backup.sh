#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/helpers.sh"
INSTALL="${CONFIG_HOME}/install.sh"

echo "=== test_backup ==="

# Test 1: Backup a regular file on activate
echo "  [1] Backup regular file on activate"
mkdir -p "$(dirname "$HOME/.zshrc")"
echo "old content" > "$HOME/.zshrc"
bash "$INSTALL" --activate zsh --force 2>&1 >/dev/null
assert_file_exists "$HOME/.zshrc.bak" "original should be backed up to .bak"
assert_symlink "$HOME/.zshrc" "target should now be a symlink"
# Cleanup
bash "$INSTALL" --deactivate zsh --force 2>&1 >/dev/null
rm -f "$HOME/.zshrc.bak"

# Test 2: Timestamped backup when .bak already exists
echo "  [2] Timestamped backup when .bak exists"
echo "old content" > "$HOME/.zshrc"
echo "even older" > "$HOME/.zshrc.bak"
bash "$INSTALL" --activate zsh --force 2>&1 >/dev/null
assert_file_exists "$HOME/.zshrc.bak" "original .bak should still exist"
# There should be a .bak.YYYYMMDD-HHMMSS file
bak_files=($(ls "$HOME"/.zshrc.bak.* 2>/dev/null || true))
if [[ ${#bak_files[@]} -gt 0 ]]; then
  (( PASS_COUNT++ )) || true
else
  echo "FAIL: timestamped .bak file not found"
  (( FAIL_COUNT++ )) || true
fi
# Cleanup
bash "$INSTALL" --deactivate zsh --force 2>&1 >/dev/null
rm -f "$HOME"/.zshrc.bak*

# Test 3: Backup a directory on activate
echo "  [3] Backup directory on activate"
mkdir -p "${XDG_CONFIG_HOME}/fish"
echo "dummy" > "${XDG_CONFIG_HOME}/fish/dummy.txt"
bash "$INSTALL" --activate fish --force 2>&1 >/dev/null
assert_file_exists "${XDG_CONFIG_HOME}/fish.bak" "directory should be backed up"
assert_symlink "${XDG_CONFIG_HOME}/fish" "fish should now be a symlink"
# Cleanup
bash "$INSTALL" --deactivate fish --force 2>&1 >/dev/null
rm -rf "${XDG_CONFIG_HOME}/fish.bak"

# Test 4: Conflict detection -- git
echo "  [4] Conflict detection for git"
echo "old gitconfig" > "$HOME/.gitconfig"
output="$(bash "$INSTALL" --activate git --force 2>&1)"
assert_output_contains "$output" "Conflicting config found" "should warn about conflict"
assert_file_exists "$HOME/.gitconfig.bak" "conflicting file should be backed up"
# Cleanup
bash "$INSTALL" --deactivate git --force 2>&1 >/dev/null
rm -f "$HOME/.gitconfig" "$HOME/.gitconfig.bak"

# Test 5: No backup when already correct symlink
echo "  [5] No backup when already correct symlink"
bash "$INSTALL" --activate zsh --force 2>&1 >/dev/null
# Activate again -- should not create .bak
bash "$INSTALL" --activate zsh --force 2>&1 >/dev/null
if [[ -e "$HOME/.zshrc.bak" ]]; then
  echo "FAIL: .bak should not be created for correct symlink"
  (( FAIL_COUNT++ )) || true
else
  (( PASS_COUNT++ )) || true
fi
# Cleanup
bash "$INSTALL" --deactivate zsh --force 2>&1 >/dev/null

report_results
