local mainMod = "SUPER"

local terminal = "wezterm"
local browser = "zen-beta"
local fileManager = "nautilus"
local launcher = "hyprlauncher"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(launcher))

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))

hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })

for workspace = 1, 10 do
  local key = workspace % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace, follow = true }))
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

local volumeUp = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
local volumeDown = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
local volumeMute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
local microphoneMute = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
local mediaNext = "playerctl next"
local mediaPlayPause = "playerctl play-pause"
local mediaPrevious = "playerctl previous"
local brightnessUp = "brightnessctl set 5%+"
local brightnessDown = "brightnessctl set 5%-"

-- Laptop Fn/media keys.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(volumeUp), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(volumeDown), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(volumeMute), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(microphoneMute), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(mediaNext), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(mediaPlayPause), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(mediaPlayPause), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(mediaPrevious), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(brightnessUp), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(brightnessDown), { locked = true, repeating = true })

-- Keyboard alternatives to the laptop Fn/media keys.
hl.bind(mainMod .. " + ALT + up", hl.dsp.exec_cmd(volumeUp), { locked = true, repeating = true })
hl.bind(mainMod .. " + ALT + down", hl.dsp.exec_cmd(volumeDown), { locked = true, repeating = true })
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd(volumeMute), { locked = true })
hl.bind(mainMod .. " + ALT + SHIFT + M", hl.dsp.exec_cmd(microphoneMute), { locked = true })
hl.bind(mainMod .. " + ALT + right", hl.dsp.exec_cmd(mediaNext), { locked = true })
hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.exec_cmd(mediaPlayPause), { locked = true })
hl.bind(mainMod .. " + ALT + left", hl.dsp.exec_cmd(mediaPrevious), { locked = true })
hl.bind(mainMod .. " + ALT + SHIFT + up", hl.dsp.exec_cmd(brightnessUp), { locked = true, repeating = true })
hl.bind(mainMod .. " + ALT + SHIFT + down", hl.dsp.exec_cmd(brightnessDown), { locked = true, repeating = true })

hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/toggle-layout.sh"))
