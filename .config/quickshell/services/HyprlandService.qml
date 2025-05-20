pragma Singleton
// pragma ComponentBehaviour: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

Singleton {
  id: root

  property var windowList: []
  property var addresses: []
  property var windowByAddress: ({})

  function updateWindowList() {
    Hyprland.refreshWorkspaces();
    Hyprland.refreshMonitors();
    getClients.running = true;
  }

  Component.onCompleted: {
    updateWindowList();
  }

  Connections {
    target: Hyprland

    function onRawEvent(event) {
      if (event in [
        "activewindow", "focusedmon", "monitoradded", 
        "createworkspace", "destroyworkspace", "moveworkspace", 
        "activespecial", "movewindow", "windowtitle"
      ]) return;
      updateWindowList();
    }
  }

  Process {
    id: getClients
    command: ["bash", "-c", "hyprctl clients -j | jq -c"]
    stdout: SplitParser {
      onRead: (data) => {
        console.log("Getting clients")
        root.windowList = JSON.parse(data);
        let tempWinByAddr = {};
        for (var i = 0; i < root.windowList.length; ++i) {
          var win = root.windowList[i];
          tempWinByAddr[win.address] = win;
        }

        root.windowByAddress = tempWinByAddr;
        root.addresses = root.windowList.map((win) => win.address)
      }
    }
  }

  // Process {
  //   id: getWorkspaces
  //   command: ["bash", "-c", "hyprctl workspaces -j | jq -c"]
  //   stdout: SplitParser {
  //     onRead: (data) => {
  //       data = JSON.parse(data);
  //       for (let i = 0; i < data.length; i++) {
  //         print(JSON.stringify(data[i]));
  //       }
  //       root.workspaceList = data;
  //     }
  //   }
  // }
}
