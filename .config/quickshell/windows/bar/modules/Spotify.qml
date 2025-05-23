import Quickshell
import Quickshell.Services.Mpris
import QtQuick

Text {
  color: "white"
  Timer {
    running: player.playbackState == MprisPlaybackState.Playing
    interval: 1000
    repeat: true
    onTriggered: player.positionChanged()
  }

  text: "Spotify"
}
