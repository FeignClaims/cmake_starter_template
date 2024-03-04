cmake_minimum_required(VERSION 3.25)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(fetch_project_options)

project(starter VERSION 0.0.1 LANGUAGES CXX)

# Customize project_options
include(enable_customized_project_options)

# Options
option(BUILD_STARTER_TESTING "Build the testing tree." ON)
option(BUILD_STARTER_FUZZ_TESTING "Enable the fuzz tests" ON)

# workaround: RPATH stuff
# !!!NOT RECOMMENDED!!! see https://github.com/ossf/wg-best-practices-os-developers/blob/main/docs/Compiler-Hardening-Guides/Compiler-Options-Hardening-Guide-for-C-and-C%2B%2B.md
include(rpath)

# Include CTest before any tests
include(CTest)

# Add handy test wrappers
include(add_test)

# Common test config
add_test_config(common
  DEPENDENCIES_CONFIG
  Catch2

  LIBRARIES
  starter_project_options
  starter_project_warnings

  SYSTEM_LIBRARIES
  Catch2::Catch2WithMain

  EXECUTE_ARGS
  --reporter xml
)

# Add src
add_subdirectory(my_app)
add_subdirectory(my_header_only_lib)
add_subdirectory(my_lib)

# Set the startup project for the "play" button in MSVC
set_property(DIRECTORY PROPERTY VS_STARTUP_PROJECT my_app)

# Package the project
# for products, using `package_project(TARGETS app)` to pack the executable should be enough
package_project(
  TARGETS
  my_app
  my_lib
  my_header_only_lib
  starter_project_options
  starter_project_warnings
)

set(CPACK_PACKAGE_FILE_NAME
  "${CMAKE_PROJECT_NAME}-${CMAKE_PROJECT_VERSION}-${GIT_SHA}-${CMAKE_SYSTEM_NAME}-${CMAKE_BUILD_TYPE}-${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}"
)

include(CPack)