import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Item {
    id: root

    default property alias content: columnLayout.data
    property int contentSpacing: 7
    property int contentTopMargin: 20
    property int contentBottomMargin: 40
    property int contentLeftMargin: 20
    property int contentRightMarign: 20
    property alias title: text.text
    property real titleFontSize: 1.8

    implicitWidth: 300
    implicitHeight: 300

    Rectangle {
        anchors.fill: parent

        color: Qt.color(AppTheme.colors["UFO_Page_Background"])

        ScrollView {
            anchors.fill: parent

            // NOTE (SAVIZ): Setting "contentWidth" to -1 will disable horizontal scrolling.
            contentWidth: -1
            contentHeight: columnLayout.height + contentBottomMargin

            // NOTE (SAVIZ): There is a small overhead due to things such as margins, font sizes, and other things. This is why we add "contentBottomMargin".
            // NOTE (SAVIZ): If you want to enable horizontal scrolling, then it is best to place the target element inside of another "ScrollView".
            ColumnLayout {
                id: columnLayout

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                anchors.topMargin: contentTopMargin
                anchors.leftMargin: contentLeftMargin
                anchors.rightMargin: contentRightMarign

                clip: true
                spacing: contentSpacing

                Text {
                    id: text

                    text: qsTr("")

                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter

                    color: Qt.color(AppTheme.colors["UFO_Page_Title"])

                    // NOTE (SAVIZ): "Qt.application.font.pixelSize" is a Read-only property and holds the default application font returned by "QGuiApplication::font()".
                    font.pixelSize: Qt.application.font.pixelSize * titleFontSize
                    elide: Text.ElideRight
                }
            }
        }
    }
}
