{ pkgs-unstable, ... }:

{
  programs.jujutsu = {
    enable = true;
    package = pkgs-unstable.jujutsu;

    settings = {

      user = {
        name = "Ra77a3l3-jar";
        email = "raffaelemeo77@gmail.com";
      };

      ui = {
        editor = "hx";

        pager = "less -FRX";

        default-command = "status";

        graph.style = "square";

        log-synthetic-elided-nodes = true;

        diff-editor = ":builtin";

        allow-init-native = true;
      };

      aliases = {
        d = [ "diff" ];
        dm = [
          "describe"
          "--message"
        ];
        l = [ "log" ];
        n = [ "new" ];
        ol = [
          "op"
          "log"
        ];
        up = [
          "git"
          "init"
          "--colocate"
        ];
      };
    };
  };
}
