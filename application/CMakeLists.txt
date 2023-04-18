
set(CMAKE_C_COMPILER "g") #specify g++ compiler
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_LIST_DIR}/bin) # put compiled executable in bin/
add_compile_options(-g) # -g turns on debugging

find_package( Threads )

add_executable("PROGENY-bin" src/main.cpp)
include_directories(${CMAKE_CURRENT_LIST_DIR}/inc/)
target_link_libraries("PROGENY-bin" "PROGENY")
target_link_libraries("PROGENY-bin" Threads::Threads)
set_target_properties("PROGENY-bin" PROPERTIES OUTPUT_NAME "PROGENY")
