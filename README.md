cmake_modules
=============

A common repository for CMake Modules which are not distributed with CMake but are commonly used by ROS packages.

See the CONTRIBUTING.md file in this repository before submitting pull requests for new modules.

ROS Distros
-----------

This repository has branches for minor releases (`0.2-devel`, `0.3-devel`, `0.4-devel`, etc...) and they map to specific ROS distributions like so:

- `0.2-devel`:
 - ROS Groovy
- `0.3-devel`:
 - ROS Hydro
 - ROS Indigo
- `0.4-devel`:
 - ROS Jade
 - ROS Kinetic

This mapping will be kept up-to-date in the `README.md` on the default branch.

Provided Modules
----------------

1. [**NumPy**](http://www.numpy.org/) is the fundamental package for scientific computing with Python.
1. [**TBB**](https://www.threadingbuildingblocks.org/) lets you easily write parallel C++ programs that take full advantage of multicore performance.
1. [**TinyXML**](http://www.grinninglizard.com/tinyxml/) is a simple, small, C++ XML parser.
1. [**TinyXML2**](http://www.grinninglizard.com/tinyxml2/) is a simple, small, C++ XML parser, continuation of TinyXML.
1. [**Xenomai**](http://www.xenomai.org/) is a real-time development framework cooperating with the Linux kernel.
1. [**GSL**](http://www.gnu.org/software/gsl/) is a numerical library for C and C++ programmers.
1. [**Gflags**](https://gflags.github.io/gflags/) is a C++ library that implements commandline flags processing with the ability to define flags in the source file in which they are used.
1. \[Deprecated\] [**Eigen**](http://eigen.tuxfamily.org/index.php?title=Main_Page) is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms.

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

After the above `find_package` invocations, the modules provided by `cmake_modules` will be available in your `CMAKE_MODULE_PATH` to be found. For example you can find `TinyXML` by using the following:

```cmake
find_package(TinyXML REQUIRED)
```

### Lookup sheet

##### Eigen [Deprecated]

```cmake
find_package(Eigen REQUIRED)
```

##### NumPY

```cmake
find_package(NUMPY REQUIRED)
```

##### TBB

```cmake
find_package(TBB REQUIRED)
```

##### TinyXML

```cmake
find_package(TinyXML REQUIRED)
```

##### Xenomai

```cmake
find_package(Xenomai REQUIRED)
```

### FindGSL

```cmake
find_package(GSL REQUIRED)
```

##### Gflags

```cmake
find_package(Gflags REQUIRED)
```
