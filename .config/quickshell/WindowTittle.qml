import Quickshell.Hyprland
import QtQuick

Text {
	text: Hyprland.activeToplevel
	? Hyprland.activeToplevel.title
	: "-"
}
