hl.config({
	general = {
		layout = "dwindle",
		gaps_in = 5,
		gaps_out = 5,
		border_size = 1,
		allow_tearing = true,
		no_focus_fallback = true,
		snap = {
			enabled = true,
			respect_gaps = true,
		},
	},

	decoration = {
		rounding = 10,
		rounding_power = 3,
		blur = {
			new_optimizations = true,
			xray = true,
			popups = false,
			popups_ignorealpha = 0.2,

			brightness = 1.0,
			contrast = 1.0,
			noise = 0.01,
			vibrancy = 0.2,
			vibrancy_darkness = 0.5,

			passes = 4,
			size = 7,
		},
		shadow = {
			offset = { 20, 20 },
			range = 100,
			render_power = 2,
			scale = 0.97,
		},
	},

	binds = { scroll_event_delay = 10 },
	input = {
		accel_profile = "flat",
		follow_mouse = 1,
	},
	cursor = {
		default_monitor = Hyprland.primary_monitor,
		no_hardware_cursors = 1,
	},

	render = {
		direct_scanout = 2,
		new_render_scheduling = true,
		cm_auto_hdr = true,
	},

	dwindle = {
		force_split = 2,
		preserve_split = true,
	},

	xwayland = {
		force_zero_scaling = true,
		create_abstract_socket = true,
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 0,
		middle_click_paste = false,
	},
})

require("hyprland.settings.animations")
require("hyprland.settings.events")
