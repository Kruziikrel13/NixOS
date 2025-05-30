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
    readonly property bool active: !!player && player.canSeek // Should hopefully account for DJ
    readonly property bool playing: player?.playbackState == MprisPlaybackState.Playing
    readonly property string trackIcon: player?.trackArtUrl ?? null
    readonly property string trackArtist: player?.trackArtist ?? null
    readonly property string trackTitle: player?.trackTitle ?? null
    readonly property string trackInfoStr: {
      if (!active || !playing) return "";

      if (trackArtist && !trackTitle) {
        return trackArtist
      }

      if (trackTitle && !trackArtist) {
        return trackTitle
      }

      return player.trackArtist + " - " + player.trackTitle
    }
  }
}
