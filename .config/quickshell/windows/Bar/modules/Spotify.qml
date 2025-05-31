import "root:/widgets"
import "root:/settings"
import "root:/services"
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

WrapperItem {
  id: root
  property bool showPopup: false
  readonly property string trackInfo: MediaController.spotify.getTrackInfo(50)

  visible: MediaController.spotify.active

  WrapperMouseArea {
    id: mouseArea
    hoverEnabled: true
    onClicked: Hyprland.dispatch('global quickshell:mediaControlToggle')
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
      StyledText {
        text: trackInfo
        color: mouseArea.containsMouse ? Appearance.colors.primary : defaultColor
      }
    }
  }
}
