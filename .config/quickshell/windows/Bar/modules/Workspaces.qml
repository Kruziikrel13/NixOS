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
      WrapperMouseArea {
        required property HyprlandWorkspace modelData
        onClicked: modelData.activate()
        Rectangle {
          implicitHeight: {
            if (modelData.focused || modelData.lastIpcObject.windows > 0) return 15
            return 10
          }
          implicitWidth: {
            if (modelData.focused) return 30
            if (modelData.lastIpcObject.windows > 0) return 15
            return 10
          }
          color: {
            if (modelData.focused) return "#51A4E7"
            if (modelData.lastIpcObject.windows > 0) return "#C4C4C4"
            return "#525252"
          }
          radius: modelData.focused ? 2.5 : 10
        }
      }
    }
  }
}
