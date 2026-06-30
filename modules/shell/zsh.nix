{ pkgs, pkgs-unstable, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      export PATH="$HOME/.local/bin:$PATH"
      export PATH="$HOME/.nix-profile/bin:$PATH"
      
      if command -v zoxide >/dev/null 2>&1; then
        eval "$(zoxide init zsh)"
      fi

      if command -v oh-my-posh >/dev/null 2>&1; then
        eval "$(oh-my-posh init zsh --config ${pkgs-unstable.oh-my-posh}/share/oh-my-posh/themes/pararussel.omp.json)"
      fi
    '';
  };
}
