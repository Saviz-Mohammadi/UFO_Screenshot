import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Qt.labs.platform
import QtQuick.Dialogs

// Custom QML Files
import "./../components_ufo"
import "./../components_custom"

// Custom CPP Registered Types
import AppTheme 1.0
import Screenshot 1.0

UFO_Page {
    id: root

    title: qsTr("Screenshot tool")
    contentSpacing: 25

    function onScreenSelected(sender, screenName) {

        for (var i = 0; i < repeater.count; i++) {
            var item = repeater.itemAt(i)

            item.selected = false
        }

        sender.selected = true

        for (var j = 0; j < Qt.application.screens.length; j++) {

            if (Qt.application.screens[j].name === screenName) {
                properties.selectedScreen = Qt.application.screens[j].name
                break
            }
        }

        if (properties.selectedScreen !== "") {
            properties.screenIsSelected = true
        }
    }

    function onAreaSelected(x, y, width, height) {
        properties.x = x
        properties.y = y
        properties.width = width
        properties.height = height

        Screenshot.initiateScreenshot(properties.selectedScreen, properties.x, properties.y, properties.width, properties.height)
    }

    function onCustomAreaCancled() {
        rootWindow.setVisible(true)
    }

    function onFullScreenClosed()
    {
        // NOTE (SAVIZ): For now, we perform nothing.
    }

    QtObject {
        id: properties

        property int selectedCaptureMode: 0
        property string selectedScreen: ""
        property string path: ""
        property bool screenIsSelected: false
        property int x: 0
        property int y: 0
        property int width: 0
        property int height: 0
    }

    FileDialog {
        id: fileDialog

        title: "Save Screenshot"
        fileMode: FileDialog.SaveFile
        nameFilters: ["Image files (*.png *.jpg *.jpeg)"]
        currentFolder: StandardPaths.writableLocation(
                           StandardPaths.PicturesLocation)
        defaultSuffix: ".png"

        onAccepted: {
            console.log("Selected file path:", fileDialog.selectedFile)

            if (Screenshot.fileExists(fileDialog.selectedFile)) {

                properties.path = fileDialog.selectedFile
                warningDialog.open()
                return
            }

            Screenshot.saveScreenshot(fileDialog.selectedFile)
        }
    }

    MessageDialog {
        id: warningDialog

        title: "Warning"
        informativeText: "This file already exists. Do you want to replace it?"

        modality: Qt.Window

        buttons: MessageDialog.Ok | MessageDialog.Cancel

        onRejected: {
            // TODO (SAVIZ): Display a popup here saying "Canceled"
        }

        onAccepted: {
            Screenshot.saveScreenshot(properties.path)
        }
    }

    UFO_GroupBox {
        Layout.fillWidth: true
        // NOTE (SAVIZ): No point using "Layout.fillHeight" as "UFO_Page" ignores height to enable vertical scrolling.

        title: qsTr("Available Screens")
        contentSpacing: 0

        Text {
            Layout.fillWidth: true

            Layout.topMargin: 20
            Layout.bottomMargin: 0
            Layout.leftMargin: 15
            Layout.rightMargin: 15

            color: Qt.color(AppTheme.colors["UFO_GroupBox_Content_Text"])

            text: qsTr("The following are the detected screens of your machine. Plesae choose one before attempting to capture the screen")

            wrapMode: Text.WordWrap
            elide: Text.ElideRight
        }

        Flow {
            Layout.fillWidth: true

            Layout.margins: 10

            spacing: 10

            Repeater {
                id: repeater

                model: Qt.application.screens

                delegate: UFO_ScreenItem {

                    screenName: modelData.name

                    Component.onCompleted: {
                        screenSelected.connect(root.onScreenSelected)
                    }
                }
            }
        }
    }

    RowLayout {
        Layout.fillWidth: true

        UFO_Button {
            text: qsTr("Capture")

            enabled: properties.screenIsSelected
            svg: "./../../icons/Google icons/photo_camera.svg"

            onClicked: {
                rootWindow.setVisible(false)

                if (properties.selectedCaptureMode === 0) {
                    Screenshot.initiateScreenshot(properties.selectedScreen)

                    return
                }

                if (properties.selectedCaptureMode === 1) {
                    var component = Qt.createComponent("./../components_custom/UFO_SelectionArea.qml")
                    var selectionArea = component.createObject(root)

                    selectionArea.selected.connect(onAreaSelected)
                    selectionArea.canceled.connect(onCustomAreaCancled)

                    for (var j = 0; j < Qt.application.screens.length; j++) {

                        if (Qt.application.screens[j].name === properties.selectedScreen) {
                            selectionArea.screen = Qt.application.screens[j]

                            break
                        }
                    }

                    return
                }
            }
        }

        UFO_ComboBox {
            Layout.preferredWidth: 120
            Layout.preferredHeight: 35

            model: ["Full Screen", "Custom Area"]

            onCurrentIndexChanged: {
                properties.selectedCaptureMode = currentIndex
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        UFO_Button {
            Layout.preferredWidth: 120
            Layout.preferredHeight: 40

            enabled: Screenshot.screenshotExists
            text: qsTr("Save As")
            svg: "./../../icons/Google icons/save_as.svg"

            onClicked: {
                fileDialog.open()
            }
        }

        UFO_Button {
            Layout.preferredWidth: 120
            Layout.preferredHeight: 40

            enabled: Screenshot.screenshotExists
            text: qsTr("Maximize")
            svg: "./../../icons/Google icons/fullscreen.svg"

            onClicked: {
                var component = Qt.createComponent("./../components_custom/UFO_FullScreen.qml")
                var fullScreen = component.createObject(root)

                fullScreen.closing.connect(onFullScreenClosed)
            }
        }
    }

    Rectangle {
        id: rectangle_1

        Layout.fillWidth: true
        Layout.preferredHeight: Math.round(root.width / 2)

        color: Qt.color(AppTheme.colors["UFO_Image_Background"])
        border.color: "cornflowerblue"
        border.width: 2

        Image {
            id: image_Preview

            anchors.fill: parent

            anchors.margins: 15

            fillMode: Image.PreserveAspectFit
            smooth: true
            cache: false
        }
    }

    // NOTE (SAVIZ): I am not entirely sure, but for some reason I have to do this to trigger the internal code to reproduce the image. Some say this is a caching behaviour.
    Connections {
        target: Screenshot

        function onScreenshotChanged() {
            image_Preview.source = "./../../images/black.png"
            image_Preview.source = Screenshot.screenshot

            rootWindow.setVisible(true)
        }
    }
}
