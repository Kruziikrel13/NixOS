import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Io


WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter
  property var activeWindow: ""

  Component.onCompleted: {
    getClient.running = true;
  }

  Connections {
    target: Hyprland

    function onRawEvent(event) {
      switch (event.name) {
        case "activewindowv2":
        case "closewindow":
          getClient.running = true;
          break;
        case "openwindowv2":
          activeWindow = event.parse(4)[3];
          break;
      }
    }
  }

  Text {
    color: "white"
    font.pixelSize: 15
    text: activeWindow
  }

  Process {
    id: getClient
    command: ["bash", "-c", "hyprctl activewindow -j | jq -c"]
    stdout: SplitParser {
      onRead: (data) => {
        let client = JSON.parse(data)
        root.activeWindow = client.initialTitle
      }
    }
  }
}
