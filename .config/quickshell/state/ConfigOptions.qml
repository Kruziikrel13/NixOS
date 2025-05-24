import QtQuick
import Quickshell
pragma Singleton

Singleton {
  id: root
  property string operatingSystem: "nixos"
  property QtObject osd: QtObject {
    property int timeout: 1000
  }
}
