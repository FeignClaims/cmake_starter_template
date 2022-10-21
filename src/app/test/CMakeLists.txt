add_executable(test_app_library)
target_sources(test_app_library
  PRIVATE
  fibonacci.pass.cpp
)
target_link_libraries(test_app_library
  PRIVATE
  app_library
  project_options
  project_warnings
)

find_package(GTest CONFIG REQUIRED)
target_link_system_libraries(test_app_library
  PRIVATE
  GTest::gtest_main
)
include(GoogleTest)
gtest_discover_tests(test_app_library)