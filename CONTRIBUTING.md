= Contributing a new CMake Module =

First of all lets talk about the difference in a CMake module and a CMake config.

A CMake config file is named like `<lowercase_package_name>-config.cmake` or `<PackageName>Config.cmake`, and should nominally be distributed by a project which is built with CMake and should contain absolute locations to things which are known are build/install time. These files are discovered by searching the `CMAKE_PREFIX_PATH`.

A CMake module is named like `Find<PackageName>.cmake` and are discovered by searching the `CMAKE_MODULE_PATH`. These files are distributed by cmake or other packages (like this one) and are used to locate, software which was not built with CMake and does not distribute config files. The prefix `Find` in the file names implies that you must "find" the software in question and often requires the use of the pkg-config module and/or the `find_path` and `find_library` CMake macros. This package should exclusively contain CMake modules since config files should be distributed by the packages to which they apply.

== CMake Module Style ==

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
