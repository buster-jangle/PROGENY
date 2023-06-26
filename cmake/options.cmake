#### BUILD OPTIONS
option(BUILD_TEST "Build unit tests" ON)
option(BUILD_SHARED_LIBS "Build the shared libraries" OFF)
option(BUILD_STATIC_LIBS "Build the static libraries" ON)

#### LINKING OPTIONS
option(LINK_SHARED_LIB "Link the project to a shared version of project library" OFF)

##### INSTALL OPTIONS
option(INSTALL_HEADERS "Install/package with headers. Set to ON when building for developers" ON)
option(INSTALL_SHARED_LIBS "Install/package shared libraries. Use when building for developers, or when building for users and BUILD_SHARED_LIBS is ON." ON)
option(INSTALL_STATIC_LIBS "Install/package static libraries. Set to ON when building for developers" ON)
option(INSTALL_EXECUTABLES "Install/package with executables. Set to OFF if strictly creating a library for build environments" ON)

if(LINK_SHARED_LIBS)
    set(BUILD_SHARED_LIBS ON) # override BUILD_SHARED_LIBS option if LINK_SHARED_LIB is enabled
    set(INSTALL_SHARED_LIBS ON)
    message(STATUS "Override: BUILD_SHARED_LIBS and INSTALL_SHARED_LIBS set to ON due to LINK_SHARED_LIBS.")
endif()

if(INSTALL_SHARED_LIBS AND NOT BUILD_SHARED_LIBS)
    set(BUILD_SHARED_LIBS ON)
    message(STATUS "Override: BUILD_SHARED_LIBS set to ON due to INSTALL_SHARED_LIBS.")
endif()

if(INSTALL_STATIC_LIBS AND NOT BUILD_STATIC_LIBS)
    set(BUILD_STATIC_LIBS ON)
    message(STATUS "Override: BUILD_STATIC_LIBS set to ON due to INSTALL_STATIC_LIBS.")
endif()

### SHOW ENABLED OPTIONS
function(print_cmake_options)
    message(STATUS "CMake Options:")
    message(STATUS "----------------")

    # BUILD OPTIONS
    message(STATUS "  CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
    message(STATUS "  BUILD_TEST: ${BUILD_TEST}")
    message(STATUS "  BUILD_SHARED_LIBS: ${BUILD_SHARED_LIBS}")
    message(STATUS "  BUILD_STATIC_LIBS: ${BUILD_STATIC_LIBS}")

    # LINKING OPTIONS
    message(STATUS "LINKING OPTIONS")
    message(STATUS "  LINK_SHARED_LIB: ${LINK_SHARED_LIB}")

    # INSTALL OPTIONS
    message(STATUS "INSTALL OPTIONS")
    message(STATUS "  INSTALL_HEADERS: ${INSTALL_HEADERS}")
    message(STATUS "  INSTALL_SHARED_LIBS: ${INSTALL_SHARED_LIBS}")
    message(STATUS "  INSTALL_STATIC_LIBS: ${INSTALL_STATIC_LIBS}")
    message(STATUS "  INSTALL_EXECUTABLES: ${INSTALL_EXECUTABLES}")

    message(STATUS "----------------")
endfunction()

# Call the function to print the options
print_cmake_options()