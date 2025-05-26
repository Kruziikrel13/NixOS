import "root:/widgets"
import "root:/services"
import "root:/state"
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick

WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter

  Process {
    id: pulsemixer
    command: ["ghostty", "-e", "pulsemixer"]
  }

  Process {
    id: mute
    command: ["bash", "-c", `wpctl set-mute ${Audio.sink?.id} toggle`]
  }

  WrapperMouseArea {
    id: mouseArea
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    hoverEnabled: true
    onClicked: (event) => {
      switch (event.button) {
        case Qt.LeftButton:
        mute.running = true
        break;
        case Qt.RightButton:
        pulsemixer.running = true
        break;
      }
      event.accepted = true
    }

    StyledText {
      color: mouseArea.containsMouse ? Appearance.paletteColours.primary : defaultColor
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
