import AstalHyprland from "gi://AstalHyprland"
import {bind} from "ags/state"
import { With } from "ags/gtk4";

export default function Client() {
  const hypr = AstalHyprland.get_default();
  const focused = bind(hypr, "focusedClient");
  return (
    <box cssClasses={["widget"]} visible={focused.as(Boolean)}>
      <With value={focused}>
        {(client) => client && (
          <label label={bind(client, "initialTitle")}/>
        )}
      </With>
    </box>
  )
}
