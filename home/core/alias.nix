{ ... }:

{
  home.shellAliases = {
    # Hms and hmb are defined in each host's home.nix for machine-specific configs
    hmu = "nix flake update ~/.config/nix-config";
    hmg = "nix-collect-garbage -d";
    hml = "home-manager generations";

    dev-haskell = "devenv --from path:$HOME/.config/nix-config/devshells --profile haskell shell";
    dev-ros = "devenv --from path:$HOME/.config/nix-config/devshells --profile ros shell";
    dev-go = "devenv --from path:$HOME/.config/nix-config/devshells --profile go shell";
    dev-java = "devenv --from path:$HOME/.config/nix-config/devshells --profile java shell";
    dev-zig = "devenv --from path:$HOME/.config/nix-config/devshells --profile zig shell";
    dev-asm = "devenv --from path:$HOME/.config/nix-config/devshells --profile asm shell";
    dev-nix = "devenv --from path:$HOME/.config/nix-config/devshells --profile nix shell";
    dev-bash = "devenv --from path:$HOME/.config/nix-config/devshells --profile bash shell";

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
