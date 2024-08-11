import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Item {
    id: root

    implicitWidth: 200
    implicitHeight: 28

    property alias text: text_1.text
    property real textLeftMargin: 7

    Rectangle {
        id: rectangle_1

        anchors.fill: parent

        color: Qt.color(AppTheme.colors["UFO_StatusBar_Background"])

        Text {
            id: text_1

            anchors.fill: parent
            anchors.leftMargin: textLeftMargin

            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: qsTr("")
            color: Qt.color(AppTheme.colors["UFO_StatusBar_Text"])
            elide: Text.ElideRight
        }
    }
}
