local monitors = Hyprland.monitors

if #monitors > 1 then
	for i, monitor in ipairs(monitors) do
		hl.bind("SUPER + " .. i, hl.dsp.focus({ monitor = monitor.output }))
		hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ monitor = monitor.output }))
	end
	hl.define_submap("workspaces", function()
		hl.bind("bracketright", hl.dsp.focus({ workspace = "emptynm" }))
	end)
else
	for i = 1, 9, 1 do
		hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
		hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
	end
end
