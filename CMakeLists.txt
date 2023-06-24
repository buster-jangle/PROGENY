
#cmake_minimum_required (VERSION 2.8.13)
#project("PROGENY_PROJECT_NAME")
cmake_minimum_required (VERSION 3.0.0)
project("PROGENY_PROJECT_NAME"
        VERSION 1.0.1
        LANGUAGES CXX
        DESCRIPTION "Put a one-liner description of your project here, and it will be included in documentation"
        )



#set(PROGENY_PROJECT_NAME_VERSION_MAJOR 1)
#set(PROGENY_PROJECT_NAME_VERSION_MINOR 0)
#set(PROGENY_PROJECT_NAME_VERSION_PATCH 0)

#Enable testing with CTest
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME) #This makes sure to only include Ctest if this is the main project (Avoids pointless testing is this project is used as a submodule)
    include(CTest)
endif()

#Define install paths
set(LIBRARY_INSTALL_PATH "/usr/local/lib")
set(HEADER_INSTALL_PATH "/usr/local/include")
set(PRIMARY_EXECUTABLE_INSTALL_PATH "/usr/local/bin")
#set(TEST_EXECUTABLE_INSTALL_PATH)

#Automatically pull/update submodules before adding submodules directory
find_package(Git QUIET)

##### Update submodules before adding them as subdirectories
if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
    # Update submodules as needed
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
        execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init --recursive failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
        endif()
    endif()
endif()
#Add submodule directory after updating
add_subdirectory(submodule)

#Include submodule headers
include_directories(${CMAKE_CURRENT_LIST_DIR}/submodule/plog/include)
include_directories(${CMAKE_CURRENT_LIST_DIR}/submodule/CLI11/include)


add_subdirectory(library)
include_directories(${CMAKE_CURRENT_LIST_DIR}/library/inc/)
add_subdirectory(application)

add_subdirectory(test)

#Doxygen section
#First we can indicate the documentation build as an option and set it to OFF by default
option(BUILD_DOC "Build documentation" OFF)
if (BUILD_DOC)
# check if Doxygen is installed
find_package(Doxygen)
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

SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Project derived from PROGENY")
SET(CPACK_PACKAGE_VENDOR "buster-jangle")
set(CPACK_PACKAGE_CONTACT yourContactInfo) #Debian packages require contact info for maintainer responsible for the package, such as your company email
SET(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE") #Add your license file here

set(CPACK_SOURCE_GENERATOR "TGZ") #Generate tar.gz compresssed sourcecode package

set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT) #This is needed so that package architecture gets specified properly.
set(CPACK_GENERATOR "DEB") #generate debian install package
#set(CPACK_DEBIAN_PACKAGE_DEPENDS "libc6 (>= 2.3.1-6), libc6 (< 2.4)") #Set debian package dependencies (must also be debian packages)

include(CPack)
