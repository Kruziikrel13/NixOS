import "root:/state"
import Quickshell
import Quickshell.Widgets
import QtQuick

WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter
  readonly property string osIcon: Appearance.iconFolder + "os/" + ConfigOptions.operatingSystem + ".svg"

  IconImage {
    anchors.centerIn: parent
    implicitSize: Appearance.sizes.icons.normal
    source: osIcon
  }
}
