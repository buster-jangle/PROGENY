# BuildInfo.cmake
# Gathers build metadata and exposes them as compile-time definitions.
#
# Usage:
#   include(BuildInfo.cmake)
#   target_apply_build_info(my_target)
#
# Definitions added to the target:
#   GIT_HASH         - Short commit hash (7 chars), or "unknown"
#   GIT_HASH_UINT32  - First 8 hex chars of hash as a uint32 literal (0xABCD1234)
#   GIT_BRANCH       - Current branch name, or "unknown"
#   GIT_COMMIT_COUNT - Total number of commits on HEAD
#   GIT_DIRTY        - 1 if working tree has uncommitted changes, 0 otherwise
#   BUILD_TYPE       - CMake build type (e.g. Debug, Release)
#   BUILD_DATE       - Timestamp of configure step (YYYY-MM-DD HH:MM:SS)
#   BUILD_HOST       - Hostname of the machine that ran CMake
#   PROJECT_NAME     - CMake project name

function(gather_build_info)
    find_package(Git QUIET)

    if(GIT_FOUND)
        execute_process(
                COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                OUTPUT_VARIABLE _git_hash_full
                OUTPUT_STRIP_TRAILING_WHITESPACE
                ERROR_QUIET
        )
        string(SUBSTRING "${_git_hash_full}" 0 8 _git_hash_hex)

        execute_process(
                COMMAND ${GIT_EXECUTABLE} rev-parse --short=7 HEAD
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                OUTPUT_VARIABLE _git_hash_short
                OUTPUT_STRIP_TRAILING_WHITESPACE
                ERROR_QUIET
        )

        execute_process(
                COMMAND ${GIT_EXECUTABLE} rev-parse --abbrev-ref HEAD
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                OUTPUT_VARIABLE _git_branch
                OUTPUT_STRIP_TRAILING_WHITESPACE
                ERROR_QUIET
        )

        execute_process(
                COMMAND ${GIT_EXECUTABLE} rev-list --count HEAD
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                OUTPUT_VARIABLE _git_commit_count
                OUTPUT_STRIP_TRAILING_WHITESPACE
                ERROR_QUIET
        )

        execute_process(
                COMMAND ${GIT_EXECUTABLE} diff-index --quiet HEAD --
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                RESULT_VARIABLE _git_is_dirty
                ERROR_QUIET
        )

        set(BUILD_INFO_GIT_HASH        "${_git_hash_short}"    CACHE INTERNAL "")
        set(BUILD_INFO_GIT_HASH_UINT32 "0x${_git_hash_hex}"   CACHE INTERNAL "")
        set(BUILD_INFO_GIT_BRANCH      "${_git_branch}"        CACHE INTERNAL "")
        set(BUILD_INFO_GIT_COMMIT_COUNT "${_git_commit_count}" CACHE INTERNAL "")
        set(BUILD_INFO_GIT_DIRTY       "${_git_is_dirty}"      CACHE INTERNAL "")
    else()
        message(WARNING "[BuildInfo] Git not found - version info will be unavailable")
        set(BUILD_INFO_GIT_HASH         "unknown"      CACHE INTERNAL "")
        set(BUILD_INFO_GIT_HASH_UINT32  "0x00000000"   CACHE INTERNAL "")
        set(BUILD_INFO_GIT_BRANCH       "unknown"      CACHE INTERNAL "")
        set(BUILD_INFO_GIT_COMMIT_COUNT "0"            CACHE INTERNAL "")
        set(BUILD_INFO_GIT_DIRTY        "0"            CACHE INTERNAL "")
    endif()

    string(TIMESTAMP _build_date "%Y-%m-%d %H:%M:%S")
    cmake_host_system_information(RESULT _build_host QUERY HOSTNAME)

    set(BUILD_INFO_BUILD_DATE "${_build_date}" CACHE INTERNAL "")
    set(BUILD_INFO_BUILD_HOST "${_build_host}" CACHE INTERNAL "")

    message(STATUS "[BuildInfo] ${BUILD_INFO_GIT_BRANCH}@${BUILD_INFO_GIT_HASH} (${BUILD_INFO_GIT_HASH_UINT32}) dirty=${BUILD_INFO_GIT_DIRTY}")
    message(STATUS "[BuildInfo] Built on ${BUILD_INFO_BUILD_HOST} at ${BUILD_INFO_BUILD_DATE}")
endfunction()


function(target_apply_build_info target)
    # Ensure info has been gathered
    if(NOT DEFINED BUILD_INFO_GIT_HASH)
        gather_build_info()
    endif()

    target_compile_definitions(${target} PRIVATE
            GIT_HASH="${BUILD_INFO_GIT_HASH}"
            GIT_HASH_UINT32=${BUILD_INFO_GIT_HASH_UINT32}
            GIT_BRANCH="${BUILD_INFO_GIT_BRANCH}"
            GIT_COMMIT_COUNT=${BUILD_INFO_GIT_COMMIT_COUNT}
            GIT_DIRTY=${BUILD_INFO_GIT_DIRTY}
            BUILD_TYPE="${CMAKE_BUILD_TYPE}"
            BUILD_DATE="${BUILD_INFO_BUILD_DATE}"
            BUILD_HOST="${BUILD_INFO_BUILD_HOST}"
            PROJECT_NAME="${CMAKE_PROJECT_NAME}"
    )
endfunction()