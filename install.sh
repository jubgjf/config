#!/usr/bin/env bash
set -euo pipefail

# ── Colors ─────────────────────────────────────────────────
GREEN='\033[92m'
RED='\033[91m'
YELLOW='\033[93m'
ENDC='\033[0m'

# ── Globals ────────────────────────────────────────────────
VERBOSE=0
FORCE=0
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_HOME="${CONFIG_HOME:-$HOME/code/config}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
CURRENT_HOSTNAME="$(uname -n)"

# ── Source config ──────────────────────────────────────────
source "${SCRIPT_DIR}/config.sh"
source "${SCRIPT_DIR}/conflicts.sh"

# ── Utilities ──────────────────────────────────────────────

log_debug() {
  if [[ $VERBOSE -eq 1 ]]; then
    echo "[DEBUG] $*" >&2
  fi
}

log_warn() {
  printf "${YELLOW}WARNING: %s${ENDC}\n" "$*" >&2
}

log_error() {
  printf "${RED}ERROR: %s${ENDC}\n" "$*" >&2
}

sanitize_name() {
  echo "$1" | tr '[:lower:]' '[:upper:]' | tr '.-' '__'
}

cfg_get() {
  local entry="$1" field="$2"
  local sname
  sname="$(sanitize_name "$entry")"
  local varname="CFG_${sname}_${field}"
  local raw="${!varname:-}"
  if [[ -z "$raw" ]]; then
    echo ""
    return
  fi
  eval echo "$raw"
}

cfg_get_hosts() {
  local entry="$1"
  local sname
  sname="$(sanitize_name "$entry")"
  local varname="CFG_${sname}_HOSTS"
  echo "${!varname:-}"
}

cfg_get_host_field() {
  local entry="$1" hostname_key="$2" field="$3"
  local sname
  sname="$(sanitize_name "$entry")"
  local hname
  hname="$(sanitize_name "$hostname_key")"
  local varname="CFG_${sname}_HOST_${hname}_${field}"
  echo "${!varname:-}"
}

resolve_symlink() {
  local path="$1"
  if command -v realpath &>/dev/null; then
    realpath "$path"
  elif readlink -f "$path" &>/dev/null; then
    readlink -f "$path"
  else
    # manual fallback for old macOS
    local dir file
    dir="$(cd "$(dirname "$path")" && pwd)"
    file="$(basename "$path")"
    while [[ -L "$dir/$file" ]]; do
      local target
      target="$(readlink "$dir/$file")"
      if [[ "$target" = /* ]]; then
        dir="$(cd "$(dirname "$target")" && pwd)"
        file="$(basename "$target")"
      else
        dir="$(cd "$dir" && cd "$(dirname "$target")" && pwd)"
        file="$(basename "$target")"
      fi
    done
    echo "$dir/$file"
  fi
}

confirm() {
  local prompt="$1"
  if [[ $FORCE -eq 1 ]]; then
    return 0
  fi
  printf "%s [y/N] " "$prompt"
  local answer
  read -r answer
  case "$answer" in
    [yY]|[yY][eE][sS]) return 0 ;;
    *) return 1 ;;
  esac
}

# ── Backup ─────────────────────────────────────────────────

backup_target() {
  local target="$1"
  if [[ ! -e "$target" ]] && [[ ! -L "$target" ]]; then
    return 0
  fi

  local backup="${target}.bak"
  if [[ -e "$backup" ]] || [[ -L "$backup" ]]; then
    backup="${target}.bak.$(date +%Y%m%d-%H%M%S)"
  fi

  mv "$target" "$backup"
  echo "Backed up: $target -> $backup"
}

# ── Conflict Detection ─────────────────────────────────────

check_conflicts() {
  local entry="$1"
  local sname
  sname="$(sanitize_name "$entry")"
  local varname="CONFLICT_${sname}_PATHS"

  # Check if the array variable is defined
  if ! declare -p "$varname" &>/dev/null; then
    return 0
  fi

  # Skip pip macOS-only conflicts on non-Darwin
  if [[ "$entry" == "pip" ]] && [[ "$(uname -s)" != "Darwin" ]]; then
    return 0
  fi

  local tgt
  tgt="$(cfg_get "$entry" TGT)"

  # Read array via nameref workaround for bash 3.2+
  local conflict_path expanded
  eval "local paths=(\"\${${varname}[@]}\")"
  for conflict_path in "${paths[@]}"; do
    expanded="$(eval echo "$conflict_path")"
    if [[ -e "$expanded" ]] || [[ -L "$expanded" ]]; then
      log_warn "Conflicting config found: $expanded"
      log_warn "  This may override or conflict with: $tgt"
      if confirm "  Back up $expanded to ${expanded}.bak?"; then
        backup_target "$expanded"
      else
        log_warn "  Skipped backing up $expanded"
      fi
    fi
  done
}

# ── Core Functions ─────────────────────────────────────────

selected_hostname_for() {
  local entry="$1"
  local hosts
  hosts="$(cfg_get_hosts "$entry")"
  if [[ -z "$hosts" ]]; then
    echo ""
    return
  fi

  local h
  for h in $hosts; do
    if [[ "$h" == "$CURRENT_HOSTNAME" ]]; then
      echo "$h"
      return
    fi
  done

  for h in $hosts; do
    if [[ "$h" == "OTHERS" ]]; then
      echo "OTHERS"
      return
    fi
  done

  echo ""
}

is_activated() {
  local entry="$1"
  local src tgt
  src="$(cfg_get "$entry" SRC)"
  tgt="$(cfg_get "$entry" TGT)"

  if [[ -z "$src" ]] || [[ -z "$tgt" ]]; then
    log_debug "$entry: missing src or tgt"
    return 1
  fi

  # Check primary symlink
  if [[ ! -e "$tgt" ]] && [[ ! -L "$tgt" ]]; then
    log_debug "$entry: target not found: $tgt"
    return 1
  fi
  if [[ ! -L "$tgt" ]]; then
    log_debug "$entry: not a symlink: $tgt"
    return 1
  fi

  local resolved
  resolved="$(resolve_symlink "$tgt")"
  local src_resolved
  src_resolved="$(resolve_symlink "$src")"
  if [[ "$resolved" != "$src_resolved" ]]; then
    log_debug "$entry: symlink target mismatch: $tgt -> $resolved != $src_resolved"
    return 1
  fi

  # Check host-specific
  local hosts
  hosts="$(cfg_get_hosts "$entry")"
  if [[ -z "$hosts" ]]; then
    return 0
  fi

  local sel
  sel="$(selected_hostname_for "$entry")"
  if [[ -z "$sel" ]]; then
    log_debug "$entry: no matching host-specific config for $CURRENT_HOSTNAME"
    return 0
  fi

  local host_src host_tgt
  host_src="$(cfg_get_host_field "$entry" "$sel" SRC)"
  host_tgt="$(cfg_get_host_field "$entry" "$sel" TGT)"

  local full_src_host="$src/$host_src"
  local full_tgt_host="$src/$host_tgt"

  if [[ ! -L "$full_tgt_host" ]]; then
    log_debug "$entry: host-specific symlink missing: $full_tgt_host"
    return 1
  fi

  local resolved_host
  resolved_host="$(resolve_symlink "$full_tgt_host")"
  local resolved_src_host
  resolved_src_host="$(resolve_symlink "$full_src_host")"
  if [[ "$resolved_host" != "$resolved_src_host" ]]; then
    log_debug "$entry: host-specific symlink mismatch: $full_tgt_host -> $resolved_host != $resolved_src_host"
    return 1
  fi

  return 0
}

do_activate() {
  local entry="$1"

  if is_activated "$entry"; then
    log_debug "$entry: already activated"
    return 0
  fi

  check_conflicts "$entry"

  local src tgt
  src="$(cfg_get "$entry" SRC)"
  tgt="$(cfg_get "$entry" TGT)"

  # Handle existing target
  if [[ -e "$tgt" ]] || [[ -L "$tgt" ]]; then
    local resolved
    if [[ -L "$tgt" ]]; then
      resolved="$(readlink "$tgt")"
      log_warn "Target already exists: $tgt -> $resolved"
    elif [[ -d "$tgt" ]]; then
      local count
      count="$(find "$tgt" -maxdepth 1 | wc -l | tr -d ' ')"
      log_warn "Target already exists: $tgt (directory, $count items)"
    else
      log_warn "Target already exists: $tgt (file)"
    fi

    if confirm "Back up and overwrite $tgt?"; then
      backup_target "$tgt"
    else
      echo "Skipped $entry"
      return 1
    fi
  fi

  # Create parent directory
  mkdir -p "$(dirname "$tgt")"

  # Create primary symlink
  ln -s "$src" "$tgt"
  log_debug "$entry: created symlink $tgt -> $src"

  # Host-specific override
  local sel
  sel="$(selected_hostname_for "$entry")"
  if [[ -n "$sel" ]]; then
    local host_src host_tgt
    host_src="$(cfg_get_host_field "$entry" "$sel" SRC)"
    host_tgt="$(cfg_get_host_field "$entry" "$sel" TGT)"

    local full_src_host="$src/$host_src"
    local full_tgt_host="$src/$host_tgt"

    if [[ -e "$full_tgt_host" ]] || [[ -L "$full_tgt_host" ]]; then
      backup_target "$full_tgt_host"
    fi

    ln -s "$full_src_host" "$full_tgt_host"
    log_debug "$entry: created host-specific symlink $full_tgt_host -> $full_src_host"
  fi

  if is_activated "$entry"; then
    return 0
  else
    log_error "Failed to activate $entry"
    return 1
  fi
}

do_deactivate() {
  local entry="$1"

  if ! is_activated "$entry"; then
    log_debug "$entry: already deactivated"
    return 0
  fi

  local tgt
  tgt="$(cfg_get "$entry" TGT)"

  rm "$tgt"
  log_debug "$entry: removed symlink $tgt"

  if is_activated "$entry"; then
    log_error "Failed to deactivate $entry"
    return 1
  fi
  return 0
}

# ── Status Display ─────────────────────────────────────────

# Status arrays: indexed parallel to CONFIG_ENTRIES, values "1" or "0"
declare -a OLD_STATUS=()
declare -a NEW_STATUS=()

capture_status() {
  local varname="$1"
  eval "$varname=()"
  local entry
  for entry in "${CONFIG_ENTRIES[@]}"; do
    if is_activated "$entry"; then
      eval "$varname+=(\"1\")"
    else
      eval "$varname+=(\"0\")"
    fi
  done
}

show_status() {
  local diff_mode="${1:-}"

  # Find max name length
  local max_len=0
  local entry
  for entry in "${CONFIG_ENTRIES[@]}"; do
    if [[ ${#entry} -gt $max_len ]]; then
      max_len=${#entry}
    fi
  done

  local border_len=$(( 4 + max_len + 2 ))
  local border=""
  local i
  for (( i = 0; i < border_len; i++ )); do
    border+="═"
  done

  echo "╔${border}╗"

  local idx=0
  for entry in "${CONFIG_ENTRIES[@]}"; do
    local mark="" color="" endc=""
    local pad_len=$(( border_len - 5 - ${#entry} ))
    local padding=""
    for (( i = 0; i < pad_len; i++ )); do
      padding+=" "
    done

    if [[ "$diff_mode" == "diff" ]]; then
      local old_val="${OLD_STATUS[$idx]}"
      local new_val="${NEW_STATUS[$idx]}"
      if [[ "$old_val" == "1" ]] && [[ "$new_val" == "1" ]]; then
        mark="✓"
      elif [[ "$old_val" == "1" ]] && [[ "$new_val" == "0" ]]; then
        mark="-"
        color="$RED"
        endc="$ENDC"
      elif [[ "$old_val" == "0" ]] && [[ "$new_val" == "1" ]]; then
        mark="+"
        color="$GREEN"
        endc="$ENDC"
      else
        mark=" "
      fi
    else
      if is_activated "$entry"; then
        mark="✓"
      else
        mark=" "
      fi
    fi

    printf "║ %b%s %s %s%b ║\n" "$color" "$mark" "$entry" "$padding" "$endc"
    (( idx++ )) || true
  done

  echo "╚${border}╝"
}

# ── Argument Parsing ───────────────────────────────────────

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  --status                Show configuration status
  --activate NAME...      Activate one or more configurations
  --deactivate NAME...    Deactivate one or more configurations
  --verbose               Enable debug logging
  --force                 Skip confirmation prompts (auto-backup)
  --help                  Show this help message

Available configurations:
  $(printf '%s ' "${CONFIG_ENTRIES[@]}")
EOF
}

validate_entry() {
  local name="$1"
  local entry
  for entry in "${CONFIG_ENTRIES[@]}"; do
    if [[ "$entry" == "$name" ]]; then
      return 0
    fi
  done
  log_error "Unknown configuration: $name"
  log_error "Available: ${CONFIG_ENTRIES[*]}"
  return 1
}

# ── Main ───────────────────────────────────────────────────

main() {
  local do_status=0
  local -a activate_targets=()
  local -a deactivate_targets=()

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --status)
        do_status=1
        shift
        ;;
      --activate)
        shift
        while [[ $# -gt 0 ]] && [[ "$1" != --* ]]; do
          validate_entry "$1"
          activate_targets+=("$1")
          shift
        done
        ;;
      --deactivate)
        shift
        while [[ $# -gt 0 ]] && [[ "$1" != --* ]]; do
          validate_entry "$1"
          deactivate_targets+=("$1")
          shift
        done
        ;;
      --verbose)
        VERBOSE=1
        shift
        ;;
      --force)
        FORCE=1
        shift
        ;;
      --help|-h)
        usage
        exit 0
        ;;
      *)
        log_error "Unknown option: $1"
        usage
        exit 1
        ;;
    esac
  done

  # Validate: --status is exclusive
  if [[ $do_status -eq 1 ]] && [[ ${#activate_targets[@]} -gt 0 || ${#deactivate_targets[@]} -gt 0 ]]; then
    log_error "Cannot use --status with --activate or --deactivate"
    exit 1
  fi

  # Validate: no overlap between activate and deactivate
  local a d
  for a in "${activate_targets[@]+"${activate_targets[@]}"}"; do
    for d in "${deactivate_targets[@]+"${deactivate_targets[@]}"}"; do
      if [[ "$a" == "$d" ]]; then
        log_error "Cannot both activate and deactivate: $a"
        exit 1
      fi
    done
  done

  # Status mode
  if [[ $do_status -eq 1 ]]; then
    show_status
    exit 0
  fi

  # No action specified
  if [[ ${#activate_targets[@]} -eq 0 ]] && [[ ${#deactivate_targets[@]} -eq 0 ]]; then
    usage
    exit 0
  fi

  # Capture old status
  capture_status OLD_STATUS

  # Activate
  for a in "${activate_targets[@]+"${activate_targets[@]}"}"; do
    if do_activate "$a"; then
      echo "Activated $a"
    else
      echo "Failed to activate $a"
    fi
  done

  # Deactivate
  for d in "${deactivate_targets[@]+"${deactivate_targets[@]}"}"; do
    if do_deactivate "$d"; then
      echo "Deactivated $d"
    else
      echo "Failed to deactivate $d"
    fi
  done

  # Capture new status and show diff
  capture_status NEW_STATUS
  show_status diff
}

main "$@"
