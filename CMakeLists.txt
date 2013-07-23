cmake_minimum_required(VERSION 2.8.3)
project(cmake_modules)

catkin_package(CFG_EXTRAS cmake_modules-extras.develspace.cmake)

## Install all cmake files
install(DIRECTORY cmake/modules/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/cmake)
