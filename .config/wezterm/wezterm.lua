local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Shell
config.default_prog = {
	"pwsh",
	"-NoExit",
	"-Command",
	"cd ~; . 'C:/Users/r.moshrefi/Documents/WindowsPowerShell/Microsoft.Powershell_profile.ps1'",
}
-- Font
config.font = wezterm.font_with_fallback({
  { family = "DejaVuSansM Nerd Font Mono" },
  { 
    family = "Vazirmatn",
    harfbuzz_features = { "calt=1", "clig=1", "liga=1", "join=1" },
  },
})
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
config.font_size = 11.6
config.use_ime = false

-- BiDi (Farsi/RTL support)
config.bidi_enabled = true
config.bidi_direction = "AutoLeftToRight"
-- Window
config.initial_rows = 50
config.initial_cols = 220
config.window_decorations = "RESIZE"
config.window_padding = { left = 10, right = 10, top = 50, bottom = 10 }

-- Font
-- config.font = wezterm.font("DejaVuSansM Nerd Font Mono")
config.font_size = 11.6

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- Colors (Gruvbox Dark)
config.colors = {
	foreground = "#ebdbb2",
	background = "#282828",
	cursor_bg = "#ebdbb2",
	cursor_fg = "#282828",
	ansi = {
		"#282828",
		"#cc241d",
		"#98971a",
		"#d79921",
		"#458588",
		"#b16286",
		"#689d6a",
		"#a89984",
	},
	brights = {
		"#928374",
		"#fb4934",
		"#b8bb26",
		"#fabd2f",
		"#83a598",
		"#d3869b",
		"#8ec07c",
		"#ebdbb2",
	},
}

-- Tab bar (status bar equivalent)
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true


-- Multiplexing (replaces tmux)
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
	-- New tab
	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },

	-- Splits
	{ key = "|", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Switch panes (Alt+Arrow)
	{ key = "LeftArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },

	-- Switch tabs (Shift+Arrow)
	{ key = "LeftArrow", mods = "SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "SHIFT", action = wezterm.action.ActivateTabRelative(1) },

	{ key = "r", mods = "LEADER", action = wezterm.action.ReloadConfiguration },
}

-- Mouse
config.mouse_bindings = {} -- defaults are fine

-- Scrollback
config.scrollback_lines = 5000

-- Environment
config.set_environment_variables = {
	TERM = "xterm-256color",
	COLORTERM = "truecolor",
}
-- Right status: date + time
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
  options = {
    icons_enabled = true,
    theme = 'GruvboxDark',
    tabs_enabled = true,
    theme_overrides = {},
    section_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
    component_separators = {
      left = wezterm.nerdfonts.pl_left_soft_divider,
      right = wezterm.nerdfonts.pl_right_soft_divider,
    },
    tab_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
  },
  sections = {
    tabline_a = { 'mode' },
    tabline_b = { 'workspace' },
    tabline_c = { ' ' },
    tab_active = {
      'index',
      { 'parent', padding = 10 },
      '/',
      { 'cwd', padding = { left = 0, right = 1 } },
      { 'zoomed', padding = 0 },
    },
    tab_inactive = { 'index', { 'process', padding = { left = 0, right = 1 } } },
    tabline_x = { 'ram', 'cpu' },
    tabline_y = { 'datetime', 'battery' },
    tabline_z = { 'domain' },
  },
  extensions = {},
})

tabline.apply_to_config(config)

config.window_padding = { left = 10, right = 10, top = 10, bottom = 0 }

return config

