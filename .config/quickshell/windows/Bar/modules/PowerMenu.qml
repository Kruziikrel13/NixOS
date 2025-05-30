import "root:/widgets"
import "root:/settings"
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick

WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter

  WrapperMouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    onClicked: () => {
      Hyprland.dispatch('global quickshell:powerMenuToggle')
    }
    StyledText {
      color: mouseArea.containsMouse ? Appearance.colors.warning :Appearance.colors.urgent
      font.pixelSize: 24
      text: "󰐥"
    }
  }
}
