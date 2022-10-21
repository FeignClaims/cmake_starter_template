add_executable(test_lib)
target_sources(test_lib
  PRIVATE
  sort.pass.cpp
)
target_link_libraries(test_lib
  PRIVATE
  lib
  header_only_lib
  project_options
  project_warnings
)

find_package(GTest CONFIG REQUIRED)
target_link_system_libraries(test_lib
  PRIVATE
  GTest::gtest_main
)
include(GoogleTest)
gtest_discover_tests(test_lib)