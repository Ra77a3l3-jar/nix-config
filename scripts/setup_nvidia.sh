#!/usr/bin/env bash
set -euo pipefail

FEDORA_VERSION="$(rpm -E %fedora)"

echo "Enabling RPM Fusion..."
sudo dnf install -y \
    "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VERSION}.noarch.rpm" \
    "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_VERSION}.noarch.rpm"

echo "Installing NVIDIA driver..."
sudo dnf update -y
sudo dnf install -y akmod-nvidia

read -rp "Install CUDA support? [y/N]: " cuda
if [ "${cuda,,}" = "y" ] || [ "${cuda,,}" = "yes" ]; then
    sudo dnf install -y xorg-x11-drv-nvidia-cuda
fi

if [ -d /sys/firmware/efi ]; then
    echo "Secure Boot note: if the driver fails to load after reboot, enroll the MOK:"
    echo "  sudo mokutil --import /etc/pki/akmods/certs/public_key.der"
fi

echo "NVIDIA driver installed. Reboot required."
read -rp "Reboot now? [y/N]: " reboot
if [ "${reboot,,}" = "y" ] || [ "${reboot,,}" = "yes" ]; then
    sudo systemctl reboot
fi
