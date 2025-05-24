import Quickshell
import Quickshell.Widgets
import QtQuick

WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter
  property string os: "generic"
  property string osIconFolder: "root:/assets/icons/os"

  IconImage {
    anchors.centerIn: parent
    implicitSize: 20
    source: {
      if (osIconFolder && osIconFolder + "/" + root.os + ".svg") {
        return osIconFolder + "/" + root.os + ".svg"
      }
    }
  }
}
