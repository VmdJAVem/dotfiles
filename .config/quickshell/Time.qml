import Quickshell
import Quickshell.Io
import QtQuick

pragma Singleton

Singleton {
	id: root
	readonly property string time: {
		Qt.formatDateTime(clock.date, "ddd. d MMM yyyy: hh:mm:ss AP")
	}
	SystemClock {
		id: clock
		precision: SystemClock.Seconds
	}
}
