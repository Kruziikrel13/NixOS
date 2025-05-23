import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
  id: root
  readonly property string bgColor: "#171717"
  readonly property string fontColor: "#C4C4C4"
  readonly property string fontSecondary: "#525252"

  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink ]
  }

  Connections {
    target: Pipewire.defaultAudioSink?.audio

    function onVolumeChanged() {
      root.shouldShowOsd = true;
      hideTimer.restart()
    }
  }

  property bool shouldShowOsd: false

  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: root.shouldShowOsd = false
  }

  LazyLoader {
    active: root.shouldShowOsd

    PanelWindow {
      anchors.bottom: true
      margins.bottom: screen.height / 5

      implicitWidth: 300
      implicitHeight: 50
      color: "transparent"

      mask: Region {}

      Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: bgColor

        RowLayout {
          anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 15
          }

          Text {
            color: fontColor
            font.pixelSize: 30
            text: {
              const volume = Pipewire.defaultAudioSink?.audio.volume ?? 0
              let icon = ""

              if (Pipewire.defaultAudioSink?.audio.muted || volume <= 0) {
                icon = ""
              }

              if (volume > 0 && volume <= 0.2) {
                icon = ""
              } else if (volume > 0.2 && volume <= 0.45) {
                icon = ""
              } else if (volume > 0.45) {
                icon = ""
              }

              return icon
            }
          }

          Rectangle {
            Layout.fillWidth: true
            anchors.verticalCenter: parent.verticalCenter

            implicitHeight: 10
            radius: 20
            color: fontSecondary

            Rectangle {
              anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
              }
              color: fontColor
              implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
              radius: parent.radius
            }
          }
        }
      }
    }
  }
}
