# - Find the DepthSenseSDK includes and libraries.
#
#  Once done these CMake variables are going to be set:
#
#       DepthSenseSDK_FOUND - system has DepthSenseSDK
#       DepthSenseSDK_INCLUDE_DIR - the DepthSenseSDK include directories
#       DepthSenseSDK_LIBRARIES - link these to use DepthSenseSDK


if (WIN32)
    if (CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(PROGRAM_FILES_PATH $ENV{PROGRAMW6432})
    else ()
        set(PROGRAM_FILES_PATH $ENV{PROGRAMFILES})
    endif()

    set (DepthSenseSDK_LOCATION_GUESS "${PROGRAM_FILES_PATH}/SoftKinetic/DepthSense")
else (WIN32)
    set (DepthSenseSDK_LOCATION_GUESS "/opt/softkinetic/DepthSenseSDK")
endif (WIN32)

find_path (DepthSenseSDK_INCLUDE_DIR DepthSense.hxx
    PATHS "${DepthSenseSDK_LOCATION_GUESS}/include/"
    )

find_library (DepthSenseSDK_LIBRARIES
    NAMES DepthSense
    PATHS "${DepthSenseSDK_LOCATION_GUESS}/lib"
)

if (DepthSenseSDK_INCLUDE_DIR AND DepthSenseSDK_LIBRARIES)
    set (DepthSenseSDK_FOUND ON)
else (DepthSenseSDK_INCLUDE_DIR AND DepthSenseSDK_LIBRARIES)
    set (DepthSenseSDK_FOUND OFF)
endif (DepthSenseSDK_INCLUDE_DIR AND DepthSenseSDK_LIBRARIES)

mark_as_advanced (DepthSenseSDK_FOUND)
if(DepthSenseSDK_FOUND)
    include_directories(${DepthSenseSDK_INCLUDE_DIR})
else()
    message(STATUS "DepthSenseSDK not found!")
endif(DepthSenseSDK_FOUND)

