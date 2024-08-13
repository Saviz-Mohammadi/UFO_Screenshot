cmake_minimum_required(VERSION 3.16 FATAL_ERROR)


# [[ Project ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

project("UFO_Screenshot"

    VERSION 0.0.1

    DESCRIPTION "A simple utility for taking screenshots of desktop screen"

    LANGUAGES CXX)


set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


set(EXECUTABLE_NAME "${PROJECT_NAME}")

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Project ]]





# [[ Finding Qt Components ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

find_package(Qt6 6.7.2 COMPONENTS

    REQUIRED

    Core
    Widgets
    Gui
    Quick
    QuickControls2
    Network
    Sql
    Multimedia)

# Add more Qt Components as needed...

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Finding Qt Components ]]





# [[ Output Locations ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

set(OUTPUT_DIRECTORY "")




if(CMAKE_SIZEOF_VOID_P EQUAL 8)

    set(OUTPUT_DIRECTORY

        "${CMAKE_BINARY_DIR}/bin/${CMAKE_SYSTEM_NAME}/64-bit/")
endif()


if(CMAKE_SIZEOF_VOID_P EQUAL 4)

    set(OUTPUT_DIRECTORY

        "${CMAKE_BINARY_DIR}/bin/${CMAKE_SYSTEM_NAME}/32-bit/")
endif()




set(CMAKE_RUNTIME_OUTPUT_DIRECTORY	# Defines executable path

    "${OUTPUT_DIRECTORY}/$<CONFIG>/executable")


set(CMAKE_LIBRARY_OUTPUT_DIRECTORY	# Defines shared lib path

    "${OUTPUT_DIRECTORY}/$<CONFIG>/executable")


set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY	# Defines static lib path

    "${OUTPUT_DIRECTORY}/$<CONFIG>/lib_static")

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Output Locations ]]





# [[ Resource Files ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]


# This determines the base location where CMake can expect to find your resources.
# Relative paths of where your filse can be found in the output location are deterimned based of this.
set(RESOURCE_BASE_ORIGIN_LOCATION

    "${CMAKE_SOURCE_DIR}/resources")

# This determines where your base resources location in the final build will endup locating.
set(RESOURCE_BASE_DESTINATION_LOCATION

    "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/resources")


# Make sure to prefix the path with ${RESOURCE_BASE_ORIGIN_LOCATION}.
set(RESOURCE_FILES

    # JSON
    "${RESOURCE_BASE_ORIGIN_LOCATION}/json/placeholder.json"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/json/themes/theme_ufo/ufo_light.json"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/json/themes/theme_ufo/ufo_dark.json"

    # ICONS
    "${RESOURCE_BASE_ORIGIN_LOCATION}/icons/Google icons/help.svg"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/icons/Google icons/settings.svg"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/icons/Google icons/imagesmode.svg"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/icons/Application icons/ufo.png"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/icons/Application icons/ufo.ico"

    # TTF
    "${RESOURCE_BASE_ORIGIN_LOCATION}/fonts/Titillium_Web/TitilliumWeb-Black.ttf"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/fonts/Titillium_Web/TitilliumWeb-Bold.ttf"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/fonts/Titillium_Web/TitilliumWeb-BoldItalic.ttf"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/fonts/Titillium_Web/TitilliumWeb-ExtraLight.ttf"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/fonts/Titillium_Web/TitilliumWeb-ExtraLightItalic.ttf"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/fonts/Titillium_Web/TitilliumWeb-Italic.ttf"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/fonts/Titillium_Web/TitilliumWeb-Light.ttf"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/fonts/Titillium_Web/TitilliumWeb-LightItalic.ttf"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/fonts/Titillium_Web/TitilliumWeb-Regular.ttf"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/fonts/Titillium_Web/TitilliumWeb-SemiBold.ttf"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/fonts/Titillium_Web/TitilliumWeb-SemiBoldItalic.ttf"

    # QML
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/main.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_MenuBar.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_MenuBarItem.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_Menu.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_MenuItem.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_MenuSeparator.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_MenuItemIndicator.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_MenuItemArrow.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_StatusBar.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_SideBarButton.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_SideBar.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_Page.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_SideBarSeparator.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_GroupBox.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_ComboBox.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_TextField.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_ufo/UFO_Button.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_custom/UFO_RoundProgressBar.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_custom/UFO_SelectionArea.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/components_custom/UFO_SelectionCircle.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/pages/UFO_About.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/pages/UFO_Settings.qml"
    "${RESOURCE_BASE_ORIGIN_LOCATION}/qml/pages/UFO_Snipp.qml")

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Resource Files ]]





# [[ Executable Target ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

qt_add_executable(${EXECUTABLE_NAME})





set(HEADER_FILES

    # HPP
    "${CMAKE_SOURCE_DIR}/internal_libraries/main/include/main.hpp")

set(SOURCE_FILES

    # CPP
    "${CMAKE_SOURCE_DIR}/internal_libraries/main/src/main.cpp")




target_sources(${EXECUTABLE_NAME}

    PUBLIC
    ${HEADER_FILES}

    PRIVATE
    ${SOURCE_FILES}

    # Resource Files
    ${RESOURCE_FILES})




target_include_directories(${EXECUTABLE_NAME}

    PUBLIC
    "${CMAKE_SOURCE_DIR}/internal_libraries/main/include")

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Executable Target ]]





# [[ Compile Definitions ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

if(CMAKE_SIZEOF_VOID_P EQUAL 8)

    target_compile_definitions(${EXECUTABLE_NAME}

        PUBLIC
        "TARGET_IS_64_BIT")
endif()


if(CMAKE_SIZEOF_VOID_P EQUAL 4)

    target_compile_definitions(${EXECUTABLE_NAME}

        PUBLIC
        "TARGET_IS_32_BIT")
endif()

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Compile Definitions ]]





# [[ Custom tools ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

include("${CMAKE_SOURCE_DIR}/cmake_scripts/copy_resources.cmake")

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Custom tools ]]





# [[ Adding Qt libraries ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

target_link_libraries(${EXECUTABLE_NAME}

    PRIVATE

    Qt6::Core
    Qt6::Widgets
    Qt6::Gui
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Network
    Qt6::Sql
    Qt6::Multimedia)




set_target_properties(${EXECUTABLE_NAME} PROPERTIES

    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.${EXECUTABLE_NAME}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE)




include(GNUInstallDirs)

install(TARGETS ${EXECUTABLE_NAME}

    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Adding Qt libraries ]]





# [[ Internal Libraries ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

add_subdirectory("${CMAKE_SOURCE_DIR}/internal_libraries")




target_link_libraries(${EXECUTABLE_NAME}

    PRIVATE
    "Lib_AppTheme")

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Internal Libraries ]]
