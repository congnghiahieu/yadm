local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Color scheme
config.color_scheme = "Ayu Mirage"
-- config.color_scheme = "OneDark (base16)"

-- Font
config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono")
config.line_height = 1.0
config.font_size = 11

-- Tab bar
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "#575757",
	},
}

-- Padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0
}

-- Scroll bar
config.enable_scroll_bar = false

-- Dimmed inactive pane
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

-- Width, height
config.initial_cols = 100
config.initial_rows = 36

-- Window frame
config.window_frame = {
	font = wezterm.font({ family = "JetBrainsMonoNL Nerd Font Mono", weight = "Bold" }),
	font_size = 10,
	active_titlebar_bg = "#333333",
	inactive_titlebar_bg = "#333333",
}

-- Audio bell
config.audible_bell = "Disabled"

-- Keymap
config.keys = {
  {
    key = 'F11',
    action = wezterm.action.ToggleFullScreen,
  },
}

return config
