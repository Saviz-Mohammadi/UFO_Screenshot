import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

MenuBar {
    id: root

    delegate: UFO_MenuBarItem {}

    // The reason why this Rectangle stretches all the way in your app,
    // is because "ApplicationWindow" forces it to. This is good, because
    // We do not have to worry about setting the correct width;
    background: Rectangle {
        id: rectangle_1

        implicitWidth: 40
        implicitHeight: 28

        color: Qt.color(AppTheme.colors["UFO_MenuBar_Background"])
    }
}
