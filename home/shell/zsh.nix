{ ... }:

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
    '';
  };
}
