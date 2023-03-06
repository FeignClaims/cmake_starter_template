cmake_minimum_required(VERSION 3.25)
project(starter VERSION 0.0.1 LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(MyProjectOptions)

if(PROJECT_IS_TOP_LEVEL)
  # Consider the CTest module, which creates targets and options!
  # Only needed if you want to enable submissions to a CDash server.
  include(CTest)
endif()

set(GIT_SHA
  "Unknown"
  CACHE STRING "SHA this build was generated from")
string(
  SUBSTRING "${GIT_SHA}"
  0
  8
  GIT_SHORT_SHA)

# Adding the src
add_subdirectory(src)

# Adding the tests
option(ENABLE_TESTING "Enable the tests" ${PROJECT_IS_TOP_LEVEL})

if(ENABLE_TESTING)
  enable_testing()
  message(AUTHOR_WARNING "Building Tests.")
  add_subdirectory(test)
endif()

option(ENABLE_FUZZING "Enable the fuzz tests" OFF)

if(ENABLE_FUZZING)
  message(AUTHOR_WARNING "Building Fuzz Tests, using fuzzing sanitizer https://www.llvm.org/docs/LibFuzzer.html")
  add_subdirectory(fuzz_test)
endif()

# If MSVC is being used, and ASAN is enabled, we need to set the debugger environment
# so that it behaves well with MSVC's debugger, and we can run the target from visual studio
if(MSVC)
  get_all_installable_targets(all_targets)
  message("all_targets=${all_targets}")
  set_target_properties(${all_targets} PROPERTIES VS_DEBUGGER_ENVIRONMENT "PATH=$(VC_ExecutablePath_x64);%PATH%")
endif()

# set the startup project for the "play" button in MSVC
set_property(DIRECTORY PROPERTY VS_STARTUP_PROJECT app)

if(CMAKE_SKIP_INSTALL_RULES)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  return()
endif()

# for products, using `package_project(TARGETS app)` to pack the executable should be enough
package_project(
  TARGETS
  app
  lib
  header_only_lib
  project_options
  project_warnings

  INTERFACE_INCLUDES
  ${header_only_lib_INTERFACE_DIRECTORY}

  INTERFACE_DEPENDENCIES_CONFIGURED
  ${header_only_lib_INTERFACE_DEPENDENCIES_CONFIGURED}
  ${lib_INTERFACE_DEPENDENCIES_CONFIGURED}

  PUBLIC_INCLUDES
  ${lib_INTERFACE_DIRECTORY}

  PUBLIC_DEPENDENCIES_CONFIGURED
  ${lib_PUBLIC_DEPENDENCIES_CONFIGURED}
)

# Experience shows that explicit package naming can help make it easier to sort
# out potential ABI related issues before they start, while helping you
# track a build to a specific GIT SHA
set(CPACK_PACKAGE_FILE_NAME
  "${CMAKE_PROJECT_NAME}-${CMAKE_PROJECT_VERSION}-${GIT_SHORT_SHA}-${CMAKE_SYSTEM_NAME}-${CMAKE_BUILD_TYPE}-${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}"
)

include(CPack)