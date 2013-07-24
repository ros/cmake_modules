## Contributing a new CMake Module

First of all lets talk about the difference in a CMake module and a CMake config.

A **CMake config file** is named like `<lowercase_package_name>-config.cmake` or `<PackageName>Config.cmake`, and should normally be distributed by the CMake project which it applies to and should contain absolute locations to things which are known at build and install time. These files are discovered by searching the `CMAKE_PREFIX_PATH`.

A **CMake module file** is named like `Find<PackageName>.cmake` and are discovered by searching the `CMAKE_MODULE_PATH`. These files are distributed by CMake, or other packages like this one, and are used to locate software packages which were not built with CMake and which do not distribute CMake config files themselves. The prefix `Find` in the file names implies that you must "find" the software in question and often requires the use of the pkg-config module and/or the `find_path` and `find_library` CMake macros.

This package should exclusively contain CMake modules since config files should be distributed by the packages to which they apply.

## CMake Module Style

When contributing a new cmake module for this package, please follow these guidelines:

- The module should be placed in the `cmake/Modules` directory of this package
- It should take the name `Find<PackageName>.cmake`
 - For example `FindTinyXML.cmake`
- The module should **atleast** provide these variables:
 - `<PackageName>_FOUND`
 - `<PackageName>_INCLUDE_DIRS`
 - `<PackageName>_LIBRARIES`
 - It may provide other variables but they must be documented at the top of the module file.
- The module must provide documentation for each variable it sets and give an example of usage

You can see the CMake recommendation for these modules here:

http://cmake.org/gitweb?p=cmake.git;a=blob;f=Modules/readme.txt

You should also strive to keep the `PackageName` in `Find<PackageName>.cmake`'s case consistent in the CMake variables. For example, `FindTinyXML.cmake` should be found with a command like `find_package(TinyXML REQUIRED)` and should produce variables like `TinyXML_FOUND`.
