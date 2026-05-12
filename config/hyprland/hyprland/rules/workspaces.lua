local function create_workspace(name, monitor, key)
	hl.workspace_rule({
		workspace = "name:" .. name,
		monitor = monitor,
		layout = "monocle",
		decorate = false,
		no_rounding = true,
		gaps_in = 0,
		gaps_out = 0,
	})

	hl.window_rule({
		match = { tag = name },
		workspace = "name:" .. name,
	})

	hl.define_submap("workspaces", function()
		hl.bind(key, hl.dsp.focus({ workspace = "name:" .. name }))
	end)
end

create_workspace("gaming", Hyprland.primary_monitor, "G")
create_workspace("chat", "desc:ViewSonic Corporation VX2758-C-MH V9M184500179", "C")
create_workspace("email", "desc:ViewSonic Corporation VX2758-C-MH V9M184500179", "E")
