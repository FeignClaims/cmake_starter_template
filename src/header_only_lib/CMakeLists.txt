add_library(header_only_lib INTERFACE)
target_include_directories(header_only_lib INTERFACE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>
)

find_package(fmt CONFIG REQUIRED)
target_link_system_libraries(header_only_lib INTERFACE
  fmt::fmt
)

if(ENABLE_TESTING)
  enable_testing()
  add_subdirectory(test)
endif()