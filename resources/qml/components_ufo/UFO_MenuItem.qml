import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

MenuItem {
    id: root

    implicitWidth: 120
    implicitHeight: 28

    text: qsTr("")

    contentItem: Text {
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

        leftPadding: root.indicator.width
        rightPadding: root.arrow.width

        text: root.text
        font: root.font
        opacity: enabled ? 1.0 : 0.3
        color: root.highlighted ? Qt.color(
                                      AppTheme.colors["UFO_MenuItem_Text_Highlighted"]) : Qt.color(
                                      AppTheme.colors["UFO_MenuItem_Text_Normal"])
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 28

        radius: 0
        opacity: enabled ? 1 : 0.3
        color: root.highlighted ? Qt.color(
                                      AppTheme.colors["UFO_MenuItem_Background_Highlighted"]) : Qt.color(
                                      AppTheme.colors["UFO_MenuItem_Background_Normal"])
    }
}
