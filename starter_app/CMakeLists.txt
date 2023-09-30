# Seperate library part and `main()` function to simplify testing.
# If not doing so, you can't test because there's already a `main()` function.

# Library part
add_library(starter_app_library)
target_sources(starter_app_library
  PRIVATE
  src/concat.cpp
)
target_include_interface_directories(starter_app_library include) # Includes
target_link_libraries(starter_app_library
  PRIVATE
  starter_project_options
  starter_project_warnings
)

# Executable part
add_executable(starter_app)
target_sources(starter_app
  PRIVATE
  src/bootstrap.cpp # Just for main() function
)
target_link_libraries(starter_app
  PRIVATE
  starter_app_library
  starter_project_options
  starter_project_warnings
)

target_find_dependencies(starter_app # Find dependencies
  PRIVATE_CONFIG
  fmt
)
target_link_system_libraries(starter_app # Link dependencies
  PRIVATE
  fmt::fmt
)

# Tests
if(BUILD_TESTING)
  add_subdirectory(test)
endif()