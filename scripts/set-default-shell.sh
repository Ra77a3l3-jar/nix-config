#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: set-default-shell.sh [--dry-run] <shell-name|/absolute/path>

Set your login shell, registering it in /etc/shells with sudo if needed.
The shell must already be installed. Log out and back in after changing it.

Examples:
  ./scripts/set-default-shell.sh nu
  ./scripts/set-default-shell.sh fish
  ./scripts/set-default-shell.sh --dry-run bash
  ./scripts/set-default-shell.sh /usr/bin/zsh
EOF
}

fail() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

dry_run=false
requested_shell=''
for argument in "$@"; do
  case "$argument" in
    -h|--help) usage; exit 0 ;;
    --dry-run) dry_run=true ;;
    -*) fail "Unknown option: $argument" ;;
    *)
      [[ -z "$requested_shell" ]] || fail 'Specify exactly one shell.'
      requested_shell="$argument"
      ;;
  esac
done

if [[ -z "$requested_shell" ]]; then
  usage >&2
  exit 1
fi

username="$(id -un)"
shell_path=''
case "$requested_shell" in
  /*) shell_path="$requested_shell" ;;
  */*) fail 'Use a shell name or an absolute path.' ;;
  *)
    # Keep profile symlinks intact so Nix upgrades do not leave a stale store path.
    for profile in \
      "$HOME/.nix-profile" \
      "${XDG_STATE_HOME:-$HOME/.local/state}/nix/profile" \
      "/etc/profiles/per-user/$username" \
      /run/current-system/sw; do
      if [[ -f "$profile/bin/$requested_shell" && -x "$profile/bin/$requested_shell" ]]; then
        shell_path="$profile/bin/$requested_shell"
        break
      fi
    done
    if [[ -z "$shell_path" ]]; then
      shell_path="$(type -P -- "$requested_shell")" || fail "Shell '$requested_shell' is not installed."
    fi
    ;;
esac

[[ "$shell_path" = /* ]] || shell_path="$PWD/$shell_path"
[[ "$shell_path" != *:* && "$shell_path" != *$'\n'* ]] || fail 'Invalid shell path.'
[[ -f "$shell_path" && -x "$shell_path" ]] || fail "Shell is not executable: $shell_path"
command -v chsh >/dev/null || fail 'chsh is required. On NixOS, set users.users.<name>.shell in your system configuration.'
account="$(getent passwd "$username")" || fail "Cannot find account '$username'."
current_shell="${account##*:}"

if ! grep -Fxq -- "$shell_path" /etc/shells; then
  printf 'Registering %s in /etc/shells (requires sudo).\n' "$shell_path"
  if ! "$dry_run"; then
    printf '%s\n' "$shell_path" | sudo tee -a /etc/shells >/dev/null
  fi
fi

if [[ "$current_shell" = "$shell_path" ]]; then
  printf 'Your default shell is already %s.\n' "$shell_path"
else
  printf 'Changing default shell for %s: %s -> %s\n' "$username" "$current_shell" "$shell_path"
  if ! "$dry_run"; then
    chsh -s "$shell_path" "$username"
    printf 'Log out and back in to use your new default shell.\n'
  fi
fi
