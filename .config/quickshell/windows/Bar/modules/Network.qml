import Quickshell
import Quickshell.Widgets
import QtQuick

WrapperItem {
  anchors.verticalCenter: parent.verticalCenter

  WrapperMouseArea {
    anchors.fill: parent
    Text {
      color: "white"
      font.pixelSize: 16
      text: ""
    }
  }
}
