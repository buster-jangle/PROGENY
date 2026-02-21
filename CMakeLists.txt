
#cmake_minimum_required (VERSION 2.8.13)
#project("PROGENY_PROJECT_NAME")
cmake_minimum_required (VERSION 3.8.0)
#Set your project name and verison here
project("PROGENY_PROJECT_NAME"
        VERSION 1.2.1
        LANGUAGES CXX
        DESCRIPTION "Put a one-liner description of your project here, and it will be included in documentation"
        )
#Add submodule directory first. Adding it later will override the following CPack options
add_subdirectory(submodule)

#Set build type to release, unless otherwise specified. Also restrict available build types for managable conditional setting
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type" FORCE)
endif()
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")

set(CMAKE_EXTRA_SCRIPT_DIR ${PROJECT_SOURCE_DIR}/cmake/)
include(${CMAKE_EXTRA_SCRIPT_DIR}/options.cmake)
include(${CMAKE_EXTRA_SCRIPT_DIR}/build_info.cmake)
include(${CMAKE_EXTRA_SCRIPT_DIR}/config_doxygen.cmake)

#Set build information
gather_build_info()

#Include submodule headers
include_directories(${CMAKE_CURRENT_LIST_DIR}/submodule/plog/include)
include_directories(${CMAKE_CURRENT_LIST_DIR}/submodule/CLI11/include)
#include project library header
include_directories(${CMAKE_CURRENT_LIST_DIR}/library/inc/)
#include project application headers
include_directories(${CMAKE_CURRENT_LIST_DIR}/application/inc/)

#Define install paths
set(LIBRARY_INSTALL_PATH "/usr/local/lib")
set(HEADER_INSTALL_PATH "/usr/local/include")
set(PRIMARY_EXECUTABLE_INSTALL_PATH "/usr/local/bin")
#set(TEST_EXECUTABLE_INSTALL_PATH)

### List of libraries to link the project application to
set(LINK_APPLICATION_LIST)
list(APPEND LINK_APPLICATION_LIST
        Threads::Threads
        ftxui::screen
        ftxui::dom
        ftxui::component
        )
find_package(Threads) #Almost all projects should have multithreading
### List of libraries to link the project library to
set(LINK_PROJECT_LIBRARY_LIST)
list(APPEND LINK_PROJECT_LIBRARY_LIST
        Threads::Threads
        ftxui::screen
        ftxui::dom
        ftxui::component
        )
### List of libraries to link the tests to
set(LINK_TESTS_LIST)
list(APPEND LINK_TESTS_LIST
        Threads::Threads
        )

#Add the project library and application directories
add_subdirectory(library)
add_subdirectory(application)

# Optionally include and build tests if this is the main project, and BUILD_TEST is enabled (ON by default)
if((CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME) AND BUILD_TEST)
    message(STATUS "Building tests.")
    #Enable testing with CTest
    include(CTest)
    add_subdirectory(test)
endif()


include(${CMAKE_EXTRA_SCRIPT_DIR}/config_cpack.cmake)




