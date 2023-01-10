# Seperate library part and `main()` function to simplify testing.
# If not doing so, you can't test because there's already a `main()` function.

add_library(app_library)
target_sources(app_library
  PRIVATE
  src/fibonacci.cpp
)
target_link_libraries(app_library
  PUBLIC
  project_options
  project_warnings
)
target_include_directories(app_library
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

if(ENABLE_TESTING)
  enable_testing()
  add_subdirectory(test)
endif()

add_executable(app)
target_sources(app
  PRIVATE
  src/boostrap.cpp # just for main() function
)
target_link_libraries(app
  PRIVATE
  app_library
)

find_package(fmt CONFIG REQUIRED)
target_link_system_libraries(app
  PRIVATE
  fmt::fmt
)