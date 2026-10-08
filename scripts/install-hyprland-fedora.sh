#!/usr/bin/env bash
set -euo pipefail

# Register the Home Manager Hyprland package as a Fedora GDM session
if [[ ! -r /etc/os-release ]]; then
    printf 'Cannot identify this operating system\n' >&2
    exit 1
fi

# shellcheck source=/dev/null
source /etc/os-release
if [[ "${ID:-}" != "fedora" ]]; then
    printf 'This installer is for Fedora; detected %s\n' "${ID:-unknown}" >&2
    exit 1
fi

if [[ "$(id -u)" -eq 0 ]]; then
    printf 'Run this script as your regular user; it will call sudo for the GDM files\n' >&2
    exit 1
fi

if [[ ! -x "$HOME/.nix-profile/bin/start-hyprland" ]]; then
    printf 'Apply the Legion Home Manager configuration first, then rerun this script\n' >&2
    exit 1
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sudo install -Dm755 "$script_dir/hyprland-nix-session" /usr/local/bin/hyprland-nix-session
sudo install -Dm644 "$script_dir/hyprland-nix.desktop" /usr/share/wayland-sessions/hyprland-nix.desktop

# Retire only the Fedora session packages; keep the COPR and unrelated apps
legacy_packages=()
for package in hyprland hyprland-guiutils xdg-desktop-portal-hyprland hyprland-uwsm hyprlauncher; do
    if rpm -q "$package" >/dev/null 2>&1; then
        legacy_packages+=("$package")
    fi
done

if (( ${#legacy_packages[@]} > 0 )); then
    sudo dnf remove --no-autoremove "${legacy_packages[@]}"
fi

printf 'Hyprland (Nix) is available at the GDM login screen\n'
