-- Pull in the wezterm API
local wezterm = require("wezterm")

-- this will hold the mux to get the gui window
local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

-- sets the fullscreen mode to the native macos fullscreen
config.native_macos_fullscreen_mode = true

-- sets the window to fullscreen on startup
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():toggle_fullscreen()
end)

-- fontsize
config.font_size = 15

-- changing the color scheme:
config.color_scheme = "Catppuccin Frappe"

-- Change function of option key to make curly braces possible with left option
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

-- and finally, return the configuration to wezterm
return config
