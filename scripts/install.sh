#!/usr/bin/env bash
set -euo pipefail

REPO_URL="git@github.com:Ra77a3l3-jar/nix-config.git"
REPO_DIR="$HOME/.config/nix-config"
HOSTNAME="$(hostname -s)"

echo "Installing prerequisites..."
sudo dnf install -y fish kitty gnome-tweaks \
    https://github.com/wezterm/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203_110809_5046fc22-1.fedora39.x86_64.rpm

FISH="$(command -v fish)"
if [ "$SHELL" != "$FISH" ]; then
    echo "Setting fish as default shell..."
    chsh -s "$FISH"
fi

echo "Installing Nix..."
if ! command -v nix >/dev/null 2>&1; then
    sudo dnf install -y nix
    sudo systemctl enable --now nix-daemon.service
    sudo usermod -aG nix-users "$USER"
fi

mkdir -p "$HOME/.config/nix"
if ! grep -q "experimental-features = nix-command flakes" "$HOME/.config/nix/nix.conf" 2>/dev/null; then
    echo "experimental-features = nix-command flakes" >> "$HOME/.config/nix/nix.conf"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/setup_git.sh"

if [ ! -d "$REPO_DIR/.git" ]; then
    echo "Cloning repository..."
    mkdir -p "$HOME/.config"
    git clone "$REPO_URL" "$REPO_DIR"
fi

echo "Installing Home Manager"
echo "nix run home-manager/release-25.11 -- init --switch --flake ~/.config/nix-config#raffaele@legion"

echo "Done. Log out and back in if this was the first run."
