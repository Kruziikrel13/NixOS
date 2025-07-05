import "root:/settings"
import "root:/widgets"
import "root:/services"
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick

WrapperItem {
  anchors.verticalCenter: parent.verticalCenter

  WrapperMouseArea {
    id: mouseArea
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    hoverEnabled: true
    onClicked: (event) => {
      switch (event.button) {
        case Qt.RightButton:
        case Qt.LeftButton:
        Quickshell.execDetached(["ghostty", "--class=ghostty.tui", "-e", "sleep 0.5; nmtui"])
        break;
      }
      event.accepted = true
    }
    StyledText {
      color: mouseArea.containsMouse ? Appearance.colors.primary : defaultColor
      text: {
        switch (Network.networkType) {
          case 1:
            return ""
          case 2:
            return ""
          default:
            return " "
        }
      }
    }
  }
}
