import QtQuick
import Quickshell
pragma Singleton

Singleton {
  id: root
  property QtObject osd: QtObject {
    property int timeout: 1000
  }

  property QtObject spotify: QtObject {
    property int maxLength: 30
  }
}
