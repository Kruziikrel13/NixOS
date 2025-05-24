import "root:/state"
import QtQuick
import QtQuick.Layouts

Text {
  renderType: Text.NativeRendering
  font.hintingPreference: Font.PreferFullHinting
  font.family: Appearance.font.family.main
  font.pixelSize: Appearance.font.pixelSize.normal
  color: Appearance.paletteColours.fontPrimary
}
