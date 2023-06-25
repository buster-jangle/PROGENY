#Configure CPack for generating a .deb package
message(STATUS "Configuring CPack...")

SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Project derived from PROGENY")
SET(CPACK_PACKAGE_VENDOR "buster-jangle")
set(CPACK_PACKAGE_CONTACT yourContactInfo) #Debian packages require contact info for maintainer responsible for the package, such as your company email
SET(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE") #Add your license file here

set(CPACK_SOURCE_GENERATOR "TGZ") #Generate tar.gz compresssed sourcecode package

if(INSTALL_HEADERS) #If headers are being included, append -dev to package name to indicate this is a developer release
    set(CPACK_PACKAGE_NAME "${CMAKE_PROJECT_NAME}-dev")
else()
    set(CPACK_PACKAGE_NAME "${CMAKE_PROJECT_NAME}")
endif()
set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)

set(CPACK_GENERATOR "DEB") #generate debian install package
#set(CPACK_DEBIAN_PACKAGE_DEPENDS "libc6 (>= 2.3.1-6), libc6 (< 2.4)") #Set debian package dependencies (must also be debian packages)

#set(CPACK_PACKAGE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/artifacts") #Set destination for packages
message(STATUS "
CPACK_PACKAGE_NAME=${CPACK_PACKAGE_NAME}
INSTALL_HEADERS=${INSTALL_HEADERS}
")

include(CPack)