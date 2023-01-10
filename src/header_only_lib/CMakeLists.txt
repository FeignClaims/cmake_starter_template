add_library(header_only_lib INTERFACE)

# includes
target_library_include(header_only_lib)

# find dependencies
target_configure_dependencies(header_only_lib
  INTERFACE
  fmt
)

# link dependencies
target_link_system_libraries(header_only_lib
  INTERFACE
  fmt::fmt
)

# tests
if(ENABLE_TESTING)
  enable_testing()
  add_subdirectory(test)
endif()