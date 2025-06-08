import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton
pragma ComponentBehavior: Bound

/**
 * System Information: Automated!
 * Borrowed heavily from https://github.com/end-4/dots-hyprland/blob/ii-qs/.config/quickshell/services/SystemInfo.qml
 */ 

Singleton {
  property string distroName: "Unknown"
  property string distroId: "unknown"
  property string distroIcon: "linux-symbolic"
  property string uptime: "unknown"
  property string username: "user"

  Timer {
    triggeredOnStart: true
    interval: 1
    running: true
    repeat: false
    onTriggered: {
      getUsername.running = true
      fileOsRelease.reload()
      const textOsRelease = fileOsRelease.text()

      // Will assume for now that these always return successfully
      const prettyNameMatch = textOsRelease.match(/^PRETTY_NAME="(.+?)"/m)
      distroName = prettyNameMatch && prettyNameMatch[1]

      const idMatch = textOsRelease.match(/^ID=(.+?)$/m)
      distroId = idMatch && idMatch[1]

      switch (distroId) {
        case "nixos": distroIcon = "nixos-symbolic"; break;
        case "arch": distroIcon = "arch-symbolic"; break;
        case "ubuntu": distroIcon = "ubuntu-symbolic"; break;
        default: distroIcon = "linux-symbolic"; break;
      }

      fileUptime.reload()
      const textUptime = fileUptime.text()
    }
  }

  function getIcon() {
    const iconsFolder = "root:/assets/icons/os/"
    return iconsFolder + distroIcon
  }

  Process {
    id: getUsername
    command: ["whoami"]
    stdout: SplitParser {
      onRead: data => {
        username = data.trim()
      }
    }
  }

  FileView {
    id: fileUptime
    path: "/proc/uptime"
  }

  FileView {
    id: fileOsRelease
    path: "/etc/os-release"
  }
}
