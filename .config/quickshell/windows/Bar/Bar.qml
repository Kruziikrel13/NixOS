import "./components"
import "./modules"
import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

Scope {
  id: bar
  readonly property int barHeight: 38
  readonly property string bgColor: "#171717"
  readonly property string fontColor: "#C4C4C4"
  readonly property string fontSecondary: "#525252"
  readonly property string fontTertiary: "#414141"

  Variants {
    model: Quickshell.screens

    PanelWindow {
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
        anchors.fill: parent
        spacing: 0

        ModuleGroup {
          Row {
            padding: 12.5
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            spacing: 7.5
            OsIcon { os: "nixos" }
            Separator {}
            Workspaces {}
            Separator {}
            ActiveClient {}
          }
        }

        ModuleGroup {
          Row {
            anchors.centerIn: parent
            spacing: 10
            Notifications {}
            Separator {}
            Clock {}
            Separator {}
            Spotify {}
          }
        }

        ModuleGroup {
          Row {
            padding: 12.5
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            layoutDirection: Qt.RightToLeft
            spacing: 10
            PowerMenu {}
            Separator {}
            Network {}
            Pipewire {}
            Separator {}
            Tray { bar: barRoot }
          }
        }
      }
    }
  }
}
