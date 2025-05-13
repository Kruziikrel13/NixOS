import AstalTray from "gi://AstalTray?version=0.1";
import {For, Gtk} from "ags/gtk4";
import {bind} from "ags/state"

export default function Tray() {
  const tray = AstalTray.get_default()

  const init = (btn: Gtk.MenuButton, item: AstalTray.TrayItem) => {
    btn.menuModel = item.menuModel;
    btn.insert_action_group("dbusmenu", item.actionGroup);
    bind(item, "actionGroup").subscribe(btn, () => {
      btn.insert_action_group("dbusmenu", item.actionGroup);
    })
  }

  return (
    <box spacing={5} name="tray" cssClasses={["widget"]}>
      <For each={bind(tray, "items")}>
        {(item) => ( 
          <menubutton $={self => init(self, item)}>
            {new Gtk.Image({gicon: bind(item, "gicon").get()})}
          </menubutton>
        )}
      </For>
    </box>
  )
}

