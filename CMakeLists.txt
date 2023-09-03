cmake_minimum_required(VERSION 3.25)
project(starter VERSION 0.0.1 LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# Customize project_options
include(CustomizedProjectOptions)

# Adding the src
add_subdirectory(src)

# Options
option(BUILD_TESTING "Build the testing tree." OFF)
option(BUILD_FUZZ_TESTING "Enable the fuzz tests" OFF)

include(CTest)

# Adding the tests
if(BUILD_TESTING)
  enable_testing()
  message(STATUS "Building Tests.")
  add_subdirectory(test)
endif()

# Adding the fuzzing tests
if(BUILD_FUZZ_TESTING)
  message(STATUS "Building Fuzz Tests, using fuzzing sanitizer https://www.llvm.org/docs/LibFuzzer.html")
  add_subdirectory(fuzz_test)
endif()

# set the startup project for the "play" button in MSVC
set_property(DIRECTORY PROPERTY VS_STARTUP_PROJECT app)

# Packaging the project
# for products, using `package_project(TARGETS app)` to pack the executable should be enough
package_project(
  TARGETS
  app
  lib
  header_only_lib
  starter_project_options
  starter_project_warnings
)

set(CPACK_PACKAGE_FILE_NAME
  "${CMAKE_PROJECT_NAME}-${CMAKE_PROJECT_VERSION}-${CMAKE_SYSTEM_NAME}-${CMAKE_BUILD_TYPE}-${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}"
)

include(CPack)