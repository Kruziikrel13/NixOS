import QtQuick
import Quickshell.Widgets

WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter
  property var target
  visible: target?.visible ?? true

  Rectangle {
    color: "#414141"
    radius: 2.5
    implicitHeight: 5
    implicitWidth: 5
  }
}
