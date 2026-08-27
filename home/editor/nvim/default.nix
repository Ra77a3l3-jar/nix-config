{ inputs, ... }:

{
  imports = [
    inputs.neovim-nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    settings = {
      imports = [
        ./modules
      ];
    };
  };
}
