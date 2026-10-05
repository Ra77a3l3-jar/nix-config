hl.config({
    plugin = {
        scrolloverview = {
            gesture_distance = 300, -- how far is the "max" for the gesture
            scale = 0.6, -- preferred overview scale
            workspace_gap = 60,
            layout = "vertical", -- vertical, horizontal, or auto (per-monitor orientation)
            wallpaper = 0, -- 0: global only, 1: per-workspace only, 2: both
            blur = true, -- blur only the main overview wallpaper

        },
    },
})
