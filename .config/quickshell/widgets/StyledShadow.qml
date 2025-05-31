import "root:/settings"
import QtQuick.Effects

RectangularShadow {
  required property var target
  anchors.fill: target
  radius: target.radius
  blur: 1.2 * 8
  spread: 1
  color: Appearance.colors.background
  cached: true
}
