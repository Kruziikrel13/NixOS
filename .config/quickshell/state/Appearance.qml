import QtQuick
import Quickshell
pragma Singleton

Singleton {
  id: root
  property QtObject paletteColours
  property QtObject font
  property QtObject sizes
  readonly property string iconFolder: "root:/assets/icons/"

  paletteColours: QtObject {
    property color background: "#171717"
    property color primary: "#51A4E7"
    property color fontPrimary: "#FFFFFF"
    property color onbackground: "#C4C4C4"
    property color secondary: "#525252"
    property color tertiary: "#414141"
    property color urgent: "#95435B"
    property color warning: "#EBFF71"
    property color green: "#1ED760"
  }

  font: QtObject {
    property QtObject family: QtObject {
      property string main: "NotoSans Nerd Font Propo"
      property string monospace: "Jetbrains Mono Nerd Font"
      property string icons: "NotoSans Nerd Font Mono"
    }
    property QtObject pixelSize: QtObject {
      property int smallest: 7
      property int smaller: 12
      property int normal: 16
      property int large: 18
      property int larger: 22
      property int title: 28
    }
  }


  sizes: QtObject {
    property real barHeight: 40
    property real osdWidth: 900
    property real launchWidth: 900
    property real powerWidth: 435
    property QtObject icons: QtObject {
      property real smallest: 12
      property real small: 15
      property real normal: root.font.pixelSize.normal
      property real large: 24
    }
  }
}
