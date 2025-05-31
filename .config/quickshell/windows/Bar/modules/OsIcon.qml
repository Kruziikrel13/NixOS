import "root:/settings"
import "root:/services"
import "root:/widgets"

CustomIcon {
  size: Appearance.font.pixelSize.larger
  source: SystemInfo.getIcon()
}
