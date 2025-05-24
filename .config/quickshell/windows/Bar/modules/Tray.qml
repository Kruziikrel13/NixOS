import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter
  required property var bar

  RowLayout {
    spacing: 5

    Repeater {
      model: SystemTray.items

      WrapperMouseArea {
        id: mouseArea
        required property var modelData
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: (event) => {
          switch(event.button) {
            case Qt.LeftButton:
              // modelData.activate();
              break;
            case Qt.RightButton:
              if (modelData.hasMenu) menu.open()
              break;
          }
        }

        QsMenuAnchor {
          id: menu
          menu: modelData.menu
          anchor.window: bar
          anchor.rect.x: mouseArea.x + bar.width
          anchor.rect.y: mouseArea.y
          anchor.rect.height: mouseArea.height
          anchor.edges: Edges.Bottom
        }

        Image {
          id: trayIcon
          source: modelData.title == "spotify" ? "root:/assets/icons/spotify.svg" : modelData.icon
          asynchronous: true
          sourceSize.width: 20
          sourceSize.height: 20
        }
      }
    }
  }
}
