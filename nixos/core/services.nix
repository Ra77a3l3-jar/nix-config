{ ... }:
{
  services.printing.enable = true;
  services.openssh.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  users.users.raffaele.extraGroups = [ "docker" ];
}
