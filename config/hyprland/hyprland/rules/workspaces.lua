local M = {}

local map = {
	gaming = {
		monitor = Hyprland.primary_monitor,
		bind = "G",
	},
	chat = {
		monitor = "desc:ViewSonic Corporation VX2758-C-MH V9M184500179",
		bind = "C",
	},
	email = {
		monitor = "desc:ViewSonic Corporation VX2758-C-MH V9M184500179",
		bind = "E",
	},
	music = {
		monitor = "desc:AOC 24G1WG4 0x0004A33C",
		bind = "M",
	},
}

function M.workspaces()
	local list = {}

	for name, _ in pairs(map) do
		table.insert(list, name)
	end

	return list
end

function M.setup()
	for key, workspace in pairs(map) do
		hl.workspace_rule({
			workspace = "name:" .. key,
			monitor = workspace.monitor,
			layout = "monocle",
			decorate = false,
			no_rounding = true,
			gaps_in = 0,
			gaps_out = 0,
		})

		hl.define_submap("workspaces", function()
			hl.bind(workspace.bind, hl.dsp.focus({ workspace = "name:" .. key }))
		end)
	end
end

return M
