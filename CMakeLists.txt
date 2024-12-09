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
    Concurrent
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





# [[ Executable Target ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

qt_add_executable(${EXECUTABLE_NAME})



set(HEADER_FILES

    # HPP
    "${CMAKE_SOURCE_DIR}/main/include/main.hpp")

set(SOURCE_FILES

    # CPP
    "${CMAKE_SOURCE_DIR}/main/src/main.cpp")



target_sources(${EXECUTABLE_NAME}

    PUBLIC
    ${HEADER_FILES}

    PRIVATE
    ${SOURCE_FILES})

target_include_directories(${EXECUTABLE_NAME}

    PUBLIC
    "${CMAKE_SOURCE_DIR}/main/include")

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
    Qt6::Concurrent
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
    "Lib_AppTheme"
    "Lib_Logger"
    "Lib_Screenshot")

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Internal Libraries ]]
