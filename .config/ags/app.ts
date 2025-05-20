import app from "ags/gtk4/app"
import style from "./style.scss"
import Bar from "./widgets/bar"

app.start({
  icons: "./icons",
  instanceName: "status_bar",
  iconTheme: "Adwaita",
  gtkTheme: "Adwaita",
  css: style,
  main() {
    Bar(app.get_monitors()[0])
  },
})
