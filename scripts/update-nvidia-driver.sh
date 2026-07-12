#!/usr/bin/env bash
# Updates the NVIDIA driver pin in lib/nixgl.nix to match the driver
# currently installed on Fedora. Run this after a driver update
set -euo pipefail

NIXGL_FILE="$(dirname "$0")/../lib/nixgl.nix"

if [ ! -r /proc/driver/nvidia/version ]; then
  echo "error /proc/driver/nvidia/version not found (no NVIDIA driver loaded?)"
  exit 1
fi

installed=$(grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' /proc/driver/nvidia/version | head -1)
pinned=$(grep -oE 'version = "[0-9.]+"' "$NIXGL_FILE" | grep -oE '[0-9.]+')

echo "installed driver: $installed"
echo "pinned in nix: $pinned"

if [ "$installed" = "$pinned" ]; then
  echo "already up to date, nothing to do"
  exit 0
fi

url="https://download.nvidia.com/XFree86/Linux-x86_64/$installed/NVIDIA-Linux-x86_64-$installed.run"
echo "downloading driver to compute the new hash (a few hundred MB)..."
hash=$(nix store prefetch-file --json "$url" | grep -oE '"hash":"[^"]+"' | cut -d'"' -f4)

sed -i "s|version = \"$pinned\"|version = \"$installed\"|" "$NIXGL_FILE"
sed -i "s|nvidiaHash = \"sha256-[^\"]*\"|nvidiaHash = \"$hash\"|" "$NIXGL_FILE"

echo "updated $NIXGL_FILE:"
echo "  version    -> $installed"
echo "  nvidiaHash -> $hash"
echo "now run: hms"
