import "root:/settings"
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Hyprland


WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter

  Connections {
    target: Hyprland

    function onRawEvent(event) {
      if (event in [
        "activewindow", "focusedmon", "monitoradded", 
        "createworkspace", "destroyworkspace", "moveworkspace", 
        "activespecial", "movewindow", "windowtitle"
      ]) return;
      Hyprland.refreshWorkspaces()
    }
  }

  RowLayout {
    spacing: 5

    Repeater {
      model: Hyprland.workspaces
      WrapperMouseArea {
        required property HyprlandWorkspace modelData
        onClicked: modelData.activate()
        Rectangle {
          implicitHeight: {
            if (modelData.focused || modelData.lastIpcObject.windows > 0) return Appearance.sizes.icons.normal
            return Appearance.sizes.icons.normal - (Appearance.sizes.icons.normal / 4)
          }
          implicitWidth: {
            if (modelData.focused && modelData.lastIpcObject.windows > 0) return Appearance.sizes.icons.normal * 2
            if (modelData.lastIpcObject.windows > 0) return Appearance.sizes.icons.normal
            return Appearance.sizes.icons.normal - (Appearance.sizes.icons.normal / 4)
          }
          color: {
            if (modelData.focused) return Appearance.colors.primary
            if (modelData.lastIpcObject.windows > 0) return Appearance.colors.onbackground
            return Appearance.colors.secondary
          }
          radius: modelData.focused ? 2.5 : 10
          Behavior on implicitWidth {
            NumberAnimation {
              duration: 100
              easing.type: Easing.Linear
            }
          }
          Behavior on implicitHeight {
            NumberAnimation {
              duration: 100
              easing.type: Easing.Linear
            }
          }
        }
      }
    }
  }
}
