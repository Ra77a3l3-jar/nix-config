local wezterm = require("wezterm")

-- Start maximized on launch
wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  font = wezterm.font_with_fallback({
    { family = "JetBrains Mono Nerd Font", weight = "Bold" },
    { family = "Fira Code", weight = "Regular" },
  }),
  font_size = 13,

  bold_brightens_ansi_colors = false,

  color_scheme = "VibrantInk",

  default_cursor_style = "BlinkingBar",
  cursor_blink_rate = 500,

  window_background_opacity = 0.8,
  text_background_opacity = 1.0,

  window_close_confirmation = "NeverPrompt",
  window_decorations = "NONE",

  window_padding = {
    left = 15,
    right = 15,
    top = 15,
    bottom = 15,
  },

  scrollback_lines = 200000,

  enable_tab_bar = false,
}
