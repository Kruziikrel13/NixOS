require("hyprland")

hl.config({ debug = { disable_logs = false }, misc = { disable_autoreload = false } })

hl.notification.create({ text = "Hyprland reloaded", duration = "2000", icon = "ok" })
