import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
  id: workspaces
  z: 1
  spacing: 2.5

  Repeater {
    model: Hyprland.workspaces

    Button {
      property HyprlandWorkspace modelData
      implicitWidth: 25
      implicitHeight: 25
      onClicked: modelData.activate()
      background: null
      Text {
        color: modelData.focused ? "white" : "red"
        text: modelData.lastIpcObject.workspaces > 0 ? "pres" : "empt"
      }
    }
  }
}
