cmake_minimum_required (VERSION 3.0.0)

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin) # put compiled executable in bin/

##### Link to the core PROGENY_PROJECT_NAME project library.
if(LINK_SHARED_LIBS)
    list(APPEND LINK_TESTS_LIST PROGENY_PROJECT_NAME) # Link the application to a shared version of the library
    message(STATUS "Linking application to shared library: PROGENY_PROJECT_NAME")
else()
    list(APPEND LINK_TESTS_LIST PROGENY_PROJECT_NAME-static) # Link the application to a static version of the library
    message(STATUS "Linking application to static library: PROGENY_PROJECT_NAME-static")
endif()
message(STATUS "Linking tests libs:")
foreach(lib ${LINK_TESTS_LIST})
    message(STATUS "\t${lib}")
endforeach()

#### Set build type
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_compile_options(-g) # -g turns on debugging
    message(STATUS "Building application in debug mode")
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    message(STATUS "Building application in release mode")
else()
    message(STATUS "Building application with unknown build type")
endif()

find_package( Threads )

include_directories(${CMAKE_CURRENT_LIST_DIR})


##### Turn each .cpp source file in ./src/ into a separate executable, and add it to the list of tests
# List all files in the src/ directory
file(GLOB_RECURSE SOURCE_FILES "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")

# Create an empty list to store the test executable names
set(TEST_EXECUTABLE_NAMES "")

# Iterate over each source file
foreach(SOURCE_FILE ${SOURCE_FILES})
    # Get the filename without the extension
    get_filename_component(TEST_EXECUTABLE_NAME ${SOURCE_FILE} NAME_WE)

    # Add the test executable name to the list
    list(APPEND TEST_EXECUTABLE_NAMES ${TEST_EXECUTABLE_NAME})

    # Create a test executable for each source file
    add_executable(${TEST_EXECUTABLE_NAME} ${SOURCE_FILE})

    # Link to the list of libraries
    target_link_libraries(${TEST_EXECUTABLE_NAME} ${LINK_TESTS_LIST})

    # Set the output name for the test executable
    set_target_properties(${TEST_EXECUTABLE_NAME} PROPERTIES OUTPUT_NAME ${TEST_EXECUTABLE_NAME})

    add_test(NAME ${TEST_EXECUTABLE_NAME} COMMAND ${TEST_EXECUTABLE_NAME})

    # Print diagnostic message
    message(STATUS "Added test executable: ${TEST_EXECUTABLE_NAME}")

endforeach()

# Print the list of test executable names
message(STATUS "Test Executable list:")
foreach(lib ${TEST_EXECUTABLE_NAMES})
    message(STATUS "\t${lib}")
endforeach()
