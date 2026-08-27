{ pkgs-unstable, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs-unstable.git;

    settings = {
      user = {
        name = "Ra77a3l3-jar";
        email = "raffaelemeo77@gmail.com";
      };
      init.defaultBranch = "main";
      core.editor = "hx";
    };
  };

  home.packages = with pkgs-unstable; [
    gh
  ];
}
