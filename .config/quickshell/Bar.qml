import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick.Layouts
import Quickshell.Services.SystemTray

Scope {
	id: root

	Variants {
		model: Quickshell.screens

		PanelWindow {
			required property var modelData

			screen: modelData
			color: Colors.bg
			implicitHeight: 37
			HyprlandWindow.opacity: 0.8

			anchors {
				top: true
				left: true
				right: true
			}

			Item {
				anchors.fill: parent

				RowLayout {
					anchors.fill: parent

					RowLayout {
						Layout.alignment: Qt.AlignLeft
						Layout.leftMargin: 5
						spacing: 10

						Repeater {
							model: 5

							Text {
								property var ws: Hyprland.workspaces.values.find(
									w => w.id === index + 1
								)

								property bool isActive:
								Hyprland.focusedWorkspace?.id === index + 1

								text: index + 1

								color: isActive
								? Colors.accent
								: (ws ? Colors.seccondAccent : Colors.fgLight)

								font {
									family: "Iosevka Nerd Font Propo"
									pixelSize: isActive ? 20 : 17
								}

								MouseArea {
									anchors.fill: parent

									onClicked:
									Hyprland.dispatch(
										"workspace " + (index + 1)
									)
								}
							}
						}
						Separator {}

						ClockWidget {
							color: Colors.fgLight
							font.pixelSize: 17
						}
					}

					Item {
						Layout.fillWidth: true
					}
					RowLayout {
						Layout.rightMargin: 5
						spacing: 10

						Text {
							text: "󱝠"
							color: Colors.fgLight
							font.pixelSize: 17
						}
						
						Music {}

						Separator {}
						

						Repeater {
							model: SystemTray.items

							delegate: Item {
								required property var modelData

								implicitWidth: 15
								implicitHeight: 15

								Image {
									anchors.fill: parent

									source: modelData.icon
									fillMode: Image.PreserveAspectFit
								}

								MouseArea {
									anchors.fill: parent

									onClicked: event => {
										if (event.button === Qt.LeftButton)
										modelData.activate()

										if (event.button === Qt.RightButton)
										modelData.secondaryActivate()
									}
								}
							}
						}
					}
				}

				Text {
					anchors.centerIn: parent

					text: Hyprland.activeToplevel
					? Hyprland.activeToplevel.title
					: "-"

					color: Colors.fgLight
					font.pixelSize: 17
				}
			}
		}
	}
}
