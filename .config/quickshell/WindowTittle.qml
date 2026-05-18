import Quickshell.Hyprland
import QtQuick

Text {
	text: {
		const title = Hyprland.activeToplevel
		? Hyprland.activeToplevel.title
		: "-"

		return title.length > 50
		? title.slice(0, 47) + "..."
		: title
	}
}
