#!/usr/bin/env bash
set -euo pipefail

# Clone the private dotfiles repository into a temporary worktree first
repo_url="${DOTFILES_REPO_URL:-git@github.com:Ra77a3l3-jar/.dotfiles.git}"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"

if ! command -v git >/dev/null 2>&1; then
    printf 'Git is required to clone %s\n' "$repo_url" >&2
    exit 1
fi

if [[ "$config_dir" != /* ]]; then
    printf 'XDG_CONFIG_HOME must be an absolute path: %s\n' "$config_dir" >&2
    exit 1
fi

# A second run leaves an existing checkout and the rest of ~/.config alone
if [[ -e "$config_dir/.git" || -L "$config_dir/.git" ]]; then
    current_remote="$(git -C "$config_dir" remote get-url origin 2>/dev/null || true)"
    if [[ "$current_remote" != "$repo_url" ]]; then
        printf '%s is already a Git repository with a different origin: %s\n' "$config_dir" "$current_remote" >&2
        exit 1
    fi

    printf 'Dotfiles are already installed in %s\n' "$config_dir"
    exit 0
fi

staging_dir="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles.XXXXXXXX")"
trap 'rm -rf -- "$staging_dir"' EXIT

git clone --no-checkout "$repo_url" "$staging_dir/repo"
mapfile -d '' -t managed_paths < <(git -C "$staging_dir/repo" ls-tree -z --name-only HEAD)

# Refuse to replace an existing Hyprland, Quickshell, or other tracked path
conflicts=()
for path in "${managed_paths[@]}"; do
    if [[ -e "$config_dir/$path" || -L "$config_dir/$path" ]]; then
        conflicts+=("$path")
    fi
done

if (("${#conflicts[@]}" > 0)); then
    printf 'Cannot install dotfiles: these paths already exist in %s:\n' "$config_dir" >&2
    printf '  %s\n' "${conflicts[@]}" >&2
    printf 'Move or merge those paths yourself, then rerun this script\n' >&2
    exit 1
fi

mkdir -p "$config_dir"
if [[ -e "$config_dir/.git" || -L "$config_dir/.git" ]]; then
    printf '%s/.git appeared while cloning; no files were installed\n' "$config_dir" >&2
    exit 1
fi

# Move only Git metadata, then check out the tracked files in ~/.config
mv -- "$staging_dir/repo/.git" "$config_dir/.git"
git -C "$config_dir" restore --source=HEAD --staged --worktree -- .

# Keep unrelated configuration out of status without committing a .gitignore
{
    printf '\n# Local exclusions for the dotfiles checkout\n/*\n'
    for path in "${managed_paths[@]}"; do
        if [[ -d "$config_dir/$path" ]]; then
            printf '!/%s/\n' "$path"
        else
            printf '!/%s\n' "$path"
        fi
    done
    printf '**/AGENTS.md\n**/.qmlls.ini\n'
} >> "$config_dir/.git/info/exclude"

printf 'Dotfiles installed in %s\n' "$config_dir"
