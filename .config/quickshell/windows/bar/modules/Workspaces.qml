import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "root:/services"


WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter

  Connections {
    target: Hyprland

    function onRawEvent(event) {
      if (event in [
        "activewindow", "focusedmon", "monitoradded", 
        "createworkspace", "destroyworkspace", "moveworkspace", 
        "activespecial", "movewindow", "windowtitle"
      ]) return;
      Hyprland.refreshWorkspaces()
    }
  }

  RowLayout {
    spacing: 5

    Repeater {
      model: Hyprland.workspaces

      Text {
        required property HyprlandWorkspace modelData
        font.pixelSize: 15
        text: modelData.lastIpcObject.windows > 0 ? "" : ""
        color: modelData.focused ? "#C4C4C4" : "#525252"
      }
    }
  }
}
