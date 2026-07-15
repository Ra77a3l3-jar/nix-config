#!/usr/bin/env bash
# One-time setup: rclone onedrive remote + idevicebackup2, then does the
# first full backup and syncs it to OneDrive. Run scripts/backup-iphone.sh
# for every backup after this.
set -euo pipefail

BACKUP_DIR="$HOME/Phone"
REMOTE="onedrive"
REMOTE_DIR="$REMOTE:Phone"

# install rclone and the libimobiledevice tools (idevicebackup2, ideviceinfo, idevice_id)
sudo dnf install -y rclone libimobiledevice-utils

# rclone remote (interactive OAuth if it doesn't exist yet); this is where the backup will be stored on OneDrive
if ! rclone listremotes | grep -qx "${REMOTE}:"; then
    rclone config create "$REMOTE" onedrive
fi

# device must be plugged in, unlocked, and trusted before we can talk to it
if ! idevice_id -l | grep -q .; then
    echo "No iPhone detected. Plug it in, unlock it, tap Trust, then re-run this script."
    exit 1
fi
ideviceinfo --version >/dev/null

# local folder that will hold the backup, and its matching folder on OneDrive
mkdir -p "$BACKUP_DIR"
rclone mkdir "$REMOTE_DIR"

# turn on encrypted backups (prompts for a password); fails if already on, ignore that
idevicebackup2 -i encryption on || true

# take the first full local backup, then push it up to OneDrive
idevicebackup2 backup --full "$BACKUP_DIR"
rclone sync "$BACKUP_DIR" "$REMOTE_DIR" --progress

echo "Done. Backup is in $BACKUP_DIR and synced to $REMOTE_DIR."
echo "Use scripts/backup-iphone.sh whenever you want to back up again."
