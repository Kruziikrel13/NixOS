import "root:/widgets"
import Quickshell
import Quickshell.Widgets
import QtQuick

WrapperItem {
  anchors.verticalCenter: parent.verticalCenter

  SystemClock {
    id: time
    precision: SystemClock.Seconds
  }

  StyledText {
    text: Qt.formatDateTime(time.date, "hh:mm - dddd dd.")
  }
}
