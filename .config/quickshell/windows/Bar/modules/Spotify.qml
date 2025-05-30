import "root:/widgets"
import "root:/state"
import "root:/services"
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter
  visible: MediaController.spotify.active
  property bool showPopup: false
  readonly property string trackInfo: MediaController.spotify.trackInfoStr

  Timer {
    id: popupCloseTimer
    interval: 200
    repeat: false
    running: false
    onTriggered: {
      showPopup = false
    }
  }

  RowLayout {
    ClippingWrapperRectangle {
      visible: !!MediaController.spotify.trackIcon
      radius: icon.width / 2
      IconImage {
        id: icon
        implicitSize: Appearance.sizes.icons.large
        source: MediaController.spotify.trackIcon
      }
    }
    WrapperMouseArea {
      id: mArea
      hoverEnabled: true
      onEntered: () => {
        showPopup = true;
      }
      onExited: () => {
        popupCloseTimer.restart()
      }
      StyledText {
        text: trackInfo.length > 30 && !parent.containsMouse ? trackInfo.slice(0, 30) + "..." : trackInfo
      }
    }
  }

  LazyLoader {
    id: popupLoader
    active: showPopup
    PanelWindow {
      id: mediaPopup
      visible: popupLoader.active
      anchors.top: true
      margins.top: 5
      color: "transparent"
      implicitHeight: 100
      implicitWidth: 300

      Rectangle {
        anchors.fill: parent
        radius: parent.height / 4
        color: Appearance.paletteColours.background
        RowLayout {
          id: row
          anchors.fill: parent
          anchors.margins: 10
          spacing: 15
          ClippingWrapperRectangle {
            visible: !!MediaController.spotify.trackIcon
            radius: parent.height / 4
            IconImage {
              id: popupIcon
              implicitSize: mediaPopup.height - 20
              source: MediaController.spotify.trackIcon
            }
          }
          ColumnLayout {
            Layout.alignment: Qt.AlignTop
            StyledText {
              Layout.fillWidth: true
              text: MediaController.spotify.player.trackArtist
              wrapMode: Text.Wrap
              font.weight: Font.Bold
            }
            StyledText {
              Layout.fillWidth: true
              wrapMode: Text.Wrap
              text: MediaController.spotify.player.trackTitle
            }

            Rectangle {
              Layout.fillWidth: true
              Layout.fillHeight: true
              Layout.bottomMargin: 5
              color: "transparent"

              Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                color: Appearance.paletteColours.tertiary
                height: 5
                Rectangle {
                  anchors.bottom: parent.bottom
                  anchors.top: parent.top
                  anchors.left: parent.left
                  color: Appearance.paletteColours.primary
                  implicitWidth: parent.width * (MediaController.spotify.player.position / MediaController.spotify.player.length)
                }
              }
            }
          }
        }
      }
    }
  }
}
