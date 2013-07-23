cmake_modules
=============

A common repository for CMake Modules which are not distributed with CMake but are commonly used by ROS packages.

See the CONTRIBUTING.md file in this repository before submitting pull requests for new modules.

Usage
-----

To use the CMake modules provided by this catkin package, you must `<build_depend>` on it in your `package.xml`, like so:

```xml
<?xml version="1.0"?>
<package>
  <!-- ... -->
  <build_depend>cmake_modules</build_depend>
</package>
```

Then you must `find_package` it in your `CMakeLists.txt` along with your other catkin build dependencies:

```cmake
find_package(catkin REQUIRED COMPONENTS ... cmake_modules ...)
```

OR by `find_package`'ing it directly:

```cmake
find_package(cmake_modules REQUIRED)
```
