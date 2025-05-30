import "root:/settings"
import QtQuick
import Quickshell.Widgets

IconImage {
  property real size: Appearance.font.pixelSize.normal
  readonly property string iconFolder: "root:/assets/icons"
  implicitSize: size
  asynchronous: true
}
