cmake_minimum_required(VERSION 3.0.0)

add_definitions(-DAPPLICATION_VERSION="${CMAKE_PROJECT_VERSION}") # Make project version available to the library as a definition
add_definitions(-DAPPLICATION_RELEASE="${RELEASE}") # Make project release string available to the library as a definition

##### Link to the core PROGENY_PROJECT_NAME project library.
if(LINK_SHARED_LIB)
    list(APPEND LINK_APPLICATION_LIST PROGENY_PROJECT_NAME) # Link the application to a shared version of the library
    message(STATUS "Linking application to shared library: PROGENY_PROJECT_NAME")
else()
    list(APPEND LINK_APPLICATION_LIST PROGENY_PROJECT_NAME-static) # Link the application to a static version of the library
    message(STATUS "Linking application to static library: PROGENY_PROJECT_NAME-static")
endif()

#message(STATUS "Linking application libs: ${LINK_APPLICATION_LIST}")
#message(STATUS "Linking application libs:\n\t${LINK_APPLICATION_LIST}")
message(STATUS "Linking application libs:")
foreach(lib ${LINK_APPLICATION_LIST})
    message(STATUS "\t${lib}")
endforeach()


if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_compile_options(-g) # -g turns on debugging
    message(STATUS "Building application in debug mode")
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    # add_compile_options(-O3) # -g turns on optimizations
    message(STATUS "Building application in release mode")
else()
    message(STATUS "Building application with unknown build type")
endif()

#if (CMAKE_BUILD_TYPE EQUAL "DEBUG")
#    add_compile_options(-g) # -g turns on debugging
#    message(STATUS "Building aplication in debug mode")
#endif (CMAKE_BUILD_TYPE EQUAL "DEBUG")
#if (CMAKE_BUILD_TYPE EQUAL "DEBUG")
#    #add_compile_options(-O3) # -g turns on optimizations
#    message(STATUS "Building application in release mode")
#endif (CMAKE_BUILD_TYPE EQUAL "DEBUG")

find_package(Threads)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_LIST_DIR}/bin) # Put compiled executable in bin/
add_executable(PROGENY_PROJECT_NAME-bin src/main.cpp)
include_directories(${CMAKE_CURRENT_LIST_DIR}/inc/)
target_link_libraries(PROGENY_PROJECT_NAME-bin ${LINK_APPLICATION_LIST}) # Link to a list of libraries declared in top-level cmake-lists
set_target_properties(PROGENY_PROJECT_NAME-bin PROPERTIES OUTPUT_NAME PROGENY_PROJECT_NAME)

if(DEFINED PRIMARY_EXECUTABLE_INSTALL_PATH AND INSTALL_EXECUTABLES)
    message(STATUS "Will install primary executables at ${PRIMARY_EXECUTABLE_INSTALL_PATH}")
    install(TARGETS PROGENY_PROJECT_NAME-bin DESTINATION ${PRIMARY_EXECUTABLE_INSTALL_PATH})
else()
    message(STATUS "No primary executable will be installed. INSTALL_EXECUTABLES is OFF or PRIMARY_EXECUTABLE_INSTALL_PATH is undefined")
endif()