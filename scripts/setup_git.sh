#!/usr/bin/env bash
set -euo pipefail

SSH_KEY="$HOME/.ssh/id_ed25519"

if [ -z "$(git config --global user.name 2>/dev/null || true)" ]; then
    read -rp "Git user name [Ra77a3l3-jar]: " name
    name="${name:-Ra77a3l3-jar}"
    git config --global user.name "$name"
fi

if [ -z "$(git config --global user.email 2>/dev/null || true)" ]; then
    read -rp "Git email [raffaelemeo77@gmail.com]: " email
    email="${email:-raffaelemeo77@gmail.com}"
    git config --global user.email "$email"
fi

if [ ! -f "$SSH_KEY" ]; then
    echo "Generating SSH key..."
    mkdir -p "$HOME/.ssh"
    ssh-keygen -t ed25519 -C "$(git config --global user.email)"
fi

eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY"

echo "Public key:"
cat "$SSH_KEY.pub"
echo "Add it to GitHub: https://github.com/settings/ssh/new"
read -rp "Press Enter when done..."

ssh -T git@github.com || true
