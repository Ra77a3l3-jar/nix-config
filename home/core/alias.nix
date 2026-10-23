{ ... }:

{
  home.shellAliases = {
    # Hms and hmb are defined in each host's home.nix for machine-specific configs
    hmu = "nix flake update ~/.config/nix-config";
    hmg = "nix-collect-garbage -d";
    hml = "home-manager generations";

    ex = "exit";
    zl = "zellij";
    cl = "clear";
    hs = "history";
    cd = "z";

    gs = "git status";
    gc = "git checkout";
    ga = "git add";
    gdf = "git diff";
    gf = "git fetch";
    gp = "git pull";
    gP = "git push";

    lgit = "lazygit";
    ldoc = "lazydocker";

    la = "eza -la";
    ltree = "eza --tree --level=3 --long --git";
    ls = "eza";
    lg = "eza -l --git";
    lt = "eza --git --tree -l";
  };
}
