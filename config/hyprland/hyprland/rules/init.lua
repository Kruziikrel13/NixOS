local function load(module)
	return require("hyprland.rules." .. module)
end

local window_rule = hl.window_rule
window_rule({
	match = {
		xwayland = false,
		float = true,
	},
	center = true,
})

window_rule({
	match = { xwayland = true },
	no_dim = true,
	no_shadow = true,
	rounding = 0,
})

window_rule({
	match = { class = "ghostty.small" },
	float = true,
	size = { "(monitor_w*0.35)", "(monitor_h*0.35)" },
	move = { "(cursor_x-window_w/2)", "(cursor_y-window_h/2)" },
})

window_rule({
	match = { title = "^(Picture-in-Picture)$" },
	tag = "+video",
	float = true,
	pin = true,
	keep_aspect_ratio = true,
})

window_rule({
	match = { title = "^(Open File|Select EXE|Select a File|Choose wallpaper|Save As|Library|File Upload)$" },
	center = true,
	float = true,
})

load("workspaces").setup()
load("tags").setup()
load("apps")
