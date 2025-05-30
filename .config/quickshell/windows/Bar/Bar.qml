import "root:/settings"
import "./components"
import "./modules"
import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

Scope {
  id: bar
  readonly property int barHeight: Appearance.sizes.barHeight

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: barRoot
      screen: modelData

      property ShellScreen modelData

      WlrLayershell.namespace: "quickshell:bar"
      exclusiveZone: barHeight - 1
      implicitHeight: barHeight
      color: Appearance.colors.background

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
            OsIcon {}
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
            // Notifications {}
            // Separator {}
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
            Pipewire {}
            Network {}
            Separator {}
            Tray { bar: barRoot }
          }
        }
      }
    }
  }
}
