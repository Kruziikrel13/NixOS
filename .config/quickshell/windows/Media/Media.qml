import "root:/services"
import "root:/widgets"
import "root:/state"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
  id: root

  LazyLoader {
    id: mediaLoader
    active: false

    PanelWindow {
      id: mediaRoot
      visible: mediaLoader.active

      exclusionMode: ExclusionMode.Normal
      WlrLayershell.namespace: "quickshell:mediaController"
      WlrLayershell.layer: WlrLayer.Overlay

      color: "transparent"
      anchors.top: true
      margins.top: 5
      height: 150
      width: 550


      mask: Region {
        item: container
      }

      Rectangle {
        id: container
        anchors.fill: parent
        color: Appearance.paletteColours.background
        radius: 10

        RowLayout {
          anchors.fill: parent
          anchors.margins: 10
          Layout.fillHeight: true
          Image {
            visible: !!MediaController.spotify.trackIcon
            source: MediaController.spotify.trackIcon
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter
            Layout.fillHeight: true
            sourceSize.height: parent.height
          }
          ColumnLayout {
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            StyledText {
              Layout.fillWidth: true
              font.weight: Font.Bold
              font.pixelSize: 32
              text: MediaController.spotify.player.trackArtist
            }
            StyledText {
              Layout.fillWidth: true
              font.pixelSize: 23
              wrapMode: Text.Wrap
              text: MediaController.spotify.player.trackTitle
            }

            Rectangle {
              anchors.left: parent.left
              anchors.right: parent.right
              height: 5
              radius: 10
              color: Appearance.paletteColours.tertiary

              Rectangle {
                anchors {
                  top: parent.top
                  bottom: parent.bottom
                  left: parent.left
                }
                color: Appearance.paletteColours.primary
                implicitWidth: parent.width * (MediaController.spotify.player.position / MediaController.spotify.player.length)
                radius: parent.radius
              }
            }
          }
        }
      }
    }
  }

  GlobalShortcut {
    name: "mediaControlsToggle"
    onPressed: {
      if (!MediaController.spotify.active) {
        return;
      }

      mediaLoader.active = !mediaLoader.active
    }
  }

  GlobalShortcut {
    name: "mediaControlsOpen"
    onPressed: {
      mediaLoader.active = true
    }
  }

  GlobalShortcut {
    name: "mediaControlsClose"
    onPressed: {
      mediaLoader.active = false
    }
  }
}
