

set(CMAKE_C_COMPILER "g") #specify g++ compiler
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_LIST_DIR}/bin) # put compiled executable in bin/
add_compile_options(-g) # -g turns on debugging

find_package( Threads )

add_executable("PROGENY_PROJECT_NAME-bin" src/main.cpp)
include_directories(${CMAKE_CURRENT_LIST_DIR}/inc/)
target_link_libraries("PROGENY_PROJECT_NAME-bin" "PROGENY_PROJECT_NAME")
target_link_libraries("PROGENY_PROJECT_NAME-bin" Threads::Threads)
set_target_properties("PROGENY_PROJECT_NAME-bin" PROPERTIES OUTPUT_NAME "PROGENY_PROJECT_NAME")

if(DEFINED PRIMARY_EXECUTABLE_INSTALL_PATH AND INSTALL_EXECUTABLES)
    message(STATUS "Will install primary executables at ${PRIMARY_EXECUTABLE_INSTALL_PATH}")
    install(TARGETS PROGENY_PROJECT_NAME-bin DESTINATION ${PRIMARY_EXECUTABLE_INSTALL_PATH})
else()
    message(STATUS "No primary executable will be installed. INSTALL_EXECUTABLES is OFF of PRIMARY_EXECUTABLE_INSTALL_PATH is undefined")
endif()
