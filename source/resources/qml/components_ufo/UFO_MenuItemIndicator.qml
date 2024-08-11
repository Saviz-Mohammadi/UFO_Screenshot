import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Item {
    id: root

    property alias checkable: rectangle_1.visible
    property alias checked: rectangle_2.visible

    implicitWidth: 40
    implicitHeight: 28

    Rectangle {
        id: rectangle_1

        width: 16
        height: 16

        anchors.centerIn: parent

        visible: false
        border.color: "transparent"
        radius: 0

        Rectangle {
            id: rectangle_2

            width: 8
            height: 8
            anchors.centerIn: parent

            visible: false
            color: Qt.color(
                       AppTheme.colors["UFO_MenuItemIndicator_Background_Checked"])
            radius: 0
        }
    }
}
