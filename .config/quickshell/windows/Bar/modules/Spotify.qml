import "root:/widgets"
import "root:/state"
import "root:/services"
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts

WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter
  visible: MediaController.spotify.active
  readonly property string trackInfo: MediaController.spotify.trackInfoStr

  RowLayout {
    IconImage {
      implicitSize: Appearance.sizes.icons.normal
      source: MediaController.spotify.icon
    }
    WrapperMouseArea {
      acceptedButtons: Qt.LeftButton | Qt.RightButton
      onClicked: () => {
        Hyprland.dispatch("global quickshell:mediaControlsToggle")
      }
      StyledText {
        text: trackInfo.length > 30 ? trackInfo.slice(0, 30) + "..." : trackInfo
      }
    }
  }
}
