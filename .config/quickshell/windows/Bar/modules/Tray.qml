import "root:/state"
import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

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
          source: modelData.title == "spotify" ? Appearance.iconFolder + "spotify" : modelData.icon
          asynchronous: true
          sourceSize.width: Appearance.sizes.icons.normal
          sourceSize.height: Appearance.sizes.icons.normal
        }
      }
    }
  }
}
