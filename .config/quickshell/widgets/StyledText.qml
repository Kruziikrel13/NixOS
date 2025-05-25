import "root:/state"
import QtQuick
import QtQuick.Layouts

Text {
  readonly property color defaultColor: Appearance.paletteColours.fontPrimary
  renderType: Text.NativeRendering
  font.hintingPreference: Font.PreferFullHinting
  font.family: Appearance.font.family.main
  font.pixelSize: Appearance.font.pixelSize.normal
  color: defaultColor
}
