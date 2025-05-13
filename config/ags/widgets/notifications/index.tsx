import Gtk from "gi://Gtk?version=4.0"
import AstalNotifd from "gi://AstalNotifd?version=0.1"
import GLib from "gi://GLib?version=2.0"

type Props = {
  notification: AstalNotifd.Notification
}

const fileExists = (path: string) =>
  GLib.file_test(path, GLib.FileTest.EXISTS)

const time = (format = "%H:%M") =>
  GLib.DateTime.new_now_local().format(format)!

const urgency = (n: AstalNotifd.Notification) => {
  const { LOW, NORMAL, CRITICAL } = AstalNotifd.Urgency
  switch (n.urgency) {
    case LOW:
      return "low"
    case CRITICAL:
      return "critical"
    case NORMAL:
    default: return "normal"
  }
}

type Props = {
  notification: AstalNotifd.Notification
}
export default function Notification(props: Props) {
  const { notification: n } = props
  const { START, CENTER, END } = Gtk.Align

  return (<box
    cssClasses={["notification", urgency(n)]}
  $={}>
  </box>)
}
