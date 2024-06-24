local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local fonts = {
	"JetBrainsMono Nerd Font Mono",
	"MonoLisa",
	"Geist Mono",
	"SF Mono",
	"Monaspace Neon",
	"Monaspace Xenon",
	"Monaspace Krypton",
	"Monaspace Radon",
	"Monaspace Argon",
	"Comic Code Ligatures",
}
local emoji_fonts = { "Apple Color Emoji", "Joypixels", "Twemoji", "Noto Color Emoji", "Noto Emoji" }

config.harfbuzz_features =
	{ "calt", "liga", "zero", "-ss01", "ss02", "-ss03", "ss04", "ss05", "-ss06", "-ss07", "-ss08", "-ss09", "ss10", "ss11", "ss12", "-ss13", "ss14", "ss15", "ss16", "ss17", "ss18" }
config.font = wezterm.font_with_fallback({ fonts[1], emoji_fonts[1], emoji_fonts[2] })
-- config.disable_default_key_bindings = true
config.front_end = "WebGpu"
config.enable_scroll_bar = false
config.scrollback_lines = 10240
config.font_size = 14
config.automatically_reload_config = true
config.default_cursor_style = "SteadyBar"
config.initial_cols = 80
config.initial_rows = 25
config.window_decorations = "RESIZE"
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = {
	left = 30,
	right = 30,
	top = 30,
	bottom = 30,
}
config.window_frame = {
	font = wezterm.font({ family = "SF Mono" }),
	-- font = wezterm.font({ family = "Geist Mono" }),
	active_titlebar_bg = "#394050",
	inactive_titlebar_bg = "#394050",
	font_size = 15.0,
}


config.tab_bar_at_bottom = false
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.colors = {
	tab_bar = {
		inactive_tab = {
			bg_color = "#394050",
			fg_color = "#6C7A96",
		},
		active_tab = {
			bg_color = "#3F4657",
			fg_color = "#C7D0E1",
		},
		inactive_tab_hover = {
			bg_color = "#3F4657",
			fg_color = "#6C7A96",
		},
		new_tab = {
			bg_color = "#394050",
			fg_color = "#8b949e",
		},
		new_tab_hover = {
			bg_color = "#484f58",
			fg_color = "#C7D0E1",
		},
	},
}

DARK_SCHEME = "OneNord"
LIGHT_SCHEME = "OneNord Light"

wezterm.on("toggle-colorscheme", function(window,pane)
  local overrides = window:get_config_overrides() or {}
  if (overrides.color_scheme == DARK_SCHEME)
  then
    overrides.color_scheme = LIGHT_SCHEME
  else
    overrides.color_scheme = DARK_SCHEME
  end
  window:set_config_overrides(overrides)
end)

config.color_scheme = DARK_SCHEME
config.window_background_opacity = 0.9

config.keys = {
    {
      key = 'E',
      mods = 'ALT',
      action = wezterm.action.EmitEvent 'toggle-colorscheme',
    },
}

return config
