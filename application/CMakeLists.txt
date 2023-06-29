cmake_minimum_required(VERSION 3.0.0)

add_definitions(-DAPPLICATION_VERSION="${CMAKE_PROJECT_VERSION}") # Make project version available to the library as a definition
add_definitions(-DAPPLICATION_RELEASE="${RELEASE}") # Make project release string available to the library as a definition

##### Link to the core PROGENY_PROJECT_NAME project library.
if(LINK_SHARED_LIBS)
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

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_LIST_DIR}/bin)  # Put compiled executables in bin/

file(GLOB SRC_FILES "${CMAKE_CURRENT_LIST_DIR}/src/*.{cpp,c}")  # Get all source files with .cpp or .c extension in src/

foreach(SRC_FILE ${SRC_FILES})
    get_filename_component(EXECUTABLE_NAME ${SRC_FILE} NAME_WE)  # Get the file name without extension
    add_executable(${EXECUTABLE_NAME} ${SRC_FILE})  # Create an executable target with the file name as the target name
    include_directories(${CMAKE_CURRENT_LIST_DIR}/inc/)  # Include directories for the target
    target_link_libraries(${EXECUTABLE_NAME} ${LINK_APPLICATION_LIST})  # Link to a list of libraries declared in top-level CMakeLists
    set_target_properties(${EXECUTABLE_NAME} PROPERTIES OUTPUT_NAME ${EXECUTABLE_NAME})  # Set the output name of the executable

    if (DEFINED PRIMARY_EXECUTABLE_INSTALL_PATH AND INSTALL_EXECUTABLES)
        message(STATUS "Will install primary executable '${EXECUTABLE_NAME}' at ${PRIMARY_EXECUTABLE_INSTALL_PATH}")
        install(TARGETS ${EXECUTABLE_NAME} DESTINATION ${PRIMARY_EXECUTABLE_INSTALL_PATH})  # Install the executable to the specified path
    else()
        message(STATUS "No primary executable '${EXECUTABLE_NAME}' will be installed. INSTALL_EXECUTABLES is OFF or PRIMARY_EXECUTABLE_INSTALL_PATH is undefined")
    endif()
endforeach()
