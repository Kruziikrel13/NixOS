import "./modules"
import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

Scope {
  id: bar
  readonly property int barHeight: 32
  readonly property string bgColor: "#171717"
  readonly property string fontColor: "#C4C4C4"
  readonly property string fontSecondary: "#525252"
  readonly property string fontTertiary: "#414141"

  Variants {
    model: Quickshell.screens

    PanelWindow{
      id: barRoot

      property ShellScreen modelData
      screen: modelData

      WlrLayershell.namespace: "quickshell:bar"
      exclusiveZone: barHeight - 1
      implicitHeight: barHeight
      color: bgColor

      anchors {
        top: true
        left: true
        right: true
      }

      RowLayout {
        id: modulesLeft
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        
        Text {
          color: "white"
          text: "Left"
        }
      }

      RowLayout {
        id: modulesCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Text {
          color: "white"
          text: "Center"
        }
      }

      RowLayout {
        id: modulesRight
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 10

        Text {
          color: "white"
          text: "Right"
        }
      }
    }
  }
}
