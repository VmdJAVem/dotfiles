import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.SystemTray

Scope {
	id: root
	property string hostname: ""
	property string totalSpace: ""
	property string availableSpace: ""

	property string ramTotal: ""
	property string ramUsed: ""

	property int cpuUsage: 0
	property int lastCpuIdle: 0
	property int lastCpuTotal: 0

	Variants {
		model: Quickshell.screens

		PanelWindow {
			required property var modelData

			screen: modelData

			color: "transparent"
			implicitHeight: 37


			anchors {
				top: true
				left: true
				right: true
			}

			Item {
				anchors.fill: parent

				RowLayout {
					anchors.fill: parent

					anchors.leftMargin: 8
					anchors.rightMargin: 8
					anchors.topMargin: 4
					anchors.bottomMargin: 4

					spacing: 10

					// LEFT
					ModuleGroup {
						Layout.alignment: Qt.AlignLeft

						Workspaces {}
					}
					ModuleGroup {
						Layout.alignment: Qt.AlignLeft
						ClockWidget {
							color: Colors.fgLight
							font.pixelSize: 17
						}

					}
					ModuleGroup {
						Text {
							text: "󰽬"
							font.pixelSize: 20
							color: Colors.accent
							font.family: Globals.font
						}

						Music {
							font.family: Globals.font
						}
					}

					Item {
						Layout.fillWidth: true
					}

					// RIGHT
					ModuleGroup {
						Process {
							id: diskProc

							command: ["sh", "-c", "df -h $HOME | tail -1"]
							running: true

							stdout: SplitParser {
								onRead: data => {
									let parts = data.trim().split(/\s+/)

									root.totalSpace = parts[1]
									root.availableSpace = parts[3]
								}
							}
						}

						Timer {
							interval: 2000
							running: true
							repeat: true

							onTriggered: diskProc.running = true
						}

						Text {
							textFormat: Text.RichText
							font.family: Globals.font
							font.pixelSize: 17

							text:
							`<span style="color:${Colors.accent}"> </span> ` +
							`<span style="color:${Colors.fgLight}">` +
							`${root.availableSpace}/${root.totalSpace}` +
							`</span>`
						}
					}

					ModuleGroup {
						Process {
							id: ramProc

							command: ["sh", "-c", "free | grep Mem"]
							running: true

							stdout: SplitParser {
								onRead: data => {
									var parts = data.trim().split(/\s+/)

									root.ramTotal =
									(parseInt(parts[1]) / 1024 / 1024).toFixed(1)

									root.ramUsed =
									(parseInt(parts[2]) / 1024 / 1024).toFixed(1)
								}
							}
						}

						Timer {
							interval: 2000
							running: true
							repeat: true

							onTriggered: ramProc.running = true
						}

						Text {
							textFormat: Text.RichText
							font.family: Globals.font
							font.pixelSize: 17

							text:
							`<span style="color:${Colors.accent}"> </span> ` +
							`<span style="color:${Colors.fgLight}">` +
							`${root.ramUsed}GB/${root.ramTotal}GB` +
							`</span>`
						}
					}

					ModuleGroup {
						Process {
							id: cpuProc

							command: ["sh", "-c", "head -1 /proc/stat"]
							running: true

							stdout: SplitParser {
								onRead: data => {
									var p = data.trim().split(/\s+/)

									var idle =
									parseInt(p[4]) + parseInt(p[5])

									var total =
									p.slice(1).reduce(
										(a, b) => a + parseInt(b),
										0
									)

									if (root.lastCpuIdle > 0) {
										root.cpuUsage = Math.round(
											100 * (
												1 - (
													(idle - root.lastCpuIdle) /
													(total - root.lastCpuTotal)
												)
											)
										)
									}

									root.lastCpuTotal = total
									root.lastCpuIdle = idle
								}
							}
						}

						Timer {
							interval: 2000
							running: true
							repeat: true

							onTriggered: cpuProc.running = true
						}

						Text {
							textFormat: Text.RichText
							font.family: Globals.font
							font.pixelSize: 17

							text:
							`<span style="color:${Colors.accent}"> </span> ` +
							`<span style="color:${Colors.fgLight}">` +
							`${root.cpuUsage}%` +
							`</span>`
						}
					}
					ModuleGroup {
						Tray {}
					}
					ModuleGroup {
						Volume {}
					}
				}

				ModuleGroup {
					anchors.centerIn: parent
					WindowTittle {

						font.family: Globals.font
						font.pixelSize: 17

						color: Colors.fgLight
					}
				}
			}
		}
	}
}
