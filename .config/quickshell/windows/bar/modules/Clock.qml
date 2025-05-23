import Quickshell
import Quickshell.Widgets
import QtQuick


WrapperItem {
  id: clock
  SystemClock {
    id: time
    precision: SystemClock.Seconds
  }

  Text {
    color: "white"
    font.pixelSize: 15
    text: Qt.formatDateTime(time.date, "hh:mm - dddd dd")
  }
}
