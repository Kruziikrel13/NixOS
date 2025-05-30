import "root:/widgets"
import "root:/settings"
import "root:/services"
import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

WrapperItem {
  id: root
  property bool showPopup: false
  readonly property string trackInfo: MediaController.spotify.getTrackInfo(50)

  anchors.verticalCenter: parent.verticalCenter
  visible: MediaController.spotify.active


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
    spacing: 10
    ClippingWrapperRectangle {
      visible: !!MediaController.spotify.trackIcon
      radius: icon.width / 4
      CustomIcon {
        id: icon
        size: Appearance.font.pixelSize.large
        source: MediaController.spotify.trackIcon
        mipmap: true
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
        text: trackInfo
      }
    }
  }

  LazyLoader {
    id: loader
    active: showPopup

    PanelWindow {
      id: popup
      anchors.top: true
      margins.top: 10
      visible: loader.active
      color: "transparent"
      implicitWidth: Appearance.sizes.mediaWidth
      implicitHeight: width / 2

      FrameAnimation {
        running: MediaController.spotify.playing
        onTriggered: MediaController.spotify.player.positionChanged()
      }

      StyledShadow {
        target: background
      }

      WrapperRectangle {
        id: background
        anchors.left: parent.left
        anchors.right: parent.right
        color: Appearance.colors.background
        border.color: Appearance.colors.primary
        radius: height / 4
        margin: 15
        RowLayout {
          spacing: 15
          Layout.fillWidth: true

          ClippingWrapperRectangle {
            visible: !!MediaController.spotify.trackIcon
            radius: implicitHeight / 4
            Image {
              source: MediaController.spotify.trackIcon
              asynchronous: true
              sourceSize.height: 64
              sourceSize.width: 64
            }
          }

          ColumnLayout {
            RowLayout {
              visible: !!MediaController.spotify.trackArtist
              Layout.fillWidth: true
              StyledText {
                text: MediaController.spotify.trackArtist
                font.weight: Font.Bold
              }
            }
            RowLayout {
              StyledText {
                Layout.fillWidth: true
                Layout.maximumHeight: 20
                text: MediaController.spotify.trackTitle
                wrapMode: Text.Wrap
                elide: Text.ElideRight
              }

              // StyledText {
              //   text: {
              //     const position = MediaController.spotify.player.position
              //     const minutes = Math.floor(position / 60);
              //     const remainingSeconds = Math.floor(position % 60);
              //     return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
              //   }
              // }
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
