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

After the above `find_package` invocations, the modules provided by `cmake_modules` will be available in your `CMAKE_MODULE_PATH` to be found. For example you can find `Eigen` by using the following:

```cmake
find_package(Eigen REQUIRED)
```

Supports
-----
1. [**Eigen**](http://eigen.tuxfamily.org/index.php?title=Main_Page) is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms.
2. [**NumPy**](http://www.numpy.org/) is the fundamental package for scientific computing with Python.
3. [**OpenCV**](http://opencv.org/) is a library of programming functions mainly aimed at real-time computer vision.
4. [**PCL**](http://pointclouds.org/) is a standalone, large scale, open project for 2D/3D image and point cloud processing.
5. [**TBB**](https://www.threadingbuildingblocks.org/) lets you easily write parallel C++ programs that take full advantage of multicore performance.
6. [**TinyXML**](http://www.grinninglizard.com/tinyxml/) is a simple, small, C++ XML parser
7. [**Xenomai**](http://www.xenomai.org/) is a real-time development framework cooperating with the Linux kernel.



