# Scripts

Run these from the repository root as your regular user. Scripts that need system access call `sudo` themselves.

| Script | What it does |
| --- | --- |
| [`install.sh`](install.sh) | Prepares Fedora for Nix and Git, then prints a Home Manager bootstrap command. |
| [`clone-dotfiles.sh`](clone-dotfiles.sh) | Installs [Hyprland and Quickshell dotfiles](https://github.com/Ra77a3l3-jar/.dotfiles) into `~/.config` without replacing unrelated files. |
| [`install-hyprland-fedora.sh`](install-hyprland-fedora.sh) | Registers the Nix Hyprland GDM session and removes only the old Fedora Hyprland RPMs. |
| [`setup_git.sh`](setup_git.sh) | Sets Git identity, creates an SSH key if needed, and guides GitHub SSH setup. |
| [`set-default-shell.sh`](set-default-shell.sh) | Sets an installed shell as your login shell, preferring stable Nix profile paths; supports `--dry-run`. |
| [`set-fish-shell.sh`](set-fish-shell.sh) | Sets the Nix installed Fish binary as the login shell. |
| [`setup_nvidia.sh`](setup_nvidia.sh) | Installs the Fedora NVIDIA driver through RPM Fusion; optionally adds CUDA. |
| [`setup_gpu.sh`](setup_gpu.sh) | Updates GPU driver links for Nix GUI apps on Fedora after Home Manager is applied. |
| [`update-nvidia-driver.sh`](update-nvidia-driver.sh) | Updates Legion's Nix NVIDIA driver pin to match the installed driver. |
| [`setup-iphone-backup.sh`](setup-iphone-backup.sh) | Installs backup tools, sets up OneDrive, and runs the first encrypted iPhone backup and sync. |
| [`backup-iphone.sh`](backup-iphone.sh) | Makes a later full iPhone backup in `~/Phone`; it does not sync to OneDrive. |

For a new Fedora setup, start with `./scripts/install.sh`. The NVIDIA, Hyprland, dotfiles, and iPhone scripts are separate.

After applying Home Manager, use `./scripts/set-default-shell.sh nu` to make Nushell your default, or replace `nu` with `fish`, `bash`, `zsh`, or an absolute shell path. Preview with `./scripts/set-default-shell.sh --dry-run nu`, then log out and back in after applying the change.

On NixOS, set `users.users.raffaele.shell` in [`nixos/core/core.nix`](../nixos/core/core.nix) and rebuild to keep the choice across system rebuilds.
