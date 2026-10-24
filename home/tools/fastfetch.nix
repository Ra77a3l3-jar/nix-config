{ pkgs-unstable, ... }:

{
  home.packages = [ pkgs-unstable.pokemon-colorscripts ];

  programs.fastfetch = {
    enable = true;
    package = pkgs-unstable.fastfetch;

    settings = {
      logo = {
        # Native image dimensions avoid resampling the pixel art in Fastfetch.
        type = "kitty";
        source = "${./fastfetch/charizard.png}";
        padding = {
          left = 2;
          right = 5;
          top = 1;
        };
      };

      display = {
        separator = "  ";
        color = {
          keys = "#8d8a89";
          output = "#d9d4c8";
        };
        percent = {
          type = 9;
          color = {
            green = "green";
            yellow = "yellow";
            red = "red";
          };
        };
      };

      modules = [
        {
          type = "custom";
          key = "╭───────────╮";
        }
        {
          type = "title";
          key = "│ {#31} user    {#keys}│";
          format = "{user-name}";
        }
        {
          type = "title";
          key = "│ {#32}󰟀 host    {#keys}│";
          format = "{host-name}";
        }
        {
          type = "os";
          key = "│ {#34} distro  {#keys}│";
          format = "{pretty-name}";
        }
        {
          type = "kernel";
          key = "│ {#35} kernel  {#keys}│";
          format = "{sysname} {release}";
        }
        {
          type = "uptime";
          key = "│ {#33} uptime  {#keys}│";
          format = "{?days}{days} Days {?}{hours} Hrs {minutes} Mins";
        }
        {
          type = "terminal";
          key = "│ {#31} term    {#keys}│";
          format = "{pretty-name}";
        }
        {
          type = "shell";
          key = "│ {#32} shell   {#keys}│";
          format = "{pretty-name}";
        }
        {
          type = "disk";
          key = "│ {#34} disk    {#keys}│";
          folders = "/";
          format = "{size-used} / {size-total} ({size-percentage})";
        }
        {
          type = "memory";
          key = "│ {#35} memory  {#keys}│";
          format = "{used} / {total} ({percentage})";
        }
        {
          type = "localip";
          key = "│ {#36}󰩟 network {#keys}│";
          showIpv4 = true;
          showIpv6 = false;
          showPrefixLen = true;
          showLoop = false;
          defaultRouteOnly = true;
          format = "{ipv4}";
        }
        {
          type = "custom";
          key = "├───────────┤";
        }
        {
          type = "custom";
          key = "│ {#39} colors  {#keys}│";
          format = "{#39}󰮯  {#90}● {#37}● {#36}● {#35}● {#34}● {#33}● {#32}● {#31}●";
        }
        {
          type = "custom";
          key = "╰───────────╯";
        }
      ];
    };
  };
}
