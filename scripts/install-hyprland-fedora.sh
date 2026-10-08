#!/usr/bin/env bash
set -euo pipefail

# Install the Fedora Hyprland session and its companion utilities
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
    printf 'Run this script as your regular user; it will call sudo for DNF\n' >&2
    exit 1
fi

if ! command -v dnf >/dev/null 2>&1; then
    printf 'DNF is required on Fedora\n' >&2
    exit 1
fi

sudo dnf install hyprland hyprland-guiutils xdg-desktop-portal-hyprland

printf 'Hyprland is installed. Select the Hyprland session at the login screen\n'
