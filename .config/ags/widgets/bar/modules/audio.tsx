import AstalWp from "gi://AstalWp?version=0.1";
import {bind} from "ags/state"
import Gtk from "gi://Gtk?version=4.0";

export default function Audio() {
  const { defaultSpeaker: speaker } = AstalWp.get_default()!

  return (
    <menubutton cssClasses={["widget", "audio"]} $destroy={self=>self.run_dispose()}>
      <image iconName={bind(speaker, "volumeIcon")}/>
      <popover>
        <box orientation={Gtk.Orientation.VERTICAL}>
          <slider orientation={Gtk.Orientation.VERTICAL}
            heightRequest={260}
            $changeValue={({value}) => speaker.set_volume(value)}
            value={bind(speaker, "volume")}
          />
          </box>
      </popover>
    </menubutton>
  )
}
