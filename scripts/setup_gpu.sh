#!/usr/bin/env bash
# Sets up the GPU drivers for nix apps by creating /run/opengl-driver and
# /etc/egl/egl_external_platform.d symlinks. Needs sudo. Only needs to be
# re-run after a home-manager switch when the driver path changes.
set -euo pipefail

host="$(hostname -s)"
setup="$(nix eval --raw "$HOME/.config/nix-config#homeConfigurations.raffaele@$host.config.targets.genericLinux.gpu.setupPackage.outPath")"

sudo "$setup/bin/non-nixos-gpu-setup"
