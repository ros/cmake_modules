When contributing a new cmake module for this package, please follow these guidelines:

The module should be placed in the `cmake/modules` directory and should take the name `<lowercase-package-name>-config.cmake`.

The find_package rule should **atleast** provide `<package-name>_FOUND`, `<package-name>_INCLUDE_DIRS`, and ``<package-name>_LIBRARIES`. It may provide other variables but they must be documented at the top of the module file.

All modules must provide documentation for each variable it sets and give an example of usage.
