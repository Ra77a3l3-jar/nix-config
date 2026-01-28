{ ... }:

{
  programs.helix.languages = {
    language = [
      {
        name = "python";
        language-servers = [ "pyright" ];
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "c";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "cpp";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "rust";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "java";
        language-servers = [ "jdtls" ];
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "bash";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "zig";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "toml";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "xml";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "go";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "nix";
        indent = {
          tab-width = 4;
          unit = "  ";
        };
      }
    ];
  };
}
