################################################################################
#
# CMake script for finding TinyXML.
# If the optional TinyXML_ROOT_DIR environment or cmake variable exists,
# header files and libraries will be searched in the ${TinyXML_ROOT_DIR}/include
# and ${TinyXML_ROOT_DIR}/libs directories, respectively.
# Otherwise the default CMake search process will be used.
#
# This script creates the following variables:
#  TinyXML_FOUND: Boolean that indicates if the package was found
#  TinyXML_INCLUDE_DIRS: Paths to the necessary header files
#  TinyXML_LIBRARIES: Package libraries
#
# This is a typical way to use this module:
#
#  find_package(TinyXML REQUIRED)
#  ...
#  include_directories(${TinyXML_INCLUDE_DIRS} ...)
#  ...
#  target_link_libraries(my_target ${TinyXML_LIBRARIES})
#
################################################################################

# Get hint from environment variable (if any)
if(NOT TinyXML_ROOT_DIR AND DEFINED ENV{TinyXML_ROOT_DIR})
  set(TinyXML_ROOT_DIR "$ENV{TinyXML_ROOT_DIR}" CACHE PATH
      "TinyXML base directory location (optional, used for nonstandard installation paths)")
endif()

# Search path for nonstandard locations
if(TinyXML_ROOT_DIR)
  set(TinyXML_INCLUDE_PATH PATHS "${TinyXML_ROOT_DIR}/include" NO_DEFAULT_PATH)
  set(TinyXML_LIBRARY_PATH PATHS "${TinyXML_ROOT_DIR}/lib"     NO_DEFAULT_PATH)
endif()

# Find headers and libraries
find_path(TinyXML_INCLUDE_DIR NAMES tinyxml.h PATH_SUFFIXES "tinyxml" ${TinyXML_INCLUDE_PATH})
find_library(TinyXML_LIBRARY  NAMES tinyxml   PATH_SUFFIXES "tinyxml" ${TinyXML_LIBRARY_PATH})

mark_as_advanced(TinyXML_INCLUDE_DIR
                 TinyXML_LIBRARY)

# Output variables generation
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(TinyXML DEFAULT_MSG TinyXML_LIBRARY
                                                      TinyXML_INCLUDE_DIR)

set(TinyXML_FOUND ${TINYXML_FOUND})

if(TinyXML_FOUND)
  set(TinyXML_INCLUDE_DIRS ${TinyXML_INCLUDE_DIR})
  set(TinyXML_LIBRARIES ${TinyXML_LIBRARY})
endif()
