import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Item {
    id: root

    signal tabChanged(string pageName)

    function checkTabButton(targetButton) {

        // TODO (SAVIZ): I like to replace these with an enum, but currently I don't know how in QML.
        switch (targetButton) {
            case "Snipp Page":
                ufo_SidBarButton_Snipp.checked = true
                break
            case "Settings Page":
                ufo_SidBarButton_Settings.checked = true
                break
            case "About Page":
                ufo_SidBarButton_About.checked = true
                break
            default:
                console.log("No valid value");
        }
    }

    implicitWidth: 200
    implicitHeight: 200

    ButtonGroup {
        id: buttonGroup
    }

    Rectangle {
        anchors.fill: parent

        color: Qt.color(AppTheme.colors["UFO_SideBar_Background"])

        ColumnLayout {
            anchors.fill: parent

            anchors.topMargin: 20
            anchors.bottomMargin: 20

            spacing: 10

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true

                // NOTE (SAVIZ): Setting "contentWidth" to -1 will disable horizontal scrolling.
                contentWidth: -1
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                ColumnLayout {
                    anchors.fill: parent

                    clip: true
                    spacing: 10

                    UFO_SideBarButton {
                        id: ufo_SidBarButton_Snipp

                        Layout.fillWidth: true
                        Layout.preferredHeight: 40

                        Layout.leftMargin: 15
                        Layout.rightMargin: 15

                        ButtonGroup.group: buttonGroup

                        checkable: true
                        autoExclusive: true
                        checked: false

                        text: qsTr("Snipp")
                        svg: "./../../icons/Google icons/photo_camera.svg"

                        onClicked: {
                            root.tabChanged("Snipp Page")
                        }
                    }

                    // NOTE (SAVIZ): Add more buttons as needed...
                }
            }

            // NOTE (SAVIZ): The entire below section can be placed inside the "ScrollView" in the above section. However, I think it's beneficial to always have pages like "Settings" and "About" be visible at the bottom at all times.
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            UFO_SideBarSeparator {
                Layout.fillWidth: true
                Layout.preferredHeight: 1

                Layout.leftMargin: 4
                Layout.rightMargin: 4
            }

            UFO_SideBarButton {
                id: ufo_SidBarButton_Settings

                Layout.fillWidth: true
                Layout.preferredHeight: 40

                Layout.topMargin: 10
                Layout.leftMargin: 15
                Layout.rightMargin: 15

                ButtonGroup.group: buttonGroup

                checkable: true
                autoExclusive: true
                checked: false

                text: qsTr("Settings")
                svg: "./../../icons/Google icons/settings.svg"

                onClicked: {
                    root.tabChanged("Settings Page")
                }
            }

            UFO_SideBarButton {
                id: ufo_SidBarButton_About

                Layout.fillWidth: true
                Layout.preferredHeight: 40

                Layout.leftMargin: 15
                Layout.rightMargin: 15

                ButtonGroup.group: buttonGroup

                checkable: true
                autoExclusive: true
                checked: true

                text: qsTr("About")
                svg: "./../../icons/Google icons/help.svg"

                onClicked: {
                    root.tabChanged("About Page")
                }
            }
        }
    }
}
