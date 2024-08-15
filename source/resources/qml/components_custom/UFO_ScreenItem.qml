import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Rectangle {
    id: root

    signal screenSelected(string screenName)

    property bool selected: false
    property alias screenName: name.text

    width: 200
    height: 150

    border.color: "black"
    border.width: 1


    // Image {
    //     id: thumbnail
    //     source: ""  // Set this dynamically
    //     anchors.fill: parent
    //     fillMode: Image.PreserveAspectFit
    // }

    Text {
        id: name
        text: "Screen Name"  // Set this dynamically
        anchors.centerIn: parent
        color: "black"
        font.pixelSize: 14

        z: 1
    }

    MouseArea {
        anchors.fill: parent

        z: 2

        onClicked: {
            // Signal to change screen in QObject
            //console.log("Screen clicked:", screenName)

            root.screenSelected(root.screenName)
        }
    }
}
