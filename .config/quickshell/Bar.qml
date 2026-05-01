import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.SystemTray

Scope {
	id: root

	component ModuleGroup: Rectangle {
		id: group

		default property alias content: contentRow.data

		radius: 0
		color: Colors.bg

		implicitHeight: 30
		implicitWidth: contentRow.implicitWidth + 20

		RowLayout {
			id: contentRow

			anchors.fill: parent
			anchors.leftMargin: 10
			anchors.rightMargin: 10

			spacing: 8
		}
	}

	Variants {
		model: Quickshell.screens

		PanelWindow {
			required property var modelData

			screen: modelData

			color: "transparent"
			implicitHeight: 37

			HyprlandWindow.opacity: 1.0

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

					Item {
						Layout.fillWidth: true
					}

					// RIGHT
					ModuleGroup {
						Text {
							text: "󱝠"
							color: Colors.fgLight
							font.pixelSize: 17
							font.family: Globals.font
						}

						Music {
							font.family: Globals.font
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
