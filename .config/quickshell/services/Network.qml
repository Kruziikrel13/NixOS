import Quickshell
import Quickshell.Io
import QtQuick
pragma Singleton

Singleton {
  id: root
  property int updateInterval: 1000
  property int networkType: 0
  function update() {
    updateNetworkType.running = true
  }
  Timer {
    interval: 10
    running: true
    repeat: true
    onTriggered: {
      update()
      interval = root.updateInterval
    }
  }

  Process {
    id: updateNetworkType
    running: true
    command: ["bash", "-c", "nmcli device status | grep connected | grep -v 'loopback' | cut -d ' ' -f 3"]
    stdout: SplitParser {
      onRead: (data) => {
        switch (data) {
          case "ethernet":
            root.networkType = 1
            break;
          case "wifi":
            root.networkType = 2
            break;
          default:
            root.networkType = 0
            break;
        }
      }
    }
  }
}
