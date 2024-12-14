import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Canvas {
    x: parent.width - width

    implicitWidth: 40
    implicitHeight: 28

    visible: parent.subMenu

    onPaint: {
        var ctx = getContext("2d")
        ctx.fillStyle
                = parent.highlighted ? Qt.color(
                                           AppTheme.colors["UFO_MenuItemArrow_Background_Highlighted"]) : Qt.color(
                                           AppTheme.colors["UFO_MenuItemArrow_Background_Normal"])
        ctx.moveTo(15, 15)
        ctx.lineTo(width - 15, height / 2)
        ctx.lineTo(15, height - 15)
        ctx.closePath()
        ctx.fill()
    }
}
