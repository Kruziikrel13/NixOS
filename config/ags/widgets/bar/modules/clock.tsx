import { Poll } from "ags/state";
import GLib from "gi://GLib?version=2.0";
import Gtk from "gi://Gtk?version=4.0";

type ClockProps = {
  format?: string
}
export default function Clock({format = "%H:%M - %A %d"}: ClockProps) {
  const time = new Poll("", 1000, () => {
    return GLib.DateTime.new_now_local().format(format)!
  })

  return <label $destroy={() => time.destroy()} label={time()}/>
}

