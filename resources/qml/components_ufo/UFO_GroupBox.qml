import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Item {
    id: root

    implicitWidth: 300
    implicitHeight: (rectangle_1.implicitHeight + rectangle_2.implicitHeight + rectangle_3.implicitHeight)

    default property alias content: columnLayout_1.data
    property int contentSpacing: 7
    property alias title: text_1.text
    property real titleFontSize: 1.3
    property real titleTopMargin: 0
    property real titleBottomMarign: 0
    property real titleLeftMargin: 10
    property real titleRightMargin: 10

    Rectangle {
        id: rectangle_1

        anchors.top: root.top
        anchors.left: root.left
        anchors.right: root.right

        implicitWidth: root.implicitWidth
        implicitHeight: 35

        color: Qt.color(AppTheme.colors["UFO_GroupBox_Title_Background"])

        Text {
            id: text_1

            anchors.fill: parent

            anchors.topMargin: root.titleTopMargin
            anchors.bottomMargin: root.titleBottomMargin
            anchors.leftMargin: root.titleLeftMargin
            anchors.rightMargin: root.titleRightMargin

            text: qsTr("")
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: Qt.color(AppTheme.colors["UFO_GroupBox_Title_Text"])
            font.pixelSize: Qt.application.font.pixelSize * titleFontSize // Read-only property. Holds the default application font returned by QGuiApplication::font()
            elide: Text.ElideRight
        }
    }

    Rectangle {
        id: rectangle_2

        anchors.top: rectangle_1.bottom
        anchors.left: root.left
        anchors.right: root.right

        implicitWidth: root.implicitWidth
        implicitHeight: 2

        color: Qt.color(AppTheme.colors["UFO_GroupBox_Separator"])
    }

    Rectangle {
        id: rectangle_3

        anchors.top: rectangle_2.bottom
        anchors.left: root.left
        anchors.right: root.right
        anchors.bottom: root.bottom

        implicitWidth: root.implicitWidth
        implicitHeight: columnLayout_1.implicitHeight

        color: Qt.color(AppTheme.colors["UFO_GroupBox_Content_Background"])
        radius: 0

        ColumnLayout {
            id: columnLayout_1

            width: rectangle_3.width

            clip: true
            spacing: contentSpacing
        }
    }
}
