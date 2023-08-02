# Seperate library part and `main()` function to simplify testing.
# If not doing so, you can't test because there's already a `main()` function.

# Library part
add_library(app_library)
target_sources(app_library
  PRIVATE
  src/fibonacci.cpp
)
target_include_interface_directories(app_library include) # Includes
target_link_libraries(app_library
  PRIVATE
  starter_project_options
  starter_project_warnings
)

# Executable part
add_executable(app)
target_sources(app
  PRIVATE
  src/bootstrap.cpp # Just for main() function
)
target_link_libraries(app
  PRIVATE
  app_library
  starter_project_options
  starter_project_warnings
)

target_find_dependencies(app # Find dependencies
  PRIVATE_CONFIG
  fmt
)
target_link_system_libraries(app # Link dependencies
  PRIVATE
  fmt::fmt
)

# Tests
if(BUILD_TESTING)
  enable_testing()
  add_subdirectory(test)
endif()