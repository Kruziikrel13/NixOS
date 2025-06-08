import "root:/widgets"
import "root:/settings"
import "root:/services"
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

Scope {
  id: root

  GlobalShortcut {
    name: "mediaControlToggle"
    onPressed: loader.active = !loader.active
  }

  LazyLoader {
    id: loader
    active: false

    PanelWindow {
      id: popup
      anchors.top: true
      margins.top: 5
      visible: loader.active
      color: "transparent"
      implicitWidth: Appearance.sizes.mediaWidth
      WlrLayershell.namespace: "quickshell:media"

      HyprlandFocusGrab {
        id: grab
        windows: [ popup ]
        active: loader.active
        onCleared: () => {
          if (!active) loader.active = false
        }
      }

      StyledShadow {
        target: background
      }

      FrameAnimation {
        running: MediaController.spotify.playing
        onTriggered: MediaController.spotify.player.positionChanged()
      }


      WrapperRectangle {
        id: background
        anchors.fill: parent
        radius: height / 8
        color: Appearance.colors.background
        margin: 15

        RowLayout {
          id: content
          spacing: 10
          ClippingWrapperRectangle {
            visible: !!MediaController.spotify.trackIcon
            radius: height / 4
            Image {
              sourceSize.height: content.height
              source: MediaController.spotify.trackIcon
              cache: true
            }
          }

          ColumnLayout {
            WrapperMouseArea {
              hoverEnabled: true
              visible: !!MediaController.spotify.trackArtist
              onClicked: Hyprland.dispatch(`focuswindow class:spotify`)
              StyledText {
                text: MediaController.spotify.trackArtist
                color: parent.containsMouse ? Appearance.colors.primary : defaultColor
                font.weight: Font.Bold
                Layout.fillWidth: true
              }
            }
            RowLayout {
              visible: !!MediaController.spotify.trackTitle
              Layout.fillWidth: true
              StyledText {
                Layout.fillWidth: true
                Layout.maximumHeight: 20
                text: MediaController.spotify.trackTitle
                wrapMode: Text.Wrap
                elide: Text.ElideRight
              }

              WrapperMouseArea {
                hoverEnabled: true
                onClicked: MediaController.spotify.player.previous()
                StyledText {
                  text: ""
                  font.family: Appearance.font.family.icons
                  color: parent.containsMouse ? Appearance.colors.primary : defaultColor
                }
              }

              WrapperMouseArea {
                hoverEnabled: true
                onClicked: MediaController.spotify.player.togglePlaying()
                StyledText {
                  text: MediaController.spotify.playing ? '' : ''
                  color: parent.containsMouse ? Appearance.colors.primary : defaultColor
                  font.family: Appearance.font.family.icons
                }
              }

              WrapperMouseArea {
                hoverEnabled: true
                onClicked: MediaController.spotify.player.next()
                StyledText {
                  text: ""
                  font.family: Appearance.font.family.icons
                  color: parent.containsMouse ? Appearance.colors.primary : defaultColor
                }
              }
            }
            Rectangle {
              Layout.fillWidth: true
              color: Appearance.colors.tertiary
              height: 5
              radius: height / 2

              Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                color: Appearance.colors.primary
                implicitWidth: parent.width * (MediaController.spotify.player.position / MediaController.spotify.player.length)
                radius: parent.radius
              }
            }
          }
        }
      }
    }
  }
}
