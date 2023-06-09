#Copied from libHackRF

if(NOT DEFINED RELEASE)
    execute_process(
            COMMAND git log -n 1 --format=%h
            WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
            RESULT_VARIABLE GIT_EXIT_VALUE
            ERROR_QUIET
            OUTPUT_VARIABLE GIT_VERSION
            OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if (GIT_EXIT_VALUE)
        set(RELEASE "2023.01.1+")
    else (GIT_EXIT_VALUE)
        execute_process(
                COMMAND git status -s --untracked-files=no
                OUTPUT_VARIABLE DIRTY
        )
        if ( NOT "${DIRTY}" STREQUAL "" )
            set(DIRTY_FLAG "*") #Dirty releases have unadded and uncommitted contents. Git will refuse to tag a release if this is in the name.
        else()
            set(DIRTY_FLAG "")
        endif()
        set(RELEASE "git-${GIT_VERSION}${DIRTY_FLAG}")
    endif (GIT_EXIT_VALUE)
endif()

message(STATUS "Setting RELEASE=${RELEASE}")
file(WRITE ${CMAKE_BINARY_DIR}/RELEASE_VERSION "${CMAKE_PROJECT_VERSION}-${RELEASE}")
