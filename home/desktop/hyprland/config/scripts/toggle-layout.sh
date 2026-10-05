#!/bin/sh

# Toggle the active workspace between Hyprland's dwindle and scrolling layouts.
workspace_json="$(hyprctl -j activeworkspace)" || exit 1
active_workspace="$(printf '%s' "$workspace_json" | jq -er '.id | select(type == "number")')" || exit 1
current_layout="$(printf '%s' "$workspace_json" | jq -er '.tiledLayout | select(type == "string")')" || exit 1

case "$current_layout" in
  dwindle) new_layout="scrolling" ;;
  *) new_layout="dwindle" ;;
esac

state_home="${XDG_STATE_HOME:-$HOME/.local/state}"
layouts_dir="$state_home/hyprland/workspace-layouts"
layout_file="$layouts_dir/$active_workspace.lua"
layout_rule="$(printf 'hl.workspace_rule({ workspace = "%s", layout = "%s" })' "$active_workspace" "$new_layout")"

mkdir -p "$layouts_dir" || exit 1
printf '%s\n' "$layout_rule" > "$layout_file" || exit 1

# Reload so there is exactly one layout rule per workspace. Repeatedly using
# `hyprctl eval` would accumulate conflicting rules in the Lua config context.
hyprctl reload >/dev/null || exit 1

hyprctl notify \
  1 \
  2500 \
  "rgb(89b4fa)" \
  "Workspace $active_workspace layout: $new_layout" >/dev/null
