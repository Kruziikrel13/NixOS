hl.bind("SUPER + W", hl.dsp.submap("workspaces"))
hl.define_submap("workspaces", function()
	hl.bind("catchall", hl.dsp.submap("reset"))
end)
