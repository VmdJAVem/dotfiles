import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

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
