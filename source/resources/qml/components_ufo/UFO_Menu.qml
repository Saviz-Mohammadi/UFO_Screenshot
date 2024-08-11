import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Menu {
    id: root

    title: qsTr("")

    delegate: UFO_MenuItem {}

    background: Rectangle {
        id: rectangle_1

        implicitWidth: 150
        implicitHeight: 28

        radius: 0
        opacity: enabled ? 1 : 0.3
        border.color: Qt.color(AppTheme.colors["UFO_Menu_Border"])
        color: root.highlighted ? Qt.color(
                                      AppTheme.colors["UFO_Menu_Background_Normal"]) : Qt.color(
                                      AppTheme.colors["UFO_Menu_Background_Highlighted"])
    }
}
