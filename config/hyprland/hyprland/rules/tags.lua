local M = {}

---@type table<string, HL.WindowRuleSpec>
local map = {
	["game"] = {
		tag = "+gaming",
		decorate = false,
		idle_inhibit = "always",
		immediate = true,
		fullscreen = true,
		float = true,
		render_unfocused = true,
		keep_aspect_ratio = true,
		confine_pointer = true,
		no_vrr = true,
	},
	["video"] = {
		decorate = false,
		idle_inhibit = "fullscreen",
		keep_aspect_ratio = true,
	},
}

function M.setup()
	-- create tags for all workspaces
	local workspaces = require("hyprland.rules.workspaces").workspaces()
	for _, val in ipairs(workspaces) do
		map[val] = { workspace = "name:" .. val }
	end

	for key, val in pairs(map) do
		-- coerce map into window_rule conformant table NOTE: this will modify map permanently
		val.match = { tag = key }

		hl.window_rule(val)
	end
end

return M
