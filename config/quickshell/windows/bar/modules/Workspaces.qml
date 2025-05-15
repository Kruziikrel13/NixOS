import "root:/services"
import "../components/"

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets

Item {
  WheelHandler {
    onWheel: (event) => {
      if (event.angleDelta.y < 0)
      Hyprland.dispatch("workspace r+1")
      else if (event.angleDelta.y > 0)
      Hyprland.dispatch("workspace r-1")
    }
  }
  height: parent.height
  width: parent.width

  RowLayout {
    id: rowLayout
    z: 1
    spacing: 0
    anchors.fill: parent
    implicitHeight: 40
    implicitWidth: parent.width

    Repeater {
      model: Hyprland.workspaces

      Label {
        id: ws
        required property int index
        required property HyprlandWorkspace modelData
        property bool empty: Hyprland.workspaces.lastIpcObject.windows == 0
        property bool focused: index + 1 === Hyprland.focusedMonitor.activeWorkspace.id
        text: {
          if (empty) {
            return ""
          } else {
            return ""
          }
        }
        color: {
          if (focused) {
            return "red"
          } else {
            return "white"
          }
        }
      }
    }
  }
}
