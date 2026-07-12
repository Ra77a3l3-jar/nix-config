#!/usr/bin/env bash
set -euo pipefail

FISH="$HOME/.nix-profile/bin/fish"

if [ ! -x "$FISH" ]; then
  echo "$FISH not found, check if isntalled"
  exit 1
fi

if ! grep -qx "$FISH" /etc/shells; then
  echo "adding $FISH to /etc/shells (needs sudo)"
  echo "$FISH" | sudo tee -a /etc/shells > /dev/null
else
  echo "$FISH already in /etc/shells"
fi

current=$(getent passwd "$USER" | cut -d: -f7)
if [ "$current" != "$FISH" ]; then
  echo "changing login shell from $current to $FISH"
  chsh -s "$FISH"
else
  echo "shell is already fish"
fi

if [ "${SHELL:-}" != "$FISH" ]; then
  echo "shell set"
fi
