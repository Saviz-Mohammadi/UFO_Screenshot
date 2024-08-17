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

        for (var i = 0; i < repeater_1.count; i++) {
            var item = repeater_1.itemAt(i)

            item.selected = false
        }

        // Highlight only the element that was selected
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

        Screenshot.initiateScreenshot(properties.selectedScreen, properties.x,
                                      properties.y, properties.width,
                                      properties.height)
    }

    function onCustomAreaCancled() {
        showNormal()
    }

    QtObject {
        id: properties

        property int selectedCaptureMode: 0
        property string selectedScreen: ""
        property string path: ""
        property bool screenIsSelected: false // Just to make sure that user selects a screen before taking screenshot
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
            // Handle the selected file path
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

            // Maybe display a popup here saying "Save canceled"
        }

        onAccepted: {
            Screenshot.saveScreenshot(properties.path)
        }
    }

    UFO_GroupBox {
        id: ufo_GroupBox_1

        Layout.fillWidth: true
        // No point setting "Layout.fillHeight" as "UFO_Page" ignores height to enable vertical scrolling.

        title: qsTr("Available Screens")
        contentSpacing: 0

        Text {
            id: text_1

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
            spacing: 10

            Layout.fillWidth: true
            Layout.margins: 10

            Repeater {
                id: repeater_1

                model: Qt.application.screens

                delegate: UFO_ScreenItem {

                    screenName: modelData.name

                    Component.onCompleted: {
                        // Connect the clicked signal of each item to a JavaScript function
                        screenSelected.connect(root.onScreenSelected)
                    }
                }
            }
        }
    }

    RowLayout {
        id: rowLayout_1

        Layout.fillWidth: true

        UFO_Button {
            text: qsTr("Capture")

            enabled: properties.screenIsSelected
            svg: "./../../icons/Google icons/photo_camera.svg"

            onClicked: {

                // TODO I am not sure if this is possible, but maybe it would be just easier to hide the window instead of
                // minimizing and showing it.
                showMinimized() // Minimize the main window

                if (properties.selectedCaptureMode === 0) {
                    Screenshot.initiateScreenshot(properties.selectedScreen)
                    return
                }

                if (properties.selectedCaptureMode === 1) {
                    var component = Qt.createComponent(
                                "./../components_custom/UFO_SelectionArea.qml")
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

        // TODO See if you can turn this into enum instead:
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

            enabled: Screenshot.screenshotExists
            text: qsTr("Save As")

            Layout.preferredWidth: 120
            Layout.preferredHeight: 40

            svg: "./../../icons/Google icons/save_as.svg"

            onClicked: {
                fileDialog.open()
            }
        }

        UFO_Button {

            enabled: Screenshot.screenshotExists
            text: qsTr("Maximize")

            Layout.preferredWidth: 120
            Layout.preferredHeight: 40

            svg: "./../../icons/Google icons/fullscreen.svg"

            onClicked: {

            }
        }
    }

    Rectangle {
        id: rectangle_1

        Layout.fillWidth: true
        Layout.preferredHeight: Math.round(root.width / 2)

        border.color: "cornflowerblue"
        border.width: 2

        Image {
            id: image_Preview

            anchors.fill: parent

            // TODO Probably a good idea to make the initial value of screenshot to be a black box in construcor of Screenshot.
            source: Screenshot.screenshot
            fillMode: Image.PreserveAspectFit
            smooth: true
        }
    }

    Connections {
        target: Screenshot

        function onScreenshotChanged() {
            showNormal()
        }
    }
}
