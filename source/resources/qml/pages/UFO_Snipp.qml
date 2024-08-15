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

    title: qsTr("Snipp tool")
    contentSpacing: 20

    function onScreenSelected(screenName) {
        console.log("Screen clicked:", screenName)

        for (var i = 0; i < Qt.application.screens.length; i++)
        {
            if (Qt.application.screens[i].name === screenName)
            {
                properties.selectedScreen = Qt.application.screens[i].name;
                break;
            }
        }
    }

    function onAreaSelected(x, y, width, height) {
        // console.log("dimensions recieved!");

        // console.log("recieved x:" + x);
        // console.log("recieved y:" + y);
        // console.log("recieved width:" + width);
        // console.log("recieved hieght:" + height);

        properties.x = x
        properties.y = y
        properties.width = width
        properties.height = height
    }

    QtObject {
        id: properties

        enum CaptureMode {
            FullScreen = 0,
            CustomArea = 1
        }

        property int selectedCaptureMode: 0 // Enums are int
        property string selectedScreen: ""
        property int x: 0
        property int y: 0
        property int width: 0
        property int height: 0
    }

    FileDialog {
        id: fileDialog

        title: "Save File"
        fileMode: FileDialog.SaveFile
        nameFilters: ["Image files (*.png)"]
        currentFolder: StandardPaths.writableLocation(StandardPaths.PicturesLocation)
        defaultSuffix: ".png"

        onAccepted: {
            // Handle the selected file path
            console.log("Selected file path:", fileDialog.selectedFile)
            Screenshot.saveScreenshot(fileDialog.selectedFile)
        }
    }

    Image {
        // TODO Probably a good idea to make the initial value of screenshot to be a black box in construcor of Screenshot.
        Layout.fillWidth: true
        Layout.preferredHeight: 500
        source: Screenshot.screenshot
        fillMode: Image.PreserveAspectFit
        smooth: true
    }

    Flow {
        spacing: 10

        Repeater {
            model: Qt.application.screens

            delegate: UFO_ScreenItem {

                screenName: modelData.name

                //thumbnail.source: Qt.resolvedUrl("path_to_thumbnail/" + model.name + ".png") // Adjust path

                Component.onCompleted: {
                    // Connect the clicked signal of each item to a JavaScript function
                    screenSelected.connect(root.onScreenSelected)
                }
            }
        }
    }

    RowLayout {
        id: rowLayout_1

        UFO_Button {
            text: qsTr("Capture")

            onClicked: {

                showMinimized(); // Minimize the main window

                if(properties.selectedCaptureMode === 0)
                {
                    Screenshot.takeScreenshot(properties.selectedScreen)
                    return;
                }

                if(properties.selectedCaptureMode === 1)
                {
                    var component = Qt.createComponent("./../components_custom/UFO_SelectionArea.qml");
                    var selectionArea = component.createObject(root);

                    selectionArea.selected.connect(onAreaSelected)

                    Screenshot.takeScreenshot(properties.selectedScreen, x, y, width, height)

                    return;
                }
            }
        }

        // TODO See if you can turn this into enum instead:
        UFO_ComboBox {
            Layout.preferredWidth: 200
            model: ["Full Screen", "Custom Area"]

            onCurrentIndexChanged: {
                if(currentText === "Full Screen")
                {
                    properties.selectedCaptureMode = properties.CaptureMode.FullScreen
                    return;
                }

                if(currentText === "Custom Area")
                {
                    properties.selectedCaptureMode = properties.CaptureMode.CustomArea
                    return;
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }

        UFO_Button {

            enabled: Screenshot.screenshotExists
            text: qsTr("Save As")

            onClicked: {
                fileDialog.open()
            }
        }

        UFO_Button {

            enabled: Screenshot.screenshotExists
            text: qsTr("Show Full Screen")

            onClicked: {

            }
        }
    }

    Connections {
        target: Screenshot

        function onScreenshotChanged() {
            showNormal()
        }
    }
}
