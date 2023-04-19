
set(CMAKE_C_COMPILER "g") #specify g++ compiler
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_LIST_DIR}/bin) # put compiled executable in bin/
add_compile_options(-g) # -g turns on debugging

find_package( Threads )

add_executable("test_default" src/test_default.cpp)
include_directories(${CMAKE_CURRENT_LIST_DIR})
target_link_libraries(test_default PROGENY_PROJECT_NAME)

add_test(NAME test_default
        COMMAND test_default)

if(DEFINED TEST_EXECUTABLE_INSTALL_PATH)
    message(STATUS "Will install test executables at ${TEST_EXECUTABLE_INSTALL_PATH}")
    install(TARGETS test_default DESTINATION ${TEST_EXECUTABLE_INSTALL_PATH})
else()
    message(STATUS "No test executable install path defined")
endif()