import QtQuick
import QtQuick.Layouts

Rectangle {
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
