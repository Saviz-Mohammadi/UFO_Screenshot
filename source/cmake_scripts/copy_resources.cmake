# [[ Custom Targets - CopyResources ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

# Custom target for copying resource files.
add_custom_target(CopyResources)



foreach(RESOURCE_FILE ${RESOURCE_FILES})

    # Get the relative path of the current resource file from where it differs to ${RESOURCE_BASE_ORIGIN_LOCATION}.
    file(RELATIVE_PATH REL_PATH ${RESOURCE_BASE_ORIGIN_LOCATION} ${RESOURCE_FILE})

    # Construct the destination path including relative subdirectory.
    set(DESTINATION_PATH "${RESOURCE_BASE_DESTINATION_LOCATION}/${REL_PATH}")

    message(STATUS "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")

    # Custom command to copy the resource file.
    add_custom_command(TARGET CopyResources POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${RESOURCE_FILE}"
        "${DESTINATION_PATH}"
        COMMENT "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")
endforeach()



add_dependencies(${EXECUTABLE_NAME} CopyResources)

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Custom Targets - CopyResources ]]
