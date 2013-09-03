# (C) Copyright 2005-2013 Johns Hopkins University (JHU), All Rights
# Reserved.
#
# --- begin cisst license - do not edit ---
# 
# This software is provided "as is" under an open source license, with
# no warranty.  The complete license can be found in license.txt and
# http://www.cisst.org/cisst/license.txt.
# 
# --- end cisst license ---
#
# CMake script for finding Xenomai
# 
# Input variables:
# 
# - ${Xenomai_ROOT_DIR} (optional): Used as a hint to find the Xenomai root dir
# - $ENV{XENOMAI_ROOT_DIR} (optional): Used as a hint to find the Xenomai root dir
#
# Cache variables:
#
# - Xenomai_ROOT_DIR
# - Xenomai_INCLUDE_DIR
#
# Output Variables:
#
# - Xenomai_FOUND / XENOMAI_FOUND: Boolean that indicates if the package was found
# - Xenomai_INCLUDE_DIRS: Paths to the ncessary header files
# - Xenomai_DEFINITIONS: Additional clfags that should be used when using this package
# - Xenomai_LIBRARY_DIRS: Paths to the ncessary libraries
# - Xenomai_LIBRARIES: All of the possible Xenomai libraries
#
# - Xenomai_VERSION: major.minor.patch Xenomai version string
# - Xenomai_XENO_CONFIG: Path to xeno-config program
#
# - Xenomai_LIBRARY_XENOMAI
# - Xenomai_LIBRARY_NATIVE
# - Xenomai_LIBRARY_PTHREAD_RT
# - Xenomai_LIBRARY_RTDM
# - Xenomai_LIBRARY_RTDK ( deprecated after Xenomai 2.6.0)
# 
# - Xenomai_LIBRARIES_NATIVE
# - Xenomai_LIBRARIES_POSIX
#
# - Xenomai_LDFLAGS_NATIVE
# - Xenomai_LDFLAGS_POSIX
#
# - Xenomai_DEFINITIONS_POSIX: Same as Xenomai_DEFINITIONS
# - Xenomai_INCLUDE_DIR: Same as Xenomai_INCLUDE_DIRS
# 
# TODO: 
#
# - Add "COMPONENTS" interface for various usage modes

if( UNIX )

  # set the search paths
  set( Xenomai_SEARCH_PATH /usr/local /usr $ENV{XENOMAI_ROOT_DIR} ${Xenomai_ROOT_DIR})
  
  # find xeno_config.h
  find_path( Xenomai_INCLUDE_DIR
    xeno_config.h 
    PATHS ${Xenomai_SEARCH_PATH} 
    PATH_SUFFIXES xenomai include xenomai/include include/xenomai
    )

  # did we find xeno_config.h?
  if(Xenomai_INCLUDE_DIR) 
    MESSAGE(STATUS "xenomai found: \"${Xenomai_INCLUDE_DIR}\"")
    
    # set the root directory
    if( "${Xenomai_INCLUDE_DIR}" MATCHES "/usr/include/xenomai" )
      # on ubuntu linux, xenomai install is not rooted to a single dir
      set( Xenomai_ROOT_DIR /usr CACHE PATH "The Xenomai FHS root")
      set( Xenomai_INCLUDE_POSIX_DIR ${Xenomai_INCLUDE_DIR}/posix )
    else()
      # elsewhere, xenomai install is packaged
      get_filename_component(Xenomai_ROOT_DIR ${Xenomai_INCLUDE_DIR} PATH CACHE)
      set( Xenomai_INCLUDE_POSIX_DIR ${Xenomai_ROOT_DIR}/include/posix )
    endif()

    # Find xeno-config
    find_program(Xenomai_XENO_CONFIG NAMES xeno-config  PATHS ${Xenomai_ROOT_DIR}/bin NO_DEFAULT_PATH)

    # get xenomai version
    execute_process(COMMAND ${Xenomai_XENO_CONFIG} --version OUTPUT_VARIABLE Xenomai_VERSION)
    
    # find the xenomai pthread library
    find_library( Xenomai_LIBRARY_NATIVE  native  ${Xenomai_ROOT_DIR}/lib )
    find_library( Xenomai_LIBRARY_XENOMAI xenomai ${Xenomai_ROOT_DIR}/lib )
    find_library( Xenomai_LIBRARY_PTHREAD_RT pthread_rt rtdm ${Xenomai_ROOT_DIR}/lib )
    find_library( Xenomai_LIBRARY_RTDM    rtdm    ${Xenomai_ROOT_DIR}/lib )

    # In 2.6.0 RTDK was merged into the main xenomai library
    if(Xenomai_VERSION VERSION_GREATER 2.6.0)
      set(Xenomai_LIBRARY_RTDK_FOUND ${Xenomai_LIBRARY_XENOMAI_FOUND})
      set(Xenomai_LIBRARY_RTDK ${Xenomai_LIBRARY_XENOMAI})
    else()
      find_library( Xenomai_LIBRARY_RTDK    rtdk    ${Xenomai_ROOT_DIR}/lib )
    endif()

    set(Xenomai_LIBRARIES_NATIVE ${Xenomai_LIBRARY_NATIVE} ${Xenomai_LIBRARY_XENOMAI} pthread)
    set(Xenomai_LIBRARIES_POSIX ${Xenomai_LIBRARY_PTHREAD_RT} ${Xenomai_LIBRARY_XENOMAI} pthread rt)

    # Linker flags for the posix wrappers
    set(Xenomai_LDFLAGS_NATIVE "")#"-lnative -lxenomai -lpthread -lrt")
    set(Xenomai_LDFLAGS_POSIX "-Wl,@${Xenomai_ROOT_DIR}/lib/posix.wrappers")#-lpthread_rt -lxenomai -lpthread -lrt")

    # add compile/preprocess options
    set(Xenomai_DEFINITIONS -D_GNU_SOURCE -D_REENTRANT -pipe -D__XENO__)
    set(Xenomai_DEFINITIONS_POSIX ${Xenomai_DEFINITIONS})

    # set the library dirs
    set( Xenomai_LIBRARY_DIRS ${Xenomai_ROOT_DIR}/lib )

    # Compatibility
    set( Xenomai_INCLUDE_DIRS ${Xenomai_INCLUDE_DIR})
    set( Xenomai_LIBRARIES 
      ${Xenomai_LIBRARY_XENOMAI}
      ${Xenomai_LIBRARY_NATIVE}
      ${Xenomai_LIBRARY_PTHREAD_RT}
      ${Xenomai_LIBRARY_RTDM}
      ${Xenomai_LIBRARY_RTDK}
      )

  else( )
    MESSAGE(STATUS "xenomai NOT found. (${Xenomai_SEARCH_PATH})")
  endif( )

endif( UNIX )

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(Xenomai DEFAULT_MSG
  Xenomai_ROOT_DIR
  Xenomai_LIBRARY_NATIVE
  Xenomai_LIBRARY_XENOMAI
  Xenomai_LIBRARY_PTHREAD_RT
  Xenomai_LIBRARY_RTDM
  Xenomai_LIBRARY_RTDK
  )

# Compatibilitiy
set( Xenomai_FOUND ${XENOMAI_FOUND} )
