
cmake_minimum_required (VERSION 2.8.13)
project("PROGENY_PROJECT_NAME")

#Define install paths
set(LIBRARY_INSTALL_PATH "/usr/local/lib")
set(HEADER_INSTALL_PATH "/usr/local/include")
set(PRIMARY_EXECUTABLE_INSTALL_PATH "/usr/local/bin")
#set(TEST_EXECUTABLE_INSTALL_PATH)

add_subdirectory(library)
include_directories(${CMAKE_CURRENT_LIST_DIR}/library/inc/)
add_subdirectory(application)

add_subdirectory(test)



