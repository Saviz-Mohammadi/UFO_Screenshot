import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom QML Files
import "components_ufo"
import "components_custom"
import "pages"

// Custom CPP Registered Types
import AppTheme 1.0

ApplicationWindow {
    id: rootWindow

    width: 800
    height: 600

    visible: true
    title: qsTr("UFO_Screenshot")

    menuBar: UFO_MenuBar {
        spacing: 0

        UFO_Menu {
            topMargin: 0
            leftMargin: 0

            title: qsTr("File")

            UFO_MenuItem {
                leftPadding: 10
                rightPadding: 10

                text: qsTr("Quit")

                onTriggered: {
                    Qt.quit()
                }
            }
        }

        UFO_Menu {
            topMargin: 0
            leftMargin: 0

            title: qsTr("View")

            UFO_MenuItem {
                leftPadding: 10
                rightPadding: 10

                text: qsTr("Snipp Page")

                onTriggered: {
                    stackLayout.currentIndex = ufo_Snipp.StackLayout.index

                    ufo_SideBar_Main.checkTabButton("Snipp Page")
                }
            }

            UFO_MenuItem {
                leftPadding: 10
                rightPadding: 10

                text: qsTr("Settings Page")

                onTriggered: {
                    stackLayout.currentIndex = ufo_Settings.StackLayout.index

                    ufo_SideBar_Main.checkTabButton("Settings Page")
                }
            }

            UFO_MenuItem {
                leftPadding: 10
                rightPadding: 10

                text: qsTr("About Page")

                onTriggered: {
                    stackLayout.currentIndex = ufo_About.StackLayout.index

                    ufo_SideBar_Main.checkTabButton("About Page")
                }
            }
        }

        UFO_Menu {
            topMargin: 0
            leftMargin: 0

            title: qsTr("Help")

            UFO_MenuItem {
                leftPadding: 10
                rightPadding: 10

                text: qsTr("About UFO_Screenshot")

                onTriggered: {
                    stackLayout.currentIndex = ufo_About.StackLayout.index

                    ufo_SideBar_Main.checkTabButton("About Page")
                }
            }
        }
    }

    footer: UFO_StatusBar {
        id: ufo_StatusBar

        text: qsTr("Application ready...")
    }


    UFO_SplitView {
        anchors.fill: parent

        UFO_SideBar {
            id: ufo_SideBar_Main

            // NOTE (SAVIZ): Initial startup width for the main SideBar.
            Layout.preferredWidth: 200
            Layout.fillHeight: true
        }

        StackLayout {
            id: stackLayout

            Layout.fillWidth: true
            Layout.fillHeight: true

            UFO_Snipp {
                id: ufo_Snipp

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            UFO_Settings {
                id: ufo_Settings

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            UFO_About {
                id: ufo_About

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Connections {
                target: ufo_SideBar_Main

                function onTabChanged(pageName) {

                    // TODO (SAVIZ): I like to replace these with an enum, but currently I don't know how in QML.
                    switch (pageName) {
                        case "Snipp Page":
                            stackLayout.currentIndex = ufo_Snipp.StackLayout.index
                            break
                        case "Settings Page":
                            stackLayout.currentIndex = ufo_Settings.StackLayout.index
                            break
                        case "About Page":
                            stackLayout.currentIndex = ufo_About.StackLayout.index
                            break
                        default:
                            stackLayout.currentIndex = -1
                    }
                }
            }

            Component.onCompleted: {
                stackLayout.currentIndex = ufo_About.StackLayout.index
            }
        }
    }
}
