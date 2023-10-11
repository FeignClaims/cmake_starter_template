add_library(lib)
target_sources(lib
  PRIVATE
  src/sort.cpp
)
target_include_interface_directories(lib include) # Includes
target_link_libraries(lib
  PRIVATE
  starter_project_options
  starter_project_warnings
)

target_find_dependencies(lib # Find dependencies
  PRIVATE_CONFIG
  range-v3
)
target_link_system_libraries(lib # Link dependencies
  PRIVATE
  range-v3::range-v3
)

# Tests
if(BUILD_TESTING)
  add_subdirectory(test)
endif()