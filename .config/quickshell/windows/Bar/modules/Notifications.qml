import "root:/widgets"
import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

WrapperItem {
  anchors.verticalCenter: parent.verticalCenter

  RowLayout {
    anchors.fill: parent
    spacing: 2.5
    StyledText {
      font.pixelSize: 12
      text: "4"
    }

    StyledText {
      font.pixelSize: 16
      text: "󰂚"
    }
  }
}
