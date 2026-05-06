import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
PanelWindow {
	id: panel
	property string hostname: ""
	property string totalSpace: ""
	property string availableSpace: ""
	property real ramUsed: 0
	property real ramTotal: 0
	property int cpuUsage: 0
	property int lastCpuIdle: 0
	property int lastCpuTotal: 0
	visible: false
	color: "transparent"
	width: 600
	height: 700
	anchors {
		top: true
		right: true
	}
	margins {
		right: 15
		top: 25
	}

	Process {
		command: ["hostname"]
		running: true
		stdout: StdioCollector {
			onStreamFinished: panel.hostname = text.trim()
		}
	}

	Process {
		id: cpuProc
		command: ["sh", "-c", "head -1 /proc/stat"]
		running: true
		stdout: SplitParser {
			onRead: data => {
				var p = data.trim().split(/\s+/)
				var idle = parseInt(p[4]) + parseInt(p[5])
				var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
				if (lastCpuIdle > 0)
				cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
				lastCpuTotal = total
				lastCpuIdle = idle
			}
		}
	}
	Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: cpuProc.running = true
	}

	Process {
		id: diskProc
		command: ["sh", "-c", "df -h $HOME | tail -1"]
		running: true
		stdout: SplitParser {
			onRead: data => {
				let parts = data.trim().split(/\s+/)
				panel.totalSpace = parts[1]
				panel.availableSpace = parts[3]
			}
		}
	}
	Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: diskProc.running = true
	}

	Process {
		id: ramProc
		command: ["sh", "-c", "free | grep Mem"]
		running: true
		stdout: SplitParser {
			onRead: data => {
				var parts = data.trim().split(/\s+/)
				panel.ramTotal = (parseInt(parts[1]) / 1024 / 1024).toFixed(1)
				panel.ramUsed = (parseInt(parts[2]) / 1024 / 1024).toFixed(1)
			}
		}
	}
	Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: ramProc.running = true
	}

	Process {
		id: poweroffProc
		command: ["doas","poweroff"]
	}

	Process {
		id: rebootProc
		command: ["doas", "reboot"]
	}

	RandomImage {
		id: rndImg
		anchors {
			top: parent.top
			horizontalCenter: parent.horizontalCenter
			topMargin: 20
		}
		implicitWidth: parent.width * 0.8
		implicitHeight: parent.height * 0.5
	}

	Rectangle {
		anchors {
			top: rndImg.bottom
			horizontalCenter: parent.horizontalCenter
			topMargin: 20
		}
		width: parent.width * 0.8
		color: Colors.bg
		radius: 0
		implicitHeight: statsColumn.implicitHeight + 24

		Column {
			id: statsColumn
			anchors {
				top: parent.top
				left: parent.left
				margins: 12
			}
			spacing: 12

			Text {
				id: userText
				text: `${Quickshell.env("USER")}@${panel.hostname}`
				color: Colors.accent
				font.family: Globals.font
				font.pixelSize: 28
			}
			Text {
				textFormat: Text.RichText
				font.family: Globals.font
				font.pixelSize: 24
				text: `<span style="color:${Colors.accent}">Disk:</span> ` +
				`<span style="color:${Colors.fgLight}">${availableSpace}B/${totalSpace}B</span>`
			}
			Text {
				textFormat: Text.RichText
				font.family: Globals.font
				font.pixelSize: 24
				text: `<span style="color:${Colors.accent}">Ram:</span> ` +
				`<span style="color:${Colors.fgLight}">${ramUsed}GB/${ramTotal}GB</span>`
			}
			Text {
				textFormat: Text.RichText
				font.family: Globals.font
				font.pixelSize: 24
				text: `<span style="color:${Colors.accent}">Cpu:</span> ` +
				`<span style="color:${Colors.fgLight}">${cpuUsage}%</span>`
			}
		}

		Column {
			anchors {
				right: parent.right
				verticalCenter: parent.verticalCenter
				rightMargin: 12
			}
			spacing: 8
			
			Rectangle {
				color: Colors.red
				implicitWidth: 44
				implicitHeight: 44

				Text {
					anchors.centerIn: parent
					text: "⏻"
					font.pixelSize: 28
					color: Colors.bg
					font.family: Globals.font
					MouseArea {
						anchors.fill: parent
						onClicked: poweroffProc.running = true
					}
				}
			}
			Rectangle {
				color: Colors.yellow
				implicitWidth: 44
				implicitHeight: 44
				radius: 0

				Text {
					anchors.centerIn: parent
					text: "↺"
					font.pixelSize: 28
					color: Colors.bg
					font.family: Globals.font
					MouseArea {
						anchors.fill: parent
						onClicked: rebootProc.running = true
					}
				}

			}
		}
	}
}
