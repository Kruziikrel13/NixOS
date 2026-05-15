local M = {}

local focus = false
local mons = nil

--NOTE: has to be done using disable instead of DPMS due to one of my monitors not handling dpms appropriately

-- Focus Mode, Disables non-primary monitors, toggleable
function M.focusmode()
	local monitors = hl.get_monitors()
	local primary = Hyprland.primary_monitor

	if not focus then
		mons = {}
		for _, mon in ipairs(monitors) do
			local output = "desc:" .. mon.description
			if output == primary then
				goto continue
			end
			table.insert(mons, output)

			hl.monitor({ output = output, disabled = true })
			::continue::
		end
		focus = true
	elseif focus and type(mons) == "table" then
		for _, mon in ipairs(mons) do
			hl.monitor({ output = mon, disabled = false })
		end
		focus = false
		mons = nil
	end
end

return M
