import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

WrapperItem {
  anchors.verticalCenter: parent.verticalCenter

  RowLayout {
    anchors.fill: parent
    spacing: 2.5
    Text {
      color: "white"
      font.pixelSize: 12
      text: "4"
    }

    Text {
      color: "white"
      font.pixelSize: 16
      text: "󰂚"
    }
  }
}
