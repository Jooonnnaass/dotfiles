local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

local mux = wezterm.mux

-- Colorscheme
config.color_scheme = 'Catppuccin Frappe'

-- JetBrains Mono Nerd Font
config.font =
	wezterm.font('JetBrains Mono', { weight = 'Regular', italic = false })

-- Font size
config.font_size = 14.0

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

config.native_macos_fullscreen_mode = true

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window {}
	window:gui_window():toggle_fullscreen()
end)

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.disable_default_key_bindings = true
config.keys = {
	{ key = 'q', mods = 'CMD', action = act.QuitApplication },
	{ key = 'r', mods = 'CMD', action = act.ReloadConfiguration },
	{ key = 'l', mods = 'CMD', action = act.ShowDebugOverlay },

	{ key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard' },
	{ key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
}

return config
