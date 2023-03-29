# Library part
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

target_find_dependencies(test_app_library
  PRIVATE_CONFIG
  GTest
)
target_link_system_libraries(test_app_library
  PRIVATE
  GTest::gtest_main
)

include(GoogleTest)
gtest_discover_tests(test_app_library)

# Executable part
add_test(
  NAME test_app
  COMMAND app ""
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)