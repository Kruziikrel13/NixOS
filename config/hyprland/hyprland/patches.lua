-- Ensure hardware cursors value is set to 2 when direct scanout is enabled
if hl.get_config("render.direct_scanout") == 2 and hl.get_config("cursor.no_hardware_cursors") ~= 2 then
	hl.config({ cursor = { no_hardware_cursors = 2 } })
end
