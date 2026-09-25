-- Ignore application maximize requests; explicit SUPER+M and SUPER+F actions
-- remain available to the user.
hl.window_rule({
  name = "suppress-maximize-requests",
  match = { class = ".*" },
  suppress_event = "maximize",
})

-- Prevent focus glitches from empty XWayland helper windows
hl.window_rule({
  name = "fix-xwayland-helper-focus",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})
