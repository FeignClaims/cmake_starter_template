add_library(header_only_lib INTERFACE)
target_include_interface_directory(header_only_lib) # Includes
target_link_libraries(header_only_lib
  INTERFACE
  project_options
  project_warnings
)

target_find_dependencies(header_only_lib # Find dependencies
  INTERFACE
  fmt
)
target_link_system_libraries(header_only_lib # Link dependencies
  INTERFACE
  fmt::fmt
)

# Tests
if(ENABLE_TESTING)
  enable_testing()
  add_subdirectory(test)
endif()