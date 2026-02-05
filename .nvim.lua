Sentinel.terminal.create_task("nh os switch", "bb", {
	name = "NixOS Build",
	show = true,
	layout = "below",
	watch_files = true,
})

Sentinel.terminal.create_task("nh os switch --update", "bu", {
	name = "NixOS Build and Update",
	show = true,
	layout = "below",
	watch_files = true,
})

Sentinel.terminal.create_task("nix flake update", "u", {
	name = "NixOS Update",
	show = true,
	layout = "below",
	watch_files = true,
})
