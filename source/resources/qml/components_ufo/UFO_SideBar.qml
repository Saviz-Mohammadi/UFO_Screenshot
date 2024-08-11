import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Item {
    id: root

    signal tabChanged(string pageName)

    implicitWidth: 200
    implicitHeight: 200

    ButtonGroup {
        id: buttonGroup_1
    }

    Rectangle {
        id: rectangle_1

        anchors.fill: parent

        color: Qt.color(AppTheme.colors["UFO_SideBar_Background"])

        ColumnLayout {
            id: columnLayout_1

            anchors.fill: parent

            anchors.topMargin: 20
            anchors.bottomMargin: 20
            spacing: 10

            ScrollView {
                id: scrollView_1

                Layout.fillWidth: true
                Layout.fillHeight: true

                contentWidth: -1 // Prevents scrollview from trying to scroll horizontally.
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                ColumnLayout {
                    id: columnLayout_2

                    anchors.fill: parent

                    clip: true
                    spacing: 10

                    // UFO_SideBarButton {
                    //     id: ufo_SidBarButton_1

                    //     Layout.fillWidth: true
                    //     Layout.preferredHeight: 40

                    //     Layout.leftMargin: 15
                    //     Layout.rightMargin: 15

                    //     ButtonGroup.group: buttonGroup_1

                    //     checkable: true
                    //     autoExclusive: true
                    //     checked: false

                    //     text: qsTr("New page")
                    //     svg: "./../../icons/Google icons/<icon-name>.svg"

                    //     onClicked: {
                    //         root.tabChanged("Page name")
                    //     }
                    // }

                    // Add more tabs here...
                }
            }

            // We could place the entire section below inside the "ScrollView" in the above section.
            // This would simplify our structure. However, I think it's beneficial to always have
            // tabs like "Settings" and "About" visible at the bottom.
            Item {
                id: item_1

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            UFO_SideBarSeparator {
                id: ufo_SidBarSeparator_1

                Layout.fillWidth: true
                Layout.preferredHeight: 1

                Layout.leftMargin: 4
                Layout.rightMargin: 4
            }

            UFO_SideBarButton {
                id: ufo_SidBarButton_3

                Layout.fillWidth: true
                Layout.preferredHeight: 40

                Layout.topMargin: 10
                Layout.leftMargin: 15
                Layout.rightMargin: 15

                ButtonGroup.group: buttonGroup_1

                checkable: true
                autoExclusive: true
                checked: false

                text: qsTr("Settings")
                svg: "./../../icons/Google icons/settings.svg"

                onClicked: {
                    root.tabChanged("Settings page")
                }
            }

            UFO_SideBarButton {
                id: ufo_SidBarButton_4

                Layout.fillWidth: true
                Layout.preferredHeight: 40

                Layout.leftMargin: 15
                Layout.rightMargin: 15

                ButtonGroup.group: buttonGroup_1

                checkable: true
                autoExclusive: true
                checked: true

                text: qsTr("About")
                svg: "./../../icons/Google icons/help.svg"

                onClicked: {
                    root.tabChanged("About page")
                }
            }
        }
    }
}
