add_library(starter_header_only_lib INTERFACE)
target_include_interface_directories(starter_header_only_lib include) # Includes
target_link_libraries(starter_header_only_lib
  INTERFACE
  starter_project_options
  starter_project_warnings
)

target_find_dependencies(starter_header_only_lib # Find dependencies
  INTERFACE_CONFIG
  fmt
)
target_link_system_libraries(starter_header_only_lib # Link dependencies
  INTERFACE
  fmt::fmt
)

# Tests
if(BUILD_TESTING)
  add_subdirectory(test)
endif()