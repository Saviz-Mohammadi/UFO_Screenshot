# [[ Custom target for detecting resources ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

# This script section is useful for displaying the files in IDEs.

file(GLOB_RECURSE
        
        TXT_FILES
        
        "${PROJECT_SOURCE_DIR}/resources/txt/*")

file(GLOB_RECURSE
        
        QML_FILES
        
        "${PROJECT_SOURCE_DIR}/resources/qml/*")
        
file(GLOB_RECURSE
        
        MUSIC_FILES
        
        "${PROJECT_SOURCE_DIR}/resources/music/*")
        
file(GLOB_RECURSE
        
        JSON_FILES
        
        "${PROJECT_SOURCE_DIR}/resources/json/*")
        
file(GLOB_RECURSE
        
        ICON_FILES
        
        "${PROJECT_SOURCE_DIR}/resources/icons/*")

file(GLOB_RECURSE
        
        FONT_FILES
        
        "${PROJECT_SOURCE_DIR}/resources/fonts/*")



source_group("Resources\\TXT"
        
        FILES
        
        ${TXT_FILES})
        
source_group("Resources\\QML"
        
        FILES
        
        ${QML_FILES})

source_group("Resources\\MUSIC"
        
        FILES
        
        ${MUSIC_FILES})
        
source_group("Resources\\JSON"
        
        FILES
        
        ${JSON_FILES})

source_group("Resources\\ICONS"
        
        FILES
        
        ${ICONS_FILES})
        
source_group("Resources\\FONTS"
        
        FILES
        
        ${FONTS_FILES})



add_custom_target(DetectResources
        
        SOURCES

        ${TXT_FILES}
        ${QML_FILES}
        ${MUSIC_FILES}
        ${JSON_FILES}
        ${ICON_FILES}
        ${FONT_FILES})

add_dependencies(${EXECUTABLE_NAME} DetectResources)

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Custom target for detecting resources ]]





# [[ Custom target for copying resources ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

add_custom_target(CopyResources ALL
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${PROJECT_SOURCE_DIR}/resources
        ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/resources
        COMMENT "Copying resources into executable location")

add_dependencies(${EXECUTABLE_NAME} CopyResources)

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Custom target for copying resources ]]
