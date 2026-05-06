import Quickshell.Hyprland
import QtQuick

Text {
	text: {
		const title = Hyprland.activeToplevel
		? Hyprland.activeToplevel.title
		: "-"

		return title.length > 80
		? title.slice(0, 77) + "..."
		: title
	}
}
