add_executable(test_header_only_lib)
target_sources(test_header_only_lib
  PRIVATE
  to_string.pass.cpp
)
target_link_libraries(test_header_only_lib
  PRIVATE
  header_only_lib
  project_options
  project_warnings
)

target_find_dependencies(test_header_only_lib
  PRIVATE
  GTest
)
target_link_system_libraries(test_header_only_lib
  PRIVATE
  GTest::gtest_main
)

include(GoogleTest)
gtest_discover_tests(test_header_only_lib)