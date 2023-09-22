add_library(starter_lib)
target_sources(starter_lib
  PRIVATE
  src/sort.cpp
)
target_include_interface_directories(starter_lib include) # Includes
target_link_libraries(starter_lib
  PRIVATE
  starter_project_options
  starter_project_warnings
)

target_find_dependencies(starter_lib # Find dependencies
  PRIVATE_CONFIG
  range-v3
)
target_link_system_libraries(starter_lib # Link dependencies
  PRIVATE
  range-v3::range-v3
)

# Tests
if(BUILD_TESTING)
  add_subdirectory(test)
endif()