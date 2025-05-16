import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
  id: bar
  readonly property int barHeight: 32
  readonly property string bgColor: "#171717"

  Variants {
    model: Quickshell.screens

    PanelWindow{
      id: barPanel
      property ShellScreen modelData
      screen: modelData
      implicitHeight: barHeight
      color: bgColor
      anchors {
        top: true
        left: true
        right: true
      }

      RowLayout {
        id: modulesLeft
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        Text {
          color: "white"
          text: "Left"
        }
      }

      RowLayout {
        id: modulesCenter
        anchors.centerIn: parent
        Text {
          color: "white"
          text: "Center"
        }

      }

      RowLayout {
        id: modulesRight
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        Text {
          color: "white"
          text: "Right"
        }
      }
    }
  }
}
