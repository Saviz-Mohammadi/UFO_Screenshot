import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

MenuSeparator {
    id: root

    contentItem: Rectangle {
        implicitWidth: 200
        implicitHeight: 1

        color: Qt.color(AppTheme.colors["UFO_MenuSeparator"])
    }
}
