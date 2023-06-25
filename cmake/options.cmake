#### BUILD OPTIONS
option(BUILD_TEST "Build unit tests" ON)
option(BUILD_SHARED_LIBS "Build using shared libraries" OFF)
#option(BUILD_STATIC_LIBS "Build using static libraries" ON)

##### INSTALL OPTIONS
option(INSTALL_LIBS "Install/package libraries. Use when building for developers, or when building for users and BUILD_SHARED_LIBS is ON." ON)
if(BUILD_SHARED_LIBS AND NOT INSTALL_LIBS)
    message(WARNING "BUILD_SHARED_LIBS is ON, but INSTALL_LIBS is off. Executables built with shared libs depend on them being installed. Ovveriding with BUILD_SHARED_LIBS=OFF")
    set(BUILD_SHARED_LIBS OFF)
endif()
option(INSTALL_HEADERS "Install/package with headers. Set to ON when building for developers" ON)
option(INSTALL_EXECUTABLES "Install/package with executables. Set to OFF if strictly creating a library for other development" ON)
