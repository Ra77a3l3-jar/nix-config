-- rog monitor
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@144",
    position = "0x0",
    scale    = "1.0",
})

-- legion monitor
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@165",
    position = "1920x0",
    scale    = "1.25",
})

-- first six workspaces on the external display
for workspace = 1, 6 do
    hl.workspace_rule({
        workspace = tostring(workspace),
        monitor = "HDMI-A-1",
        default = workspace == 1,
    })
end

-- workspaces 7-9 on the laptop display
for workspace = 7, 9 do
    hl.workspace_rule({
        workspace = tostring(workspace),
        monitor = "eDP-1",
        default = workspace == 7,
    })
end
