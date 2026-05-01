import QtQuick
import Quickshell
import Quickshell.Io

Row {
	id: root

	property int volume: 0
	property bool muted: false

	spacing: 5

	function updateVolume(output) {
		let match = output.match(/([0-9.]+)/)

		if (match) {
			volume = Math.round(parseFloat(match[1]) * 100)
		}

		muted = output.includes("MUTED")
	}

	function volumeIcon() {
		if (muted || volume === 0)
		return "󰖁"

		if (volume < 35)
		return "󰕿"

		if (volume < 70)
		return "󰖀"

		return "󰕾"
	}

	Process {
		id: volumeProc

		command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@"]

		stdout: SplitParser {
			onRead: data => {
				root.updateVolume(data)
			}
		}

		running: true
	}

	Timer {
		interval: 100
		running: true
		repeat: true

		onTriggered: {
			volumeProc.running = true
		}
	}

	Text {
		text: root.volumeIcon()

		font.family: Globals.font
		font.pixelSize: 17

		color: Colors.fgLight
	}

	Text {
		text: root.volume + " "

		font.pixelSize: 17
		color: Colors.fgLight
	}
	MouseArea {
		anchors.fill: parent

		onClicked: {
			Qt.createQmlObject(`
			import Quickshell.Io

			Process {
				command: ["kitty", "-e", "pulsemixer"]
				running: true
			}
			`, root)
		}

		onWheel: event => {
			if (event.angleDelta.y > 0) {
				Qt.createQmlObject(`
				import Quickshell.Io

				Process {
					command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "1%+"]
					running: true
				}
				`, root)
			} else {
				Qt.createQmlObject(`
				import Quickshell.Io

				Process {
					command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "1%-"]
					running: true
				}
				`, root)
			}
		}
	}
}
