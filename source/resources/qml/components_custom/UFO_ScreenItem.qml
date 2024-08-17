import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Rectangle {
    id: root

    signal screenSelected(Rectangle sender, string screenName)

    property bool selected: false
    property alias screenName: name.text

    width: 200
    height: 150

    border.color: selected ? "cornflowerblue" : "transparent"
    border.width: selected ? 2 : 0

    Text {
        id: name
        text: "Screen Name" // Set this dynamically
        anchors.centerIn: parent
        color: "black"
        font.pixelSize: 14 // TODO change this to by dynamic font size

        z: 1
    }

    MouseArea {
        anchors.fill: parent

        z: 2

        onClicked: {
            root.screenSelected(root, root.screenName)
        }
    }
}
