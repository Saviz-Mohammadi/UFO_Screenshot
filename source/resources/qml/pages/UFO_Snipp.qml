import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom QML Files
import "./../components_ufo"
import "./../components_custom"

// Custom CPP Registered Types
import AppTheme 1.0

UFO_Page {
    id: root

    title: qsTr("Snipp tool")
    contentSpacing: 20

    function onSelected(x, y, width, height) {
        console.log("dimensions recieved!");

        console.log("recieved x:" + x);
        console.log("recieved y:" + y);
        console.log("recieved width:" + width);
        console.log("recieved hieght:" + height);
    }

    UFO_Button {
        text: qsTr("Click me")

        onClicked: {
            showMinimized(); // Minimize the main window

            var component = Qt.createComponent("./../components_custom/UFO_SelectionArea.qml");
            var selectionArea = component.createObject(root);

            selectionArea.selected.connect(onSelected)
        }
    }
}
