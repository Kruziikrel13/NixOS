import "root:/widgets"
import "root:/services"
import "root:/settings"
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick

WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter

  WrapperMouseArea {
    id: mouseArea
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    hoverEnabled: true
    onClicked: (event) => {
      switch (event.button) {
        case Qt.LeftButton:
        Quickshell.execDetached(["bash", "-c", `wpctl set-mute ${Audio.sink?.id} toggle`])
        break;
        case Qt.RightButton:
        Quickshell.execDetached(["ghostty", "--class=ghostty.tui", "-e", "pulsemixer"])
        break;
      }
      event.accepted = true
    }

    StyledText {
      color: mouseArea.containsMouse ? Appearance.colors.primary : defaultColor
      text: {
        if (!Audio.ready) return ""
        const volume = Audio.sink?.audio.volume
        if (Audio.sink?.audio.muted || volume <= 0) {
          return ""
        }
        if (volume > 0 && volume <= 0.2) {
          return ""
        } else if (volume > 0.2 && volume <= 0.45) {
          return ""
        } else if (volume > 0.45) {
          return ""
        }
        // Failed to get audio info, show error
        return ""
      }
    }
  }
}
