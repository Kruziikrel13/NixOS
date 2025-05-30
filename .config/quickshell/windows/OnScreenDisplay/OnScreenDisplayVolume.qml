import "root:/services"
import "root:/settings"
import "root:/widgets"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland

Scope {
  id: root
  property bool showOsdValues: false

  function triggerOsd() {
    showOsdValues = true
    osdTimeout.restart()
  }

  Timer {
    id: osdTimeout
    interval: ConfigOptions.osd.timeout
    repeat: false
    running: false
    onTriggered: {
      showOsdValues = false
    }
  }

  Connections {
    target: Audio.sink?.audio ?? null
    function onVolumeChanged() {
      if (!Audio.ready) return
      root.triggerOsd()
    }
    function onMutedChanged() {
      if (!Audio.ready) return
      root.triggerOsd()
    }
  }

  LazyLoader {
    id: osdLoader
    active: showOsdValues

    PanelWindow {
      id: osdRoot

      exclusionMode: ExclusionMode.Normal
      WlrLayershell.namespace: "quickshell:onScreenDisplay"
      WlrLayershell.layer: WlrLayer.Overlay
      anchors.bottom: true
      // margins.bottom: osdRoot.screen.height / 3
      margins.bottom: 300
      color: "transparent"

      mask: Region {}

      // implicitWidth: osdRoot.screen.width / 3
      implicitWidth: 600
      implicitHeight: 90
      visible: osdLoader.active

      Rectangle {
        anchors.fill: parent
        radius: height / 4
        color: Appearance.colors.background
        border {
          color: Appearance.colors.primary
        }

        Rectangle {
          anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
          }
          color: Appearance.colors.primary
          implicitWidth: parent.width * (Audio.sink?.audio.volume ?? 0)
          radius: parent.radius

          Behavior on implicitWidth {
            NumberAnimation {
              duration: 50
              easing.type: Easing.Linear
            }
          }

          StyledText {
            anchors.verticalCenter: parent.verticalCenter
            padding: 20
            font.pixelSize: 48
            text: {
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
              return " "
            }
          }
        }
      }
    }
  }
}
