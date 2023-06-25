
#cmake_minimum_required (VERSION 2.8.13)
#project("PROGENY_PROJECT_NAME")
cmake_minimum_required (VERSION 3.0.0)
project("PROGENY_PROJECT_NAME"
        VERSION 1.0.1
        LANGUAGES CXX
        DESCRIPTION "Put a one-liner description of your project here, and it will be included in documentation"
        )

#Include submodule headers
include_directories(${CMAKE_CURRENT_LIST_DIR}/submodule/plog/include)
include_directories(${CMAKE_CURRENT_LIST_DIR}/submodule/CLI11/include)
#include project library header
include_directories(${CMAKE_CURRENT_LIST_DIR}/library/inc/)
#include project application headers
include_directories(${CMAKE_CURRENT_LIST_DIR}/application/inc/)

set(CMAKE_EXTRA_SCRIPT_DIR ${PROJECT_SOURCE_DIR}/cmake/)
include(${CMAKE_EXTRA_SCRIPT_DIR}/options.cmake)
include(${CMAKE_EXTRA_SCRIPT_DIR}/set_release.cmake)
include(${CMAKE_EXTRA_SCRIPT_DIR}/config_doxygen.cmake)
include(${CMAKE_EXTRA_SCRIPT_DIR}/config_cpack.cmake)
include(${CMAKE_EXTRA_SCRIPT_DIR}/tests.cmake)

#Define install paths
set(LIBRARY_INSTALL_PATH "/usr/local/lib")
set(HEADER_INSTALL_PATH "/usr/local/include")
set(PRIMARY_EXECUTABLE_INSTALL_PATH "/usr/local/bin")
#set(TEST_EXECUTABLE_INSTALL_PATH)


#Add submodule directory
add_subdirectory(submodule)
#Add projct library and application directory
add_subdirectory(library)
add_subdirectory(application)





