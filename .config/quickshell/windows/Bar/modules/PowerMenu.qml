import "root:/widgets"
import "root:/state"
import Quickshell
import Quickshell.Widgets
import QtQuick

WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter

  WrapperMouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    StyledText {
      color: mouseArea.containsMouse ? Appearance.paletteColours.warning :Appearance.paletteColours.urgent
      font.pixelSize: 24
      text: "󰐥"
    }
  }
}
