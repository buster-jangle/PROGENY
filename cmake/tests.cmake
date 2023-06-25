# PInclude and build tests if this is the main project

if((CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME) AND BUILD_TEST)
    message(STATUS "Building tests.")
    #Enable testing with CTest
    include(CTest)
    add_subdirectory(test)
endif()
