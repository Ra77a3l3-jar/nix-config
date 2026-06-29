# Nix Configuration

Personal Nix + Home Manager configuration for managing dotfiles and packages across multiple machines.

## Supported Hosts

- `school-laptop` - School/travel laptop configuration
- `personal-pc` - Personal desktop configuration

## Installation on Fedora

### Quick Install

It will install prerequisites, set up Nix, configure Git/SSH, clone this repository, and bootstrap Home Manager for the current machine:

```bash
./install.sh
```

If you need NVIDIA drivers, run after installation:

```bash
./setup_nvidia.sh
```

You can also run the Git/SSH setup on its own:

```bash
./setup_git.sh
```

### Manual Steps

If you prefer to run the steps manually instead of using the scripts above:

#### 1. Install Prerequisites

First, install Fish shell and Kitty terminal using DNF:

```bash
sudo dnf install fish kitty
```

Set Fish as your default shell:

```bash
chsh -s $(which fish)
```

Log out and log back in for the shell change to take effect.

#### 2. Install Nix

Install Nix package manager:

```bash
sudo dnf install nix
```

Enable and start the Nix daemon:

```bash
sudo systemctl enable --now nix-daemon.service
```

Add yourself to the nix-users group:

```bash
sudo usermod -aG nix-users $USER
```

Log out and log back in for the group change to take effect.

Configure Nix to enable flakes and the nix command. Create or edit `~/.config/nix/nix.conf`:

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

#### 3. Setup Git and SSH for GitHub

Configure Git with your information:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Generate an SSH key for GitHub:

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

Press Enter to accept the default file location, then add a passphrase if desired.

Start the SSH agent and add your key:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Display your public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Copy the output and add it to your GitHub account:
- Go to GitHub Settings > SSH and GPG keys
- Click "New SSH key"
- Paste your public key and save

Test your connection:

```bash
ssh -T git@github.com
```

#### 4. Clone This Repository

Clone the repository using SSH:

```bash
mkdir -p ~/.config
git clone git@github.com:Ra77a3l3-jar/nix-config.git ~/.config/nix-config
cd ~/.config/nix-config
```

#### 5. Install Home Manager

Bootstrap Home Manager with the appropriate configuration for your machine:

**For school laptop:**
```bash
nix run home-manager/release-25.11 -- init --switch --flake ~/.config/nix-config#raffaele@school-laptop
```

**For personal PC:**
```bash
nix run home-manager/release-25.11 -- init --switch --flake ~/.config/nix-config#raffaele@personal-pc
```

### 6. Apply Configuration

After the initial setup, you can use the built-in aliases to manage your configuration:

```bash
hms  # Apply configuration changes (home-manager switch)
hmb  # Build configuration without activating (home-manager build)
```

These aliases automatically use the correct configuration for your machine.

## Making Changes

1. Edit configuration files in `~/.config/nix-config/`
2. Test your changes: `hmb`
3. Apply your changes: `hms`
4. Commit and push to keep your config in sync

## Troubleshooting

### Nix daemon not starting

If you encounter issues with the Nix daemon:

```bash
sudo systemctl status nix-daemon.service
sudo journalctl -u nix-daemon.service
```

### Home Manager conflicts

If you get conflicts about existing files:

```bash
# Backup and remove conflicting dotfiles
mv ~/.bashrc ~/.bashrc.backup
# Then retry: hms
```

### Flakes not enabled

If you get an error about experimental features:

```bash
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

## Updating

Update flake inputs (nixpkgs, home-manager, etc.):

```bash
cd ~/.config/nix-config
nix flake update
hms
```
