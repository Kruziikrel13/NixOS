local cursor = Hyprland.cursor
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprctl setcursor" .. " " .. cursor.name .. " " .. cursor.size)
	hl.exec_cmd("uwsm finalize")
end)
