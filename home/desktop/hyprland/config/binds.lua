local mainMod = "SUPER"

local terminal = "wezterm"
local browser = "zen-beta"
local menu = "qs ipc call launcher toggle"
local wallpaperPicker = "qs ipc call wallpaper toggle"
local themePicker = "qs ipc call theme toggle"
local audioControl = "qs ipc call audio toggle"
local networkControl = "qs ipc call connections toggle"
local powerControl = "qs ipc call power toggle"
local settings = "qs ipc call settings toggle"
local fileManager = "nautilus"
local mediaPlayer = "playerctl --player=playerctld"

hl.unbind(mainMod .. " + N")
hl.unbind(mainMod .. " + Q")

-- Use scrolling's own horizontal navigation so focus can move away from a
-- layout-aware maximized/fullscreen window. Other layouts keep normal focus
local function focusHorizontal(direction, scrollingDirection)
  return function()
    local workspace = hl.get_active_workspace()
    if workspace ~= nil and workspace.tiled_layout == "scrolling" then
      hl.dispatch(hl.dsp.layout("focus " .. scrollingDirection))
    else
      hl.dispatch(hl.dsp.focus({ direction = direction }))
    end
  end
end

-- main apps
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- plugins
hl.bind("SUPER + X", function()
    hl.plugin.scrolloverview.overview("toggle all")
end)

-- quickshell appearance popups
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(wallpaperPicker))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd(themePicker))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(audioControl))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(networkControl))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(powerControl))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(settings))

-- window keys
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized", layout_aware = true }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen", layout_aware = true }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))

-- change focus
hl.bind(mainMod .. " + left", focusHorizontal("left", "l"))
hl.bind(mainMod .. " + right", focusHorizontal("right", "r"))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Cycle only the active scrolling column through 1/3, 1/2, 2/3 and full width.
hl.bind(mainMod .. " + bracketleft", hl.dsp.layout("colresize -conf"))
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("colresize +conf"))

-- swap position
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))

-- resizing window
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + code:21", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + code:20", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })

-- switch workspace and move window between workspaces
for workspace = 1, 10 do
  local key = workspace % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace, follow = true }))
end

-- mouse window resizing
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- audio and brightness cmds
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- fn media keys
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd(mediaPlayer .. " next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(mediaPlayer .. " play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd(mediaPlayer .. " play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd(mediaPlayer .. " previous"),   { locked = true })

-- change layout
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/toggle-layout.sh"))
