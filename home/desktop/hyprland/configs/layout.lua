hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,

    border_size = 0,

    resize_on_border = true,

    layout = "scrolling",

    col = {
      active_border = {
        colors = { "rgba(89b4faff)", "rgba(cba6f7ff)" },
        angle = 45,
      },
      inactive_border = "rgba(45475aaa)",
    },
  },

  dwindle = {
    preserve_split = true,
  },

  scrolling = {
    fullscreen_on_one_column = true,
    column_width = 0.5,
    focus_fit_method = 1,
    follow_focus = true,
    follow_min_visible = 0.4,
    explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
    wrap_focus = true,
  },
})

local stateHome = os.getenv("XDG_STATE_HOME")
if stateHome == nil or stateHome == "" then
  stateHome = os.getenv("HOME") .. "/.local/state"
end

for workspace = 1, 10 do
  local path = string.format("%s/hyprland/workspace-layouts/%d.lua", stateHome, workspace)
  local workspaceLayout = loadfile(path)
  if workspaceLayout ~= nil then
    workspaceLayout()
  end
end
