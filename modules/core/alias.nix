{ ... }:

{
  home.shellAliases = {
    hms = "home-manager switch --flake ~/.config/nix-config";
    hmb = "home-manager build --flake ~/.config/nix-config";
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
    
    la = "eza -la --icons";
    ltree = "eza --tree --level=3 --long --git --icons";
    ls = "eza --icons";
    lg = "eza -l --git --icons";
    lt = "eza --git --tree -l --icons";
  };
}
