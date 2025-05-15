import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Hyprland

Item {
  required property var bar
  readonly property HyprlandMonitor monitor: Hyprland.monitorFor(bar.screen)
  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

  height: parent.height
  width: colLayout.width

  ColumnLayout {
    id: colLayout
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    anchors.right: parent.right
    spacing: -4

    Text {
      Layout.fillWidth: true
      font.pixelSize: 20
      elide: Text.ElideRight
      color: "white"
      text: activeWindow?.activated ? activeWindow?.appId : qsTr("Desktop")
    }
  }
}
