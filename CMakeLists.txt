
cmake_minimum_required (VERSION 2.8.13)
project("PROGENY")

add_subdirectory(library)
include_directories(${CMAKE_CURRENT_LIST_DIR}/library/inc/)
add_subdirectory(application)



