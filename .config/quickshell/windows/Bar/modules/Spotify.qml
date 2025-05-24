import "root:/widgets"
import "root:/state"
import Quickshell.Widgets
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts


WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter
  visible: spotifyRunning
  readonly property var spotify: Mpris.players.values.find(player => player.identity == "Spotify")
  property bool spotifyRunning: !!spotify
  property bool spotifyPlaying: spotify?.playbackState == MprisPlaybackState.Playing
  readonly property string trackInfoStr: {
    if (!spotifyRunning || !spotifyPlaying) {
      return ""
    }
    if (!spotify.trackArtist || !spotify.trackTitle) {
      return ""
    }
    return spotify.trackArtist + " - " + spotify.trackTitle
  }

  // Timer {
  //   running: player?.playbackStatus == MprisPlaybackStatus.Playing
  //   interval: 1000
  //   repeat: true
  //   onTriggered: player.positionChanged()
  // }
  
  RowLayout {
    IconImage {
      implicitSize: Appearance.sizes.icons.normal
      source: Appearance.iconFolder + "spotify"
    }
    StyledText {
      id: trackInfo
      text: trackInfoStr.length > 30 ? trackInfoStr.slice(0, 30) + "..." : trackInfoStr
    }
  }
}
