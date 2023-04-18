
set(LIBRARY_OUTPUT_PATH ${CMAKE_CURRENT_LIST_DIR}/lib) # put compiled executable in bin/
add_library("PROGENY_PROJECT_NAME" STATIC "src/PROGENY_PROJECT_NAME.cpp")
include_directories(${CMAKE_CURRENT_LIST_DIR}/inc/)
set_target_properties("PROGENY_PROJECT_NAME" PROPERTIES PUBLIC_HEADER "inc/PROGENY_PROJECT_NAME.h")

if(DEFINED LIBRARY_INSTALL_PATH AND DEFINED HEADER_INSTALL_PATH)
	message(STATUS "Will install libraries at  ${LIBRARY_INSTALL_PATH}")
	message(STATUS "Will install headers at  ${HEADER_INSTALL_PATH}")
	install(TARGETS "PROGENY_PROJECT_NAME"
		 LIBRARY DESTINATION ${LIBRARY_INSTALL_PATH}
		PUBLIC_HEADER DESTINATION ${HEADER_INSTALL_PATH}
	)
else()
	message(STATUS "No libbrary and/or header install path defined")
endif()


