cmake_minimum_required(VERSION 3.25)
project(starter VERSION 0.0.1 LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# Customize project_options
include(CustomizedProjectOptions)

# Options
option(BUILD_TESTING "Build the testing tree." OFF)
option(BUILD_FUZZ_TESTING "Enable the fuzz tests" OFF)

# Include CTest before any tests
include(CTest)

# Add handy test wrappers
include(AddTest)

# Common test config
add_test_config(common
  DEPENDENCIES_CONFIG
  ut

  LIBRARIES
  starter_project_options
  starter_project_warnings

  SYSTEM_LIBRARIES
  boost-ext-ut::ut
)

# Add src
add_subdirectory(starter_app)
add_subdirectory(starter_header_only_lib)
add_subdirectory(starter_lib)

# Set the startup project for the "play" button in MSVC
set_property(DIRECTORY PROPERTY VS_STARTUP_PROJECT starter_app)

# Package the project
# for products, using `package_project(TARGETS app)` to pack the executable should be enough
package_project(
  TARGETS
  starter_app
  starter_lib
  starter_header_only_lib
  starter_project_options
  starter_project_warnings
)

set(CPACK_PACKAGE_FILE_NAME
  "${CMAKE_PROJECT_NAME}-${CMAKE_PROJECT_VERSION}-${CMAKE_SYSTEM_NAME}-${CMAKE_BUILD_TYPE}-${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}"
)

include(CPack)