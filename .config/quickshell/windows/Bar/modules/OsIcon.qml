import "root:/settings"
import "root:/widgets"

CustomIcon {
  readonly property string osIcon: Appearance.iconFolder + "os/" + ConfigOptions.operatingSystem
  size: Appearance.font.pixelSize.larger
  source: osIcon
}
