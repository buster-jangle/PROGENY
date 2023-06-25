#Doxygen section
#First we can indicate the documentation build as an option and set it to OFF by default
option(BUILD_DOC "Build documentation" OFF)
if (BUILD_DOC)
    # check if Doxygen is installed
    find_package(Doxygen
            REQUIRED dot)
    if (DOXYGEN_FOUND)
        # set input and output files
        set(DOXYGEN_IN docs/Doxyfile.in)
        set(DOXYGEN_OUT ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)
        #set(DOXYGEN_PROJECT_BRIEF ${CMAKE_PROJECT_DESCRIPTION})
        #set(DOXYGEN_PROJECT_NAME ${CMAKE_PROJECT_NAME})

        # request to configure the file
        configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)
        message("Doxygen build started")

        # note the option ALL which allows to build the docs together with the application
        add_custom_target( doc_doxygen ALL
                COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                COMMENT "Generating API documentation with Doxygen"
                VERBATIM )
    else (DOXYGEN_FOUND)
        message("Doxygen need to be installed to generate the doxygen documentation")
    endif (DOXYGEN_FOUND)
    #include(InstallRequiredSystemLibraries)
endif(BUILD_DOC)