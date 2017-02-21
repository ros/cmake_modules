cmake_minimum_required(VERSION 2.8)
project(test_cython)

find_package(catkin REQUIRED COMPONENTS cmake_modules)

include(UseCython)

cython_add_module(primes primes.pyx)

# copies python test file to cython library dir
catkin_install_python(PROGRAMS ${PROJECT_SOURCE_DIR}/test_primes.py
                      DESTINATION ${PROJECT_BINARY_DIR})
