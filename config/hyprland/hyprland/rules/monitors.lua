local monitors = Hyprland.monitors

-- TODO: Sort monitors by order using position values, and then re-assign to global variable
-- TODO: Allow for specifying which workspaces should be on which monitors
for i, mon in ipairs(monitors) do
	hl.monitor({
		output = mon.output,
		mode = mon.mode,
		position = mon.position,
		bitdepth = mon.hdr and 10,
		cm = mon.hdr and "auto",
		disable = mon.disable or nil,
	})

	hl.workspace_rule({
		workspace = tostring(i),
		monitor = mon.output,
		default = true,
	})
end
