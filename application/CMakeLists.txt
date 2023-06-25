cmake_minimum_required (VERSION 3.0.0)

add_definitions(-DAPPLICATION_VERSION="${CMAKE_PROJECT_VERSION}") #Make project version available to the library as a definition
add_definitions(-DAPPLICATION_RELEASE="${RELEASE}") #Make project release string available to the library as a definition

#set(CMAKE_C_COMPILER "g") #specify g++ compiler
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_LIST_DIR}/bin) # put compiled executable in bin/

if (CMAKE_BUILD_TYPE EQUAL "DEBUG")
    add_compile_options(-g) # -g turns on debugging
    message(STATUS "Building aplication in debug mode")
endif (CMAKE_BUILD_TYPE EQUAL "DEBUG")
if (CMAKE_BUILD_TYPE EQUAL "DEBUG")
    #add_compile_options(-O3) # -g turns on optimizations
    message(STATUS "Building application in release mode")
endif (CMAKE_BUILD_TYPE EQUAL "DEBUG")

find_package( Threads )

add_executable("PROGENY_PROJECT_NAME-bin" src/main.cpp)
include_directories(${CMAKE_CURRENT_LIST_DIR}/inc/)
target_link_libraries("PROGENY_PROJECT_NAME-bin" "PROGENY_PROJECT_NAME-static") #By default, statically link executables to library
target_link_libraries("PROGENY_PROJECT_NAME-bin" Threads::Threads)
set_target_properties("PROGENY_PROJECT_NAME-bin" PROPERTIES OUTPUT_NAME "PROGENY_PROJECT_NAME")

if(DEFINED PRIMARY_EXECUTABLE_INSTALL_PATH AND INSTALL_EXECUTABLES)
    message(STATUS "Will install primary executables at ${PRIMARY_EXECUTABLE_INSTALL_PATH}")
    install(TARGETS PROGENY_PROJECT_NAME-bin DESTINATION ${PRIMARY_EXECUTABLE_INSTALL_PATH})
else()
    message(STATUS "No primary executable will be installed. INSTALL_EXECUTABLES is OFF of PRIMARY_EXECUTABLE_INSTALL_PATH is undefined")
endif()
