{ ... }:

{
  home.shellAliases = {
    # Hms and hmb are defined in each host's home.nix for machine-specific configs
    hmu = "nix flake update ~/.config/nix-config";
    hmg = "nix-collect-garbage -d";
    hml = "home-manager generations";

    nd-hsk = "nix develop ~/.config/nix-config#haskell -c fish";
    nd-go = "nix develop ~/.config/nix-config#go -c fish";
    nd-java = "nix develop ~/.config/nix-config#java -c fish";
    nd-zig = "nix develop ~/.config/nix-config#zig -c fish";
    nd-asm = "nix develop ~/.config/nix-config#asm -c fish";
    nd-nix = "nix develop ~/.config/nix-config#nix -c fish";
    nd-sh = "nix develop ~/.config/nix-config#bash -c fish";
    nd-ros = "nix develop ~/.config/nix-config#ros -c fish";
    
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
