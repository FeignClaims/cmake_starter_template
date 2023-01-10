add_library(lib)
target_sources(lib
  PRIVATE
  src/sort.cpp
)
target_link_libraries(lib
  PRIVATE
  project_options
  project_warnings
)

# includes
target_library_include(lib)

# find dependencies
target_configure_dependencies(lib
  PRIVATE
  range-v3
)

foreach(dependency ${lib_PRIVATE_DEPENDENCIES_CONFIGURED})
  find_package(${dependency} CONFIG REQUIRED)
endforeach()

# link dependencies
target_link_system_libraries(lib
  PRIVATE
  range-v3::range-v3
)

# tests
if(ENABLE_TESTING)
  enable_testing()
  add_subdirectory(test)
endif()