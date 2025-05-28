import "root:/state"
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
pragma Singleton

Singleton {
  id: root
  readonly property MprisPlayer activePlayer: Mpris.players.values[0] ?? null

  property QtObject spotify: QtObject {
    readonly property MprisPlayer player: Mpris.players.values.find(player => player.identity == "Spotify") ?? null
    readonly property string icon: Appearance.iconFolder + "spotify"
    readonly property bool active: !!player
    readonly property bool playing: player?.playbackState == MprisPlaybackState.Playing
    readonly property string trackIcon: player.trackArtUrl
    readonly property string trackInfoStr: {
      if (!active || !playing) return "";
      if (!player.trackArtist || !player.trackTitle) return ""
      return player.trackArtist + " - " + player.trackTitle
    }
  }
}
