import AstalHyprland from "gi://AstalHyprland"
import { For } from "ags/gtk4";
import {bind} from "ags/state"

function sortWorkspaces(array: AstalHyprland.Workspace[]) {
  return Array.from(array.values()).sort((a, b) => {
    return a.id - b.id;
  })
}

export default function Workspaces() {
  const hypr = AstalHyprland.get_default();

  const workspaces = bind(hypr, "workspaces").as(workspaces => sortWorkspaces(workspaces))

  return (
    <box 
      name="workspaces"
      cssClasses={["widget"]}>
      <For each={workspaces} cleanup={(button) => button.run_dispose()}>
        {(workspace, _) => (
          <button cssClasses={bind(hypr, "focusedWorkspace").as(fw => fw?.id == workspace.id ? ["workspace", "active"] : ["workspace"])}
            $clicked={() => {workspace.focus()}}
            label={bind(workspace, "clients").as(clients => clients.length > 0 ? "" : "")}
          />
        )}

      </For>
    </box>
  )
}
