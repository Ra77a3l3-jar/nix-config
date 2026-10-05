-- binary paths
hl.env("PATH", "/home/raffaele/.nix-profile/bin:/home/raffaele/.local/bin:/home/raffaele/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin")

-- desktop file lookup (fix nix apps missing in hyprlauncher)
-- Hyprland/GDM session starts without XDG_DATA_DIRS, so children never see ~/.nix-profile/share/applications
hl.env("XDG_DATA_DIRS", "/home/raffaele/.nix-profile/share:/nix/var/nix/profiles/default/share:/home/raffaele/.local/share:/home/raffaele/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share")

-- The GNOME session imports this Home Manager variable, while a plain
-- start-hyprland session does not. Nix GUI apps need the matching NVIDIA ICD.
hl.env("VK_ICD_FILENAMES", "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json")

-- Keep this override local to Hyprland; GNOME continues to use its own
-- color-scheme setting from dconf.
hl.env("GTK_THEME", "Yaru-dark")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
