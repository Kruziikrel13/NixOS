import AstalHyprland from "gi://AstalHyprland"
import {bind} from "ags/state"
import { With } from "ags/gtk4";
import GLib from "gi://GLib?version=2.0";
export default function Client() {
  const hypr = AstalHyprland.get_default();
  const focused = bind(hypr, "focusedClient").as(client => client?.get_initial_title())
  return (
    <box visible={focused.as(Boolean)}>
      <With value={focused}>
        {(title) => title && (
        <label label={title}/>
        )}
      </With>
    </box>
  )
}
