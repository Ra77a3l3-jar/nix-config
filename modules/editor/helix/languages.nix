{ ... }:

{
  programs.helix.languages = {
    language-server = {
      arduino-language-server = {
        command = "arduino-language-server";
        args = [ "-cli" "arduino-cli" "-clangd" "clangd" ];
      };
    };
    
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
        name = "arduino";
        scope = "source.cpp";
        file-types = [ "ino" "pde" ];
        language-servers = [ "clangd" ];
        indent = {
          tab-width = 4;
          unit = "    ";
        };
        grammar = "cpp";
      }

      {
        name = "rust";
        auto-format = false;
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

      {
        name = "scheme";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }
    ];
  };
}
