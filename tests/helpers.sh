#!/usr/bin/env bash
# helpers.sh -- Shared test assertion utilities

PASS_COUNT=0
FAIL_COUNT=0

assert_eq() {
  local actual="$1" expected="$2" msg="${3:-}"
  if [[ "$actual" == "$expected" ]]; then
    (( PASS_COUNT++ )) || true
    return 0
  fi
  echo "FAIL: ${msg:+$msg: }expected '$expected', got '$actual'"
  (( FAIL_COUNT++ )) || true
  return 1
}

assert_symlink() {
  local path="$1" msg="${2:-$path should be a symlink}"
  if [[ -L "$path" ]]; then
    (( PASS_COUNT++ )) || true
    return 0
  fi
  echo "FAIL: $msg"
  (( FAIL_COUNT++ )) || true
  return 1
}

assert_symlink_target() {
  local link="$1" expected_target="$2" msg="${3:-}"
  if [[ ! -L "$link" ]]; then
    echo "FAIL: ${msg:+$msg: }$link is not a symlink"
    (( FAIL_COUNT++ )) || true
    return 1
  fi

  local actual expected
  if command -v realpath &>/dev/null; then
    actual="$(realpath "$link")"
    expected="$(realpath "$expected_target")"
  else
    actual="$(readlink -f "$link" 2>/dev/null || readlink "$link")"
    expected="$(readlink -f "$expected_target" 2>/dev/null || echo "$expected_target")"
  fi

  if [[ "$actual" == "$expected" ]]; then
    (( PASS_COUNT++ )) || true
    return 0
  fi
  echo "FAIL: ${msg:+$msg: }$link -> $actual, expected -> $expected"
  (( FAIL_COUNT++ )) || true
  return 1
}

assert_file_exists() {
  local path="$1" msg="${2:-$path should exist}"
  if [[ -e "$path" ]]; then
    (( PASS_COUNT++ )) || true
    return 0
  fi
  echo "FAIL: $msg"
  (( FAIL_COUNT++ )) || true
  return 1
}

assert_not_exists() {
  local path="$1" msg="${2:-$path should not exist}"
  if [[ ! -e "$path" ]] && [[ ! -L "$path" ]]; then
    (( PASS_COUNT++ )) || true
    return 0
  fi
  echo "FAIL: $msg"
  (( FAIL_COUNT++ )) || true
  return 1
}

assert_output_contains() {
  local output="$1" expected="$2" msg="${3:-}"
  if echo "$output" | grep -qF -- "$expected"; then
    (( PASS_COUNT++ )) || true
    return 0
  fi
  echo "FAIL: ${msg:+$msg: }output missing '$expected'"
  (( FAIL_COUNT++ )) || true
  return 1
}

assert_exit_code() {
  local actual="$1" expected="$2" msg="${3:-}"
  if [[ "$actual" -eq "$expected" ]]; then
    (( PASS_COUNT++ )) || true
    return 0
  fi
  echo "FAIL: ${msg:+$msg: }exit code $actual, expected $expected"
  (( FAIL_COUNT++ )) || true
  return 1
}

report_results() {
  echo "  Assertions: $PASS_COUNT passed, $FAIL_COUNT failed"
  return $FAIL_COUNT
}
