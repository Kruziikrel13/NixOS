import "root:/services"
import QtQuick
import Quickshell.Widgets

ClippingWrapperRectangle {
  required property real targetHeight
  radius: 25
  Image {
    source: `/home/${SystemInfo.username}/Pictures/profile.png`
    sourceSize.height: targetHeight
    mipmap: true
  }
}
