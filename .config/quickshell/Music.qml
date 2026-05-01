import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Text {
    id: root

    property var player: Mpris.players.values.length > 0
                         ? Mpris.players.values[0]
                         : null

    property string fullText: {
        if (!player)
            return "-"

        return `${player.trackArtist} - ${player.trackTitle}`
    }

    property int maxLength: 25
    property int offset: 0

    color: Colors.fgLight
    font.pixelSize: 17

    text: {
        if (fullText.length <= maxLength)
            return fullText

        let padded = fullText + "    " + fullText
        return padded.slice(offset, offset + maxLength)
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            if (player && player.canTogglePlaying)
                player.togglePlaying()
        }
    }

    Timer {
        interval: 400
        running: fullText.length > maxLength
        repeat: true

        onTriggered: {
            offset = (offset + 1) % fullText.length
        }
    }
}
