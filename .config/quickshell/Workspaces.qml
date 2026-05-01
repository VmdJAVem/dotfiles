import Quickshell.Hyprland
import QtQuick
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
			family: Globals.font
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
