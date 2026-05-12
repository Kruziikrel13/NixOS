local programs = Hyprland.programs
local bind = {
	["RETURN"] = hl.dsp.exec_raw(programs.runapp .. " -- " .. programs.terminal),
	["SHIFT + RETURN"] = hl.dsp.exec_raw(programs.runapp .. " -- " .. programs.terminal .. " --class=ghostty.small"),
	["Escape"] = hl.dsp.exec_raw(programs.hyprshutdown),
	["D"] = hl.dsp.exec_raw(programs.hyprlauncher),
	["F"] = hl.dsp.window.fullscreen(),
	["T"] = hl.dsp.window.float({ action = "toggle" }),
	["C"] = hl.dsp.window.center(),

	-- Window Focus
	["L"] = hl.dsp.focus({ direction = "r" }),
	["H"] = hl.dsp.focus({ direction = "l" }),
	["K"] = hl.dsp.focus({ direction = "u" }),
	["J"] = hl.dsp.focus({ direction = "d" }),

	["mouse_up"] = hl.dsp.focus({ monitor = "r" }),
	["mouse_down"] = hl.dsp.focus({ monitor = "l" }),

	["bracketleft"] = hl.dsp.focus({ workspace = "m-1" }),
	["bracketright"] = hl.dsp.focus({ workspace = "m+1" }),

	["TAB"] = hl.dsp.window.cycle_next(),

	["SHIFT + bracketleft"] = hl.dsp.focus({ monitor = "l" }),
	["SHIFT + bracketright"] = hl.dsp.focus({ monitor = "r" }),
}

local bindl = {
	["XF86AudioNext"] = hl.dsp.exec_raw(programs.playerctl .. " next"),
	["XF86AudioPlay"] = hl.dsp.exec_raw(programs.playerctl .. " play-pause"),
	["XF86AudioPrev"] = hl.dsp.exec_raw(programs.playerctl .. " previous"),
	["XF86AudioMute"] = hl.dsp.exec_raw(programs.wpctl .. " set-mute @DEFAULT_AUDIO_SINK@ toggle"),
}

local binde = {
	["right"] = hl.dsp.window.resize({ x = 25, y = 0 }),
	["left"] = hl.dsp.window.resize({ x = -25, y = 0 }),
	["up"] = hl.dsp.window.resize({ x = 0, y = -25 }),
	["down"] = hl.dsp.window.resize({ x = 0, y = 25 }),
}

local bindle = {
	["XF86AudioLowerVolume"] = hl.dsp.exec_raw(programs.wpctl .. " set-volume @DEFAULT_AUDIO_SINK@ 5%- --limit 1"),
	["XF86AudioRaiseVolume"] = hl.dsp.exec_raw(programs.wpctl .. " set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1"),
}

local bindm = {
	["mouse:272"] = hl.dsp.window.drag(),
	["mouse:273"] = hl.dsp.window.resize(),
}

local bindp = {
	["Q"] = hl.dsp.window.close({ window = "activewindow" }),
	["SHIFT + Q"] = hl.dsp.window.kill({ window = "activewindow" }),
}

local function bindlist(list, mod, flags)
	mod = (mod == nil) and "" or "SUPER + "

	for key, dispatcher in pairs(list) do
		hl.bind(mod .. key, dispatcher, flags)
	end
end

bindlist(bind, "SUPER", nil)
bindlist(bindp, "SUPER", { bypass = true })
bindlist(bindl, nil, { locked = true })
bindlist(binde, "SUPER", { locked = true })
bindlist(bindle, nil, { repeating = true, locked = true })
bindlist(bindm, "SUPER", { mouse = true })

require("hyprland.keybinds.workspaces")
require("hyprland.keybinds.submaps")
