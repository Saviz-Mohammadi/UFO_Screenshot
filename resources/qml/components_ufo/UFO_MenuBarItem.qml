import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

MenuBarItem {
    id: root

    contentItem: Text {
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

        text: root.text
        font: root.font
        opacity: enabled ? 1.0 : 0.3
        color: root.highlighted ? Qt.color(
                                      AppTheme.colors["UFO_MenuBarItem_Text_Highlighted"]) : Qt.color(
                                      AppTheme.colors["UFO_MenuBarItem_Text_Normal"])
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 28

        opacity: enabled ? 1 : 0.3
        color: root.highlighted ? Qt.color(
                                      AppTheme.colors["UFO_MenuBarItem_Background_Highlighted"]) : Qt.color(
                                      AppTheme.colors["UFO_MenuBarItem_Background_Normal"])
    }
}
