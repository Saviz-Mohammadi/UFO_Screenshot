import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

ProgressBar {
    id: root

    padding: 2

    property alias message: text_1.text
    property int circleWidth: 100
    property int circleHeight: 100

    contentItem: Text {
        id: text_1

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        text: root.message
        color: Qt.color(AppTheme.colors["UFO_ProgressBar_Text"])
        elide: Text.ElideRight
    }

    background: Rectangle {
        id: rectangle_1

        readonly property real size: Math.min(root.width, root.height)

        anchors.centerIn: parent
        implicitWidth: circleWidth
        implicitHeight: circleHeight

        color: Qt.color(AppTheme.colors["UFO_ProgressBar_Background"])
        radius: size / 2

        Canvas {
            id: canvas_1

            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.strokeStyle = Qt.color(
                            AppTheme.colors["UFO_ProgressBar_ProgressIndicator"])
                ctx.lineWidth = parent.size / 20
                ctx.beginPath()
                var startAngle = -Math.PI / 2 // Start from the top of the circle
                var endAngle = startAngle + (root.visualPosition * 2 * Math.PI)
                ctx.arc(width / 2, height / 2,
                        width / 2 - ctx.lineWidth / 2 - 2, startAngle, endAngle)
                ctx.stroke()
            }
        }
    }

    onValueChanged: {
        canvas_1.requestPaint()
    }
}
