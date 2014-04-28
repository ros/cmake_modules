# Try to find PCL library installation
#
# The follwoing variables are optionally searched for defaults
#  PCL_ROOT:             Base directory of PCL tree to use.
#  $ENV{PCL_ROOT}:       Base directory of PCL tree to use.
#  PCL_FIND_COMPONENTS : FIND_PACKAGE(PCL COMPONENTS ..) 
#    compatible interface. typically  common, io .. etc.
#
# The following are set after configuration is done: 
#  PCL_FOUND
#  PCL_INCLUDE_DIRS
#  PCL_LIBRARIES
#  PCL_LINK_DIRECTORIES
#  PCL_VERSION
#
# In addition for each component these are set:
#  PCL_COMPONENT_INCLUDE_DIR
#  PCL_COMPONENT_LIBRARY
#  PCL_COMPONENT_DEFINITIONS if available
# 
# To use PCL from within you code
# find_package(PCL [VERSION] [REQUIRED] [COMPONENTS module1 module2 ...])
# if(PCL_FOUND)
#   include_directories(${PCL_INCLUDE_DIRS})
#   list(APPEND LIBS ${PCL_LBRARIES})
# endif(PCL_FOUND)
# Or if you want to link against a particular module
# target_link_libraries(my_fabulous_target ${PCL_XXX_LIBRARY}) where XXX is 
# module from COMPONENTS
#
# Tested with:
# -PCL 2.0
#
# www.pointclouds.org
# --------------------------------

include(FindPackageHandleStandardArgs)
#set a suffix based on project name and version
set(PCL_SUFFIX pcl-1.0)

#set all pcl component and their account into variables
set(pcl_all_components io common kdtree keypoints filters range_image registration sample_consensus segmentation features surface octree visualization )
list(LENGTH pcl_all_components PCL_NB_COMPONENTS)

#list each component dependencies IN PCL
set(pcl_features_dependencies common kdtree range_image)
set(pcl_filters_dependencies common sample_consensus io kdtree)
set(pcl_io_dependencies common)
set(pcl_kdtree_dependencies common)
set(pcl_keypoints_dependencies common features io kdtree range_image range_image_border_extractor)
set(pcl_range_image_dependencies common)
set(pcl_range_image_border_extractor_dependencies common kdtree range_image)
set(pcl_registration_dependencies common io kdtree sample_consensus)
set(pcl_sample_consensus_dependencies common)
set(pcl_segmentation_dependencies common kdtree sample_consensus)
set(pcl_surface_dependencies common io features kdtree registration)
set(pcl_octree_dependencies common)
set(pcl_visualization_dependencies common io kdtree range_image)

#list a MUST FIND header per component since not all components provide component.h
set(pcl_common_header common.h)
set(pcl_features_header feature.h)
set(pcl_filters_header filter.h)
set(pcl_io_header io.h)
set(pcl_kdtree_header kdtree.h)
set(pcl_keypoints_header keypoint.h)
set(pcl_range_image_header range_image.h)
set(pcl_registration_header registration.h)
set(pcl_sample_consensus_header sac.h)
set(pcl_segmentation_header sac_segmentation.h)
set(pcl_surface_header convex_hull.h)
set(pcl_octree_header octree.h)
set(pcl_visualization_header pcl_visualizer.h)

#check if user provided a list of components
if(PCL_FIND_COMPONENTS)
  list(LENGTH PCL_FIND_COMPONENTS PCL_FIND_COMPONENTS_LENGTH)
else(PCL_FIND_COMPONENTS)
  set(PCL_FIND_COMPONENTS_LENGTH 0)
endif(PCL_FIND_COMPONENTS)

#if no components at all or full list is given set PCL_FIND_ALL
if((PCL_FIND_COMPONENTS_LENGTH EQUAL 0) OR 
   (PCL_FIND_COMPONENTS_LENGTH EQUAL PCL_NB_COMPONENTS))
  # default
  set(PCL_FIND_COMPONENTS ${pcl_all_components})
  set(PCL_FIND_ALL 1)
endif((PCL_FIND_COMPONENTS_LENGTH EQUAL 0) OR 
      (PCL_FIND_COMPONENTS_LENGTH EQUAL PCL_NB_COMPONENTS))

#require pkgconfig if available
find_package(PkgConfig)

set(PCL_INCLUDE_DIRS)
set(PCL_LIBRARIES)

#find each component separately
foreach(component ${PCL_FIND_COMPONENTS})
  set(pcl_component pcl_${component})
  set(pcl_component_dependencies ${pcl_component}_dependencies)
  if(${pcl_component_dependencies} AND (NOT PCL_FIND_ALL))
    foreach(dependency ${${pcl_component_dependencies}})
      list(FIND PCL_FIND_COMPONENTS ${dependency} found)
      if(found EQUAL -1)
        list(APPEND PCL_FIND_COMPONENTS ${dependency})
      endif(found EQUAL -1)
    endforeach(dependency)
  endif(${pcl_component_dependencies} AND (NOT PCL_FIND_ALL))
  string(TOUPPER "${pcl_component}" PCL_COMPONENT)
  string(TOUPPER "PC_${pcl_component}" PC_PCL_COMPONENT)
  string(TOUPPER "${pcl_component}_DEFINITIONS" PCL_COMPONENT_DEFINITIONS)
  string(TOUPPER "${pcl_component}_INCLUDE_DIR" PCL_COMPONENT_INCLUDE_DIR)
  string(TOUPPER "${pcl_component}_LIBRARY" PCL_COMPONENT_LIBRARY)
  
  pkg_check_modules(${PC_PCL_COMPONENT} QUIET ${pcl_component})
  set(${PCL_COMPONENT_DEFINITIONS} ${${PC_PCL_COMPONENT}_CFLAGS_OTHER})
  mark_as_advanced(${PCL_COMPONENT_DEFINITIONS})

#	if(${PC_PCL_COMPONENT}_VERSION AND NOT PCL_COMPONENTS_VERSION)
		set(PCL_COMPONENTS_VERSION ${${PC_PCL_COMPONENT}_VERSION})
#	elseif(PCL_COMPONENTS_VERSION AND 
#			   (NOT PCL_COMPONENTS_VERSION EQUAL ${PC_PCL_COMPONENT}_VERSION))
#			message(FATAL_ERROR 
#				"PCL component: ${component} should be at version ${PCL_COMPONENTS_VERSION}")
#  endif(${PC_PCL_COMPONENT}_VERSION AND NOT PCL_COMPONENTS_VERSION)
	
  find_path(${PCL_COMPONENT_INCLUDE_DIR} ${${pcl_component}_header} 
    HINTS /usr/local
		      ${${PC_PCL_COMPONENT}_INCLUDEDIR} ${${PC_PCL_COMPONENT}_INCLUDE_DIRS} 
          ${PCL_ROOT} ENV PCL_ROOT
    PATH_SUFFIXES pcl/${component} ${PCL_SUFFIX}/pcl/${component}
    DOC "path to ${pcl_component} headers")
  get_filename_component(component_header_path 
    ${${PCL_COMPONENT_INCLUDE_DIR}}/${${pcl_component}_header}
    PATH)
  file(TO_CMAKE_PATH ${component_header_path} component_header_path)
  string(REGEX REPLACE "(.*)/pcl/${component}" "\\1" 
    component_header_path "${component_header_path}")
  if(NOT EXISTS ${component_header_path}/pcl/pcl_config.h)
    message(FATAL_ERROR "${component_header_path} is not a valid include directory")
  endif(NOT EXISTS ${component_header_path}/pcl/pcl_config.h)
  
  find_library(${PCL_COMPONENT_LIBRARY} ${pcl_component}
    HINTS /usr/local 
          ${${PC_PCL_COMPONENT}_LIBDIR} ${${PC_PCL_COMPONENT}_LIBRARY_DIRS}
          ${PCL_ROOT} ENV PCL_ROOT
    DOC "path to ${pcl_component} library")  
  get_filename_component(component_library_path 
		${${PCL_COMPONENT_LIBRARY}}
    PATH)

  find_package_handle_standard_args(${PCL_COMPONENT} DEFAULT_MSG
    ${PCL_COMPONENT_LIBRARY} ${PCL_COMPONENT_INCLUDE_DIR})

	if(${PCL_COMPONENT}_FOUND)
		list(APPEND PCL_INCLUDE_DIRS ${component_header_path})
		if(${PC_PCL_COMPONENT}_INCLUDE_DIRS)
			list(APPEND PCL_INCLUDE_DIRS ${${PC_PCL_COMPONENT}_INCLUDE_DIRS})
		endif(${PC_PCL_COMPONENT}_INCLUDE_DIRS)
		mark_as_advanced(${PCL_COMPONENT_INCLUDE_DIR})
		list(APPEND PCL_LIBRARIES ${${PCL_COMPONENT_LIBRARY}})
		list(APPEND PCL_LINK_DIRECTORIES ${component_library_path})
		mark_as_advanced(${PCL_COMPONENT_LIBRARY})
	endif(${PCL_COMPONENT}_FOUND)
endforeach(component)

list(REMOVE_DUPLICATES PCL_INCLUDE_DIRS)
list(APPEND PCL_INCLUDE_DIRS ${component_header_path}/pcl)
list(REMOVE_DUPLICATES PCL_LINK_DIRECTORIES)

find_package_handle_standard_args(PCL DEFAULT_MSG PCL_LIBRARIES PCL_INCLUDE_DIRS)
mark_as_advanced(PCL_LIBRARIES PCL_INCLUDE_DIRS)

if(PCL_COMPONENTS_VERSION)
	set(PCL_VERSION ${PCL_COMPONENTS_VERSION})
endif(PCL_COMPONENTS_VERSION)
