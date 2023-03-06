add_executable(test_lib)
target_sources(test_lib
  PRIVATE
  sort.pass.cpp
)
target_link_libraries(test_lib
  PRIVATE
  lib
  project_options
  project_warnings
)

target_find_dependencies(test_lib
  PRIVATE
  GTest
)
target_link_system_libraries(test_lib
  PRIVATE
  header_only_lib
  GTest::gtest_main
)

include(GoogleTest)
gtest_discover_tests(test_lib)