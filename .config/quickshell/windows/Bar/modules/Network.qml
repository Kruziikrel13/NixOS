import "root:/state"
import "root:/widgets"
import "root:/services"
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick

WrapperItem {
  anchors.verticalCenter: parent.verticalCenter

  Process {
    id: network
    command: ["ghostty", "-e", "nmtui"]
  }
  WrapperMouseArea {
    id: mouseArea
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    hoverEnabled: true
    onClicked: (event) => {
      switch (event.button) {
        case Qt.RightButton:
        case Qt.LeftButton:
        network.running = true
        break;
      }
      event.accepted = true
    }
    StyledText {
      color: mouseArea.containsMouse ? Appearance.paletteColours.primary : defaultColor
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
