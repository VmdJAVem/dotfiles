import QtQuick
import Qt.labs.folderlistmodel

Item {
	id: root

	property var imageFiles: []

	Component.onCompleted: console.log("RandomImage loaded, size:", width, height)

	FolderListModel {
		id: folderModel
		folder: "file:///home/arkar/.config/quickshell/images"
		nameFilters: ["*.png", "*.jpg", "*.jpeg", "*.webp", "*.gif"]
		showDirs: false

		onCountChanged: {
			console.log("onCountChanged:", count)
			if (count === 0) return
			var files = []
			for (let i = 0; i < count; ++i) {
				var f = folderModel.get(i, "filePath")  // filePath not fileURL
				if (f) {
					var url = "file://" + f           // manually build URL string
					console.log("file:", url)
					files.push(url)
				}
			}
			if (files.length > 0) {
				root.imageFiles = files
				img.source = files[Math.floor(Math.random() * files.length)]
				console.log("assigned source:", img.source)
			}
		}
	}

	Image {
		id: img
		width: root.width
		height: root.height
		fillMode: Image.PreserveAspectCrop
		cache: false
		asynchronous: true
		onStatusChanged: console.log("img status:", status, "size:", width, height, "source:", source)
	}

	Timer {
		interval: 10000
		running: root.imageFiles.length > 0 && !parent.visible
		repeat: true
		onTriggered: img.source = root.imageFiles[Math.floor(Math.random() * root.imageFiles.length)]
	}

	// Change image the moment panel closes
	Connections {
		target: parent
		function onVisibleChanged() {
			if (!parent.visible && root.imageFiles.length > 0)
			img.source = root.imageFiles[Math.floor(Math.random() * root.imageFiles.length)]
		}
	}
}
