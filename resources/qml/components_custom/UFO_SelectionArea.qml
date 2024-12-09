import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom QML Files
import "./../components_ufo"

// Custom CPP Registered Types
import AppTheme 1.0

Window {
    id: root

    signal selected(int x, int y, int width, int height)
    signal canceled()

    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    modality: Qt.ApplicationModal
    color: "transparent"

    Component.onCompleted: {
        showFullScreen()
    }

    Rectangle {
        id: mainRect

        x: parent.width / 2 - (width / 2)
        y: parent.height / 2 - (height / 2)
        width: 300
        height: 300

        focus: true
        opacity: 0.5

        border {
            color: "cornflowerblue"
            width: 3
        }

        Keys.onPressed: (event)=> {
            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                console.log("Global Enter key pressed");

                root.selected(
                    //root.screen,
                    mainRect.x,
                    mainRect.y,
                    mainRect.width,
                    mainRect.height
                )

                event.accepted = true;  // Prevent other items from handling this event
                root.destroy(0)
            }

            if (event.key === Qt.Key_Escape) {
                console.log("Global Escape key pressed");

                root.canceled();  // Just in case we need it later.

                event.accepted = true;  // Prevent other items from handling this event
                root.destroy(0)
            }
        }

        Text {
            id: text_dimensions

            anchors.centerIn: parent

            z: 0
            text: qsTr(mainRect.x + " X " + mainRect.y)
                  + "\n" +
                  qsTr(mainRect.width + " X " + mainRect.height)
        }

        // ColumnLayout {
        //     anchors.centerIn: parent





        //     // // Maybe replace this with arrow keys being pressed
        //     // ComboBox {
        //     //     id: screenComboBox
        //     //     model: Qt.application.screens
        //     //     textRole: "name"

        //     //     opacity: 1.0

        //     //     onCurrentIndexChanged: {
        //     //         var selectedScreen = Qt.application.screens[currentIndex];
        //     //         if (selectedScreen) {
        //     //             root.screen = selectedScreen;
        //     //             console.log("Window moved to screen:", selectedScreen.name);
        //     //         }
        //     //     }

        //     //     Component.onCompleted: {
        //     //         screenComboBox.currentIndex = Qt.application.screens.indexOf(root.screen);
        //     //     }
        //     // }
        // }

        // This MousArea takes care of dragging (moving)
        MouseArea {
            id: mouseArea_dragging
            anchors.fill: parent
            drag.target: mainRect
            drag.axis: Drag.XAxis | Drag.YAxis
            drag.minimumX: 0
            drag.minimumY: 0
            drag.maximumX: root.width - mainRect.width
            drag.maximumY: root.height - mainRect.height

            z: 1
        }

        UFO_SelectionCircle {
            id: left
            anchors { horizontalCenter: mainRect.left; verticalCenter: mainRect.verticalCenter }

            MouseArea {
                id: leftHandle
                anchors.fill: parent
                cursorShape: Qt.SizeHorCursor

                property bool resizing: false

                onPressed: {
                    resizing = true
                }

                onReleased: {
                    resizing = false
                }

                onPositionChanged: {
                    if (resizing) {
                        // The 12 is half of the handler width to make sure there is no offset.
                        var newWidth = Math.max(mainRect.width - mouseX + 12, 30); // The 30 makes sure that the rectangle does not get too small
                        var deltaX = mainRect.width - newWidth;
                        var newX = mainRect.x + deltaX;

                        // Clamp X to ensure the rectangle stays within the screen boundaries
                        newX = Math.max(0, newX);
                        newWidth = Math.min(root.width - newX, newWidth);

                        mainRect.width = newWidth;
                        mainRect.x = newX;
                    }
                }
            }
        }

        UFO_SelectionCircle {
            id: right
            anchors { horizontalCenter: mainRect.right; verticalCenter: mainRect.verticalCenter }

            MouseArea {
                id: rightHandle
                anchors.fill: parent
                cursorShape: Qt.SizeHorCursor

                property bool resizing: false

                onPressed: {
                    resizing = true
                }

                onReleased: {
                    resizing = false
                }

                onPositionChanged: {
                    if (resizing) {
                        var newWidth = Math.max(mainRect.width + mouseX, 30);
                        var previousX = mainRect.x;

                        // Clamp width to ensure the rectangle stays within the screen boundaries
                        newWidth = Math.min(root.width - mainRect.x, newWidth);

                        mainRect.width = newWidth;
                        mainRect.x = previousX;
                    }
                }
            }
        }

        UFO_SelectionCircle {
            id: top
            anchors { horizontalCenter: mainRect.horizontalCenter; verticalCenter: mainRect.top }

            MouseArea {
                id: topHandle
                anchors.fill: parent
                cursorShape: Qt.SizeVerCursor

                property bool resizing: false

                onPressed: {
                    resizing = true
                }

                onReleased: {
                    resizing = false
                }

                onPositionChanged: {
                    if (resizing) {
                        var newHeight = Math.max(mainRect.height - mouseY + 12, 30);
                        var deltaY = mainRect.height - newHeight;
                        var newY = mainRect.y + deltaY;

                        // Clamp Y to ensure the rectangle stays within the screen boundaries
                        newY = Math.max(0, newY);
                        newHeight = Math.min(root.height - newY, newHeight);

                        mainRect.height = newHeight;
                        mainRect.y = newY;
                    }
                }
            }
        }

        UFO_SelectionCircle {
            id: bottom
            anchors { horizontalCenter: mainRect.horizontalCenter; verticalCenter: mainRect.bottom }

            MouseArea {
                id: bottomHandle
                anchors.fill: parent
                cursorShape: Qt.SizeVerCursor

                property bool resizing: false

                onPressed: {
                    resizing = true
                }

                onReleased: {
                    resizing = false
                }

                onPositionChanged: {
                    if (resizing) {
                        var newHeight = Math.max(mainRect.height + mouseY, 30);
                        var previousY = mainRect.y;

                        // Clamp height to ensure the rectangle stays within the screen boundaries
                        newHeight = Math.min(root.height - mainRect.y, newHeight);

                        mainRect.height = newHeight;
                        mainRect.y = previousY;
                    }
                }
            }
        }
    }
}
