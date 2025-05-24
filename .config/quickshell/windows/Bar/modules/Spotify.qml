import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts


WrapperItem {
  id: root
  anchors.verticalCenter: parent.verticalCenter
  readonly property var spotify: Mpris.players.values.find(player => player.identity == "Spotify")
  visible: !!spotify

  // Timer {
  //   running: player?.playbackStatus == MprisPlaybackStatus.Playing
  //   interval: 1000
  //   repeat: true
  //   onTriggered: player.positionChanged()
  // }

  RowLayout {
    IconImage {
      implicitSize: 15
      source: "root:/assets/icons/spotify.svg"
    }
    Text {
      visible: (spotify?.playbackState == MprisPlaybackState.Playing) && (!!spotify?.trackArtist && !!spotify?.trackTitle)
      font.pixelSize: 15
      color: "white"
      text: spotify?.trackArtist + " - " + spotify?.trackTitle
    }
  }
}
