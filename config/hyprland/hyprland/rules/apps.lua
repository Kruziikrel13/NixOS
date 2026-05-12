local window_rule = hl.window_rule
window_rule({
	match = { class = "^(steam_app.*|.*\\.exe|gamescope|\\.gamescope-wrapped|.*minecraft.*)$" },
	tag = "+game",
})

window_rule({
	match = {
		title = "^([Ww]ine.*|REDlauncher|Rockstar Games Launcher)$",
		tag = "game",
	},
	tag = "-game",
})

window_rule({
	match = {
		title = "^(explorer.exe|socialclubhelper.exe|snakebite.exe)$",
		tag = "game",
	},
	tag = "-game",
})

window_rule({
	match = { class = "^([Ss]team|heroic|.*Prism.*|gameguard\\.des)$" },
	tag = "+gaming",
})

window_rule({
	match = { class = "^([Ss]team)$", title = "negative:^([Ss]team)$" },
	float = true,
})

window_rule({
	match = { class = "^([Ss]team)$", title = "^(.*)(Sign in to)(.*)$" },
	center = true,
})

window_rule({
	match = { title = "Proton Mail" },
	tag = "+email",
})

window_rule({
	match = { class = "vesktop" },
	tag = "+chat",
})

window_rule({
	match = { class = "^(zen)$", title = "^(.*)(Watch)(.*)$", fullscreen = true },
	tag = "+video",
})
