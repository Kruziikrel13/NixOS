import "root:/settings"
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
    readonly property bool playing: player?.isPlaying ?? null

    readonly property string trackIcon: player?.trackArtUrl ?? null
    readonly property string trackArtist: player?.trackArtist ?? null
    readonly property string trackTitle: player?.trackTitle ?? null

    readonly property string trackInfo: {
      if (!active || !playing) return null;

      let info = ""
      if (trackArtist) info += trackArtist

      if (trackTitle) {
        if (info) info += " - " // If TrackArtist is also defined, split the two values with a '-'
        info += trackTitle
      }
      return info
    }

    function getTrackInfo(maxLength) {
      if (trackInfo.length > maxLength) {
        return trackInfo.slice(0, maxLength).trim() + "..."
      }
      return trackInfo
    }
  }
}
