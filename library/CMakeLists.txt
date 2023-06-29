cmake_minimum_required (VERSION 3.0.0)

add_definitions(-DLIBRARY_VERSION="${CMAKE_PROJECT_VERSION}") #Make project version available to the library as a definition
add_definitions(-DLIBRARY_RELEASE="${RELEASE}") #Make project release string available to the library as a definition

# By default, get all source files in src/ directory and compile them into PROGENY_PROJECT_NAME library
file(GLOB LIB_SOURCES "${CMAKE_CURRENT_LIST_DIR}/src/*.cpp" " ${CMAKE_CURRENT_LIST_DIR}/src/*.c")

set(LIBRARY_OUTPUT_PATH ${CMAKE_CURRENT_LIST_DIR}/lib) # put compiled library in lib/
set(LIBRARY_HEADERS ${CMAKE_CURRENT_LIST_DIR}/inc/PROGENY_PROJECT_NAME.h) #

#includes for libs
include_directories(${CMAKE_CURRENT_LIST_DIR}/inc/)

#Static library always builds
add_library(PROGENY_PROJECT_NAME-static STATIC ${LIB_SOURCES}) #Library is not declared static or shared. This is defined in the top-level cmake options
target_link_libraries(PROGENY_PROJECT_NAME-static ${LINK_PROJECT_LIBRARY_LIBS}) #Link to a list of libraries declared in top-level cmake
set_target_properties(PROGENY_PROJECT_NAME-static PROPERTIES OUTPUT_NAME "PROGENY_PROJECT_NAME")
set_target_properties(PROGENY_PROJECT_NAME-static PROPERTIES PUBLIC_HEADER ${LIBRARY_HEADERS})

if(BUILD_SHARED_LIBS OR LINK_SHARED_LIBS) 	#Optionally build shared library
	add_library(PROGENY_PROJECT_NAME SHARED ${LIB_SOURCES})
	target_link_libraries(PROGENY_PROJECT_NAME ${LINK_PROJECT_LIBRARY_LIBS}) #Link to a list of libraries declared in top-level cmake
	set_target_properties(PROGENY_PROJECT_NAME PROPERTIES VERSION ${CMAKE_PROJECT_VERSION} SOVERSION 0 )
	set_target_properties(PROGENY_PROJECT_NAME PROPERTIES POSITION_INDEPENDENT_CODE 1)
	set_target_properties(PROGENY_PROJECT_NAME PROPERTIES PUBLIC_HEADER ${LIBRARY_HEADERS})
endif()

if(DEFINED HEADER_INSTALL_PATH AND INSTALL_HEADERS)
#	message(STATUS "Will install headers at  ${HEADER_INSTALL_PATH}")
#	install(FILES ${HEADERS}
#			DESTINATION ${HEADER_INSTALL_PATH})
endif()

if(DEFINED LIBRARY_INSTALL_PATH AND INSTALL_STATIC_LIBS)
	message(STATUS "Will install static libraries at  ${LIBRARY_INSTALL_PATH}")
	install(TARGETS PROGENY_PROJECT_NAME-static
			ARCHIVE DESTINATION ${LIBRARY_INSTALL_PATH}
			PUBLIC_HEADER DESTINATION ${HEADER_INSTALL_PATH})
endif()
if(DEFINED LIBRARY_INSTALL_PATH AND INSTALL_SHARED_LIBS AND BUILD_SHARED_LIBS)
	message(STATUS "Will install shared libraries at  ${LIBRARY_INSTALL_PATH}")
	install(TARGETS PROGENY_PROJECT_NAME
			LIBRARY DESTINATION ${LIBRARY_INSTALL_PATH}
			PUBLIC_HEADER DESTINATION ${HEADER_INSTALL_PATH})
endif()



