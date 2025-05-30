import "root:/settings"
import "root:/widgets"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets

Scope {
  id: root
  property bool showMenu: false

  GlobalShortcut {
    name: "powerMenuToggle"
    onPressed: {
      showMenu = !showMenu
    }
  }

  GlobalShortcut {
    name: "powerMenuClose"
    onPressed: {
      showMenu = false
    }
  }

  GlobalShortcut {
    name: "powerMenuOpen"
    onPressed: {
      showMenu = true
    }
  }

  

  LazyLoader {
    id: loader
    active: showMenu

    PanelWindow {
      id: popup
      visible: loader.active
      margins.top: 10
      margins.right: 10
      anchors.right: true
      anchors.top: true
      color: "transparent"
      implicitWidth: Appearance.sizes.powerWidth - 150
      implicitHeight: width / 2




      WrapperRectangle {
        id: background
        anchors.fill: parent
        color: Appearance.colors.background
        radius: height / 8
        margin: 10
        RowLayout {
          Layout.fillHeight: true
          Layout.fillWidth: true

          ClippingWrapperRectangle {
            radius: implicitHeight / 4
            implicitHeight: parent.height
            Image {
              source: "root:/assets/profile"
              sourceSize.height: parent.height
            }
          }

          ColumnLayout {
            Layout.fillWidth: true
            RowLayout {
              spacing: 15
              Layout.fillWidth: true
              Layout.fillHeight: true
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
                  source: "root:/assets/icons/os/nixos"
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
                  text: ConfigOptions.username
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
                    reboot.running = true;
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
                  Process {
                    id: reboot
                    command: [ "systemctl", "reboot" ]
                  }
                }
                WrapperMouseArea {
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                  hoverEnabled: true
                  onClicked: () => {
                    logout.running = true
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
                  Process {
                    id: logout
                    running: false
                    command: [ "uwsm", "stop" ]
                  }
                }
                WrapperMouseArea {
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                  hoverEnabled: true
                  onClicked: () => {
                    lock.running = true
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
                  Process {
                    id: lock
                    running: false
                    command: [ "loginctl", "lock-session" ]
                  }
                }
                WrapperMouseArea {
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                  hoverEnabled: true
                  onClicked: () => {
                    powerOff.running = true
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
                  Process {
                    id: powerOff
                    running: false
                    command: [ "systemctl", "-i", "poweroff" ]
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
