import "root:/widgets"
import "./modules"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

Scope {
  id: bar
  readonly property int barHeight: 32

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: barRoot

      property var modelData

      screen: modelData
      WlrLayershell.namespace: "quickshell:bar"
      exclusiveZone: barHeight  - 1
      height: barHeight
      mask: Region {
        item: barContent
      }
      color: 'transparent'

      anchors {
        top: true
        left: true
        right: true
      }

      Rectangle { // Bar BG
        id: barContent
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        color: "#171717"
        height: barHeight

        RowLayout {
          id: modules_left
          anchors.left: parent.left
          implicitHeight: barHeight
          width: (barRoot.width - modules_center.width) / 2
          spacing: 10

          Rectangle {
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.leftMargin: 10

            color: 'transparent'
            implicitWidth: distroIcon.width + 5*2
            implicitHeight: distroIcon.height + 5*2

            CustomIcon {
              id: distroIcon
              anchors.centerIn: parent
              width:24
              height: 24
              source: "nixos"
            }
          }

          ActiveWindow {
            Layout.fillWidth: true;
            bar: barRoot
          }

        }

        RowLayout {
          id: modules_center
          anchors.centerIn: parent
          spacing: 8
        }

        RowLayout {
          id: modules_right
          anchors.right: parent.right
          implicitHeight: barHeight
          width: (barRoot.width - modules_center.width) / 2
          spacing: 5
          layoutDirection: Qt.RightToLeft
        }
      }
    }
  }
}
