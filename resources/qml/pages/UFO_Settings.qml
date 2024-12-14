import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom QML Files
import "./../components_ufo"

// Custom CPP Registered Types
import AppTheme 1.0

UFO_Page {
    id: root

    title: qsTr("Application Settings")
    contentSpacing: 20

    UFO_GroupBox {
        Layout.fillWidth: true
        // NOTE (SAVIZ): No point using "Layout.fillHeight" as "UFO_Page" ignores height to enable vertical scrolling.

        title: qsTr("Style")
        contentSpacing: 0

        Text {
            Layout.fillWidth: true

            Layout.topMargin: 20
            Layout.bottomMargin: 0
            Layout.leftMargin: 15
            Layout.rightMargin: 15

            color: Qt.color(AppTheme.colors["UFO_GroupBox_Content_Text"])

            text: qsTr("The theme will be cached and loaded on application launch.")

            wrapMode: Text.WordWrap
            elide: Text.ElideRight
        }

        UFO_ComboBox {
            id: ufo_ComboBox_Style

            Layout.fillWidth: true
            Layout.preferredHeight: 35

            Layout.topMargin: 7
            Layout.bottomMargin: 20
            Layout.leftMargin: 15
            Layout.rightMargin: 15

            model: Object.keys(AppTheme.themes)

            onActivated: {
                AppTheme.loadColorsFromTheme(currentText)
            }

            Component.onCompleted: {
                var cachedTheme = AppTheme.getCachedTheme()

                for (var index = 0; index < ufo_ComboBox_Style.model.length; ++index) {

                    if (cachedTheme === "" && ufo_ComboBox_Style.model[index] === "ufo_light") {
                        ufo_ComboBox_Style.currentIndex = index

                        break
                    }

                    if (ufo_ComboBox_Style.model[index] === cachedTheme) {
                        ufo_ComboBox_Style.currentIndex = index

                        break
                    }
                }
            }
        }
    }
}
