{ pkgs-unstable, ... }:
{
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
  services.fstrim.enable = true;

  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  boot.loader.systemd-boot.configurationLimit = 10;

  time.timeZone = "Europe/Rome";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users."raffaele" = {
    isNormalUser = true;
    description = "raffaele";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs-unstable.nushell;
  };

  programs.fish.enable = true;

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  programs.firefox.enable = true;
}
