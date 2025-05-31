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
    acceptedButtons: Qt.LeftButton
    StyledText {
      color: mouseArea.containsMouse ? Appearance.colors.warning : Appearance.colors.urgent
      font.pixelSize: Appearance.font.pixelSize.largest
      text: "󰐥"
    }
  }
}
