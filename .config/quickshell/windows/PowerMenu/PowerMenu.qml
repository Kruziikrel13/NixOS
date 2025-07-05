import "root:/settings"
import "root:/services"
import "root:/widgets"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Widgets
import "./components"

Scope {
  id: root

  GlobalShortcut {
    name: "powerMenuToggle"
    onPressed: {
      loader.active = !loader.active
    }
  }

  GlobalShortcut {
    name: "powerMenuClose"
    onPressed: {
      loader.active = false
    }
  }

  GlobalShortcut {
    name: "powerMenuOpen"
    onPressed: {
      loader.active = true
    }
  }

  LazyLoader {
    id: loader
    active: false

    PanelWindow {
      id: popup
      anchors {
        top: true
        right: true
      }
      margins {
        top: 5
        right: 5
      }
      visible: loader.active
      color: "transparent"
      implicitWidth: Appearance.sizes.powerWidth - 150
      implicitHeight: width / 2

      WlrLayershell.namespace: "quickshell:powermenu"

      WrapperRectangle {
        id: background
        anchors.fill: parent
        color: Appearance.colors.background
        radius: height / 8
        margin: 10

        RowLayout {
          id: content
          spacing: 10
          Profile {
            targetHeight: content.height
          }
          ColumnLayout {
            RowLayout {
              spacing: 15
              Layout.fillWidth: true
              Rectangle {
                radius: height / 8
                implicitHeight: 64
                implicitWidth: 64 + 32
                color: "#373737"
                StyledText {
                  anchors.centerIn: parent
                  font.family: Appearance.font.family.icons
                  font.pixelSize: 48
                  text: ""
                }
              }
              Rectangle {
                radius: height / 8
                implicitHeight: 64
                implicitWidth: 64 + 32
                color: "#373737"
                CustomIcon {
                  anchors.fill: parent
                  source: SystemInfo.getIcon()
                }
              }
              Rectangle {
                radius: height / 8
                Layout.fillWidth: true
                implicitHeight: 64
                color: "#242424"
                StyledText {
                  anchors.centerIn: parent
                  font.pixelSize: 24
                  text: SystemInfo.username
                }
              }
            }
            WrapperRectangle {
              Layout.alignment: Qt.AlignCenter
              Layout.fillWidth: true
              color: "#242424"
              radius: height / 8
              margin: 10
              implicitHeight: 128
              RowLayout {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 15
                Rectangle {
                  radius: height / 8
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                  color: "#373737"
                }
                Rectangle {
                  radius: height / 8
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                  color: "#373737"
                }
                Rectangle {
                  radius: height / 8
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                  color: "#373737"
                }
                Rectangle {
                  radius: height / 8
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                  color: "#373737"
                }
              }
            }
            WrapperRectangle {
              Layout.alignment: Qt.AlignCenter
              Layout.fillWidth: true
              color: "#242424"
              radius: height / 8
              margin: 10
              implicitHeight: 128
              RowLayout {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 15
                WrapperMouseArea {
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                  hoverEnabled: true
                  onClicked: () => {
                    Quickshell.execDetached(["systemctl", "-i", "reboot"])
                  }
                  Rectangle {
                    radius: height / 8
                    color: parent.containsMouse ? Appearance.colors.primary : "#373737"
                    Behavior on color {
                      ColorAnimation {
                        duration: 200
                      }
                    }
                    StyledText {
                      anchors.centerIn: parent
                      font.pixelSize: 32
                      font.family: Appearance.font.family.icons
                      text: "󰜉"
                    }
                  }
                }
                WrapperMouseArea {
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                  hoverEnabled: true
                  onClicked: () => {
                    Quickshell.execDetached(["uwsm", "stop"])
                  }
                  Rectangle {
                    radius: height / 8
                    color: parent.containsMouse ? Appearance.colors.primary : "#373737"
                    Behavior on color {
                      ColorAnimation {
                        duration: 200
                      }
                    }
                    StyledText {
                      anchors.centerIn: parent
                      font.pixelSize: 32
                      font.family: Appearance.font.family.icons
                      text: ""
                    }
                  }
                }
                WrapperMouseArea {
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                  hoverEnabled: true
                  onClicked: () => {
                    Quickshell.execDetached(["loginctl", "lock-session"])
                  }
                  Rectangle {
                    radius: height / 8
                    color: parent.containsMouse ? Appearance.colors.primary : "#373737"
                    Behavior on color {
                      ColorAnimation {
                        duration: 200
                      }
                    }
                    StyledText {
                      anchors.centerIn: parent
                      font.pixelSize: 32
                      font.family: Appearance.font.family.icons
                      text: ""
                    }
                  }
                }
                WrapperMouseArea {
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                  hoverEnabled: true
                  onClicked: () => {
                    Quickshell.execDetached(["systemctl", "-i", "poweroff"])
                  }
                  Rectangle {
                    radius: height / 8
                    color: parent.containsMouse ? Appearance.colors.primary : "#373737" 
                    Behavior on color {
                      ColorAnimation {
                        duration: 200
                      }
                    }
                    StyledText {
                      anchors.centerIn: parent
                      font.pixelSize: 32
                      font.family: Appearance.font.family.icons
                      text: ""
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
