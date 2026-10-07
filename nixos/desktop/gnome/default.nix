{ pkgs, ... }:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    baobab
    epiphany
    gnome-characters
    gnome-clocks
    gnome-connections
    gnome-contacts
    gnome-font-viewer
    gnome-music
    gnome-software
    gnome-system-monitor
    gnome-tecla
    gnome-text-editor
    gnome-tour
    gnome-user-docs
    gnome-weather
    simple-scan
    yelp
  ];

  environment.systemPackages = [ pkgs.gnome-tweaks ];
}
