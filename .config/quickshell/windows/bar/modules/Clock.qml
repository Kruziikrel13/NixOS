import Quickshell
import QtQuick

Text {
  color: "white"

  SystemClock {
    id: time
    precision: SystemClock.Seconds
  }

  text: Qt.formatDateTime(time.date, "hh:mm - dddd dd")
}
