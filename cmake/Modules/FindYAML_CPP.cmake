# CMake script for finding yaml-cpp
#
# There will soon be an official file at https://code.google.com/p/yaml-cpp/source/browse/
#
# This includes an OSX specific tweak described at
# https://github.com/ros-perception/image_common/pull/31/files
#
# Cache variables:
#
# - YAML_CPP_LIBRARIES
# - YAML_CPP_INCLUDE_DIR (as done upstream for now)
# - YAML_CPP_INCLUDE_DIRS (as done usually)
#
# Output Variables on Linux only for now:
#
# - YAML_CPP_FOUND: Boolean that indicates if the package was found.
# - YAML_CPP_VERSION: major.minor.patch yaml cpp version string

if (APPLE)
  #find yaml cpp for mac os
  find_library(YAML_CPP_LIBRARIES NAMES yaml-cpp)
  find_path(YAML_CPP_H_INCLUDE_DIR yaml-cpp/yaml.h )
  set(YAML_CPP_INCLUDE_DIRS ${YAML_CPP_H_INCLUDE_DIR}/yaml-cpp)
  if (YAML_CPP_LIBRARIES)
    set(YAML_CPP_FOUND 1)
  endif()
else()
  find_package(PkgConfig)
  pkg_check_modules(YAML_CPP yaml-cpp)
endif()
set(YAML_CPP_INCLUDE_DIR ${YAML_CPP_INCLUDE_DIRS})
