import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

MenuBar {
    id: root

    delegate: UFO_MenuBarItem {}

    // NOTE (SAVIZ): The reason why this Rectangle stretches all the way in the app, is because "ApplicationWindow" forces it to.
    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 28

        color: Qt.color(AppTheme.colors["UFO_MenuBar_Background"])
    }
}
