import "root:/widgets"
import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Io


WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter
  property string activeWindow: ""
  visible: !!activeWindow

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

  StyledText {
    text: activeWindow
  }

  Process {
    id: getClient
    command: ["bash", "-c", "hyprctl activewindow -j | jq -c"]
    stdout: SplitParser {
      onRead: (data) => {
        const client = JSON.parse(data)
        if (client.initialClass == "spotify") { // Spotify behaves very poorly on linux
          root.activeWindow = "Spotify"
          return
        }

        const initialTitle = client?.initialTitle
        if (initialTitle && !initialTitle.trim()) {
          root.activeWindow = client.initialClass
          return
        }

        root.activeWindow = initialTitle ?? ""
      }
    }
  }
}
