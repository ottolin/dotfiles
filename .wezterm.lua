-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Afterglow'
--config.color_scheme = 'Everblush'
--config.color_scheme = 'Calamity'
--config.color_scheme = 'DoomOne'
--config.color_scheme = 'GruvboxDarkHard'
--config.color_scheme = 'Ocean (dark) (terminal.sexy)'
--
config.window_frame = {
  border_left_width = '0.2cell',
  border_right_width = '0.2cell',
  border_bottom_height = '0.1cell',
  border_left_color = 'black',
  border_right_color = 'black',
  border_bottom_color = 'black',

}

-- and finally, return the configuration to wezterm
return config
