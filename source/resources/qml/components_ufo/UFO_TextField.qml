import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

TextField {
    id: root

    implicitWidth: 200
    implicitHeight: 35

    background: Rectangle {
        id: rectangle_1

        anchors.fill: parent

        // There are also other situations such as enabled/disabled, but this will do for now.
        color: {
            if (root.activeFocus) {
                Qt.color(AppTheme.colors["UFO_TextField_Background_Active"])
            } else if (root.hovered) {
                Qt.color(AppTheme.colors["UFO_TextField_Background_Hovered"])
            } else {
                Qt.color(AppTheme.colors["UFO_TextField_Background_Normal"])
            }
        }

        radius: 0

        border.color: root.enabled ? Qt.color(
                                         AppTheme.colors["UFO_TextField_Border"]) : Qt.color(
                                         AppTheme.colors["UFO_TextField_Border"])
    }

    color: {
        if (root.activeFocus) {
            Qt.color(AppTheme.colors["UFO_TextField_Text_Active"])
        } else if (root.hovered) {
            Qt.color(AppTheme.colors["UFO_TextField_Text_Hovered"])
        } else {
            Qt.color(AppTheme.colors["UFO_TextField_Text_Normal"])
        }
    }

    selectedTextColor: Qt.color(AppTheme.colors["UFO_TextField_SelectedText"])

    placeholderTextColor: {
        if (root.activeFocus) {
            Qt.color(AppTheme.colors["UFO_TextField_Placeholder_Active"])
        } else if (root.hovered) {
            Qt.color(AppTheme.colors["UFO_TextField_Placeholder_Hovered"])
        } else {
            Qt.color(AppTheme.colors["UFO_TextField_Placeholder_Normal"])
        }
    }
}
