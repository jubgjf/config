#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

GREEN='\033[92m'
RED='\033[91m'
YELLOW='\033[93m'
ENDC='\033[0m'

PASS=0
FAIL=0
SANDBOX_TYPE="none"

detect_sandbox() {
  local platform
  platform="$(uname -s)"
  if [[ "$platform" == "Darwin" ]] && command -v sandbox-exec &>/dev/null; then
    SANDBOX_TYPE="seatbelt"
  elif [[ "$platform" == "Linux" ]] && command -v bwrap &>/dev/null; then
    SANDBOX_TYPE="bwrap"
  else
    SANDBOX_TYPE="redirect"
  fi
  printf "${YELLOW}Sandbox: %s${ENDC}\n" "$SANDBOX_TYPE"
}

setup_sandbox() {
  TEST_HOME="$(mktemp -d)"
  mkdir -p "$TEST_HOME/code"
  cp -R "$REPO_DIR" "$TEST_HOME/code/config"
  export TEST_HOME
}

teardown_sandbox() {
  rm -rf "$TEST_HOME"
}

run_in_sandbox() {
  local test_file="$1"
  local exit_code=0

  case "$SANDBOX_TYPE" in
    seatbelt)
      sandbox-exec -f "$SCRIPT_DIR/sandbox_macos.sb" \
        -D TEST_HOME="$TEST_HOME" \
        env HOME="$TEST_HOME" \
            CONFIG_HOME="$TEST_HOME/code/config" \
            XDG_CONFIG_HOME="$TEST_HOME/.config" \
        bash "$test_file" || exit_code=$?
      ;;
    bwrap)
      bwrap \
        --ro-bind / / \
        --bind "$TEST_HOME" "$TEST_HOME" \
        --dev /dev \
        --proc /proc \
        --tmpfs /tmp \
        --setenv HOME "$TEST_HOME" \
        --setenv CONFIG_HOME "$TEST_HOME/code/config" \
        --setenv XDG_CONFIG_HOME "$TEST_HOME/.config" \
        bash "$test_file" || exit_code=$?
      ;;
    redirect)
      env HOME="$TEST_HOME" \
          CONFIG_HOME="$TEST_HOME/code/config" \
          XDG_CONFIG_HOME="$TEST_HOME/.config" \
        bash "$test_file" || exit_code=$?
      ;;
  esac

  return $exit_code
}

run_test() {
  local test_file="$1"
  local name
  name="$(basename "$test_file")"

  setup_sandbox

  local exit_code=0
  run_in_sandbox "$test_file" || exit_code=$?

  if [[ $exit_code -eq 0 ]]; then
    printf "  ${GREEN}PASS${ENDC} %s\n" "$name"
    (( PASS++ )) || true
  else
    printf "  ${RED}FAIL${ENDC} %s\n" "$name"
    (( FAIL++ )) || true
  fi

  teardown_sandbox
}

# ── Main ───────────────────────────────────────────────────

echo "Running tests..."
detect_sandbox
echo ""

for test_file in "$SCRIPT_DIR"/test_*.sh; do
  run_test "$test_file"
done

echo ""
printf "Results: ${GREEN}%d passed${ENDC}, ${RED}%d failed${ENDC}\n" "$PASS" "$FAIL"

if [[ $FAIL -gt 0 ]]; then
  exit 1
fi
