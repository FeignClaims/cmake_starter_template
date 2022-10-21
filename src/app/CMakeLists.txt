# Seperate library part and `main()` function to simplify testing.
# If not doing so, you can't test because there's already a `main()` function.

add_library(app_library)
target_sources(app_library
  PRIVATE
  fibonacci.cpp
)
target_link_libraries(app_library
  PUBLIC
  project_options
  project_warnings
)
target_include_directories(app_library
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>
)

if(ENABLE_TESTING)
  enable_testing()
  add_subdirectory(test)
endif()

add_executable(app)
target_sources(app
  PRIVATE
  boostrap.cpp # just for main() function
)
target_link_libraries(app
  PRIVATE
  app_library
)