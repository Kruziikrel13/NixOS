import "root:/settings"
import QtQuick
import QtQuick.Layouts

Text {
  readonly property color defaultColor: Appearance.colors.fontPrimary
  renderType: Text.NativeRendering
  font.hintingPreference: Font.PreferFullHinting
  font.family: Appearance.font.family.main
  font.pixelSize: Appearance.font.pixelSize.normal
  color: defaultColor
}
