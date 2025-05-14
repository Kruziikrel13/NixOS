import { bind } from "ags/state";
import AstalMpris from "gi://AstalMpris?version=0.1";
import { With } from "ags/gtk4";

export default function Spotify() {
  const mprisService = AstalMpris.get_default()
  const spotifyState = bind(mprisService, "players").as(players => 
    players.find(player => player.identity === "Spotify" && player.busName.includes("spotify")))

  return (
    <box name="spotify" cssClasses={["widget"]} visible={spotifyState.as(Boolean)}>
      <With value={spotifyState}>
        {(spotify) => spotify && (
          <box spacing={5} cssClasses={["info"]}>
            <image iconName="spotify-symbolic"/>
            <label visible={bind(spotify, "artist").as(Boolean)} label={bind(spotify, "artist").as(String)}/>
            <label visible={bind(spotify, "artist").as(Boolean)} label="-"/>
            <label visible={bind(spotify,"title").as(Boolean)} label={bind(spotify, "title").as(String)}/>
          </box>
        )}
      </With>
    </box>
  )
}
