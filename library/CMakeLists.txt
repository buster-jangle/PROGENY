
set(LIBRARY_OUTPUT_PATH ${CMAKE_CURRENT_LIST_DIR}/lib) # put compiled executable in bin/
add_library("PROGENY" STATIC "src/PROGENY.cpp")
include_directories(${CMAKE_CURRENT_LIST_DIR}/inc/)
set_target_properties("PROGENY" PROPERTIES PUBLIC_HEADER "inc/PROGENY.h")
install(TARGETS "PROGENY"
	 LIBRARY DESTINATION /usr/local/lib
	PUBLIC_HEADER DESTINATION include
	)



