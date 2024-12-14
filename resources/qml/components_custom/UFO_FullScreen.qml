import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom QML Files
import "./../components_ufo"

// Custom CPP Registered Types
import AppTheme 1.0
import Screenshot 1.0

Window {
    id: root

    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    modality: Qt.ApplicationModal
    color: "transparent"

    Component.onCompleted: {
        image.source = "./../../images/black.png"
        image.source = Screenshot.screenshot

        showFullScreen()
    }

    Rectangle {
        anchors.fill: parent

        focus: true
        color: "black"

        Keys.onPressed: (event)=> {
            if (event.key === Qt.Key_Escape) {
                event.accepted = true;

                root.close()
            }
        }

        Image {
            id: image

            anchors.centerIn: parent

            fillMode: Image.PreserveAspectFit
            smooth: true
            cache: false
        }
    }
}
