import Quickshell
import Quickshell.Widgets
import QtQuick

WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter

  WrapperMouseArea {
    anchors.fill: parent
    Text {
      color: "white"
      font.pixelSize: 24
      text: "󰐥"
    }
  }
}
