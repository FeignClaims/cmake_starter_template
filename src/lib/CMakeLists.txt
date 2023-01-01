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

target_include_directories(lib PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>
)

find_package(range-v3 CONFIG REQUIRED)
target_link_system_libraries(lib
  PRIVATE
  range-v3::range-v3
)

if(ENABLE_TESTING)
  enable_testing()
  add_subdirectory(test)
endif()