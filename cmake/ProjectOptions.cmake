include_guard()

include(FetchContent)
FetchContent_Declare(_project_options
  GIT_REPOSITORY https://github.com/aminya/project_options.git
  GIT_TAG v0.32.0
  GIT_SHALLOW true
)
FetchContent_MakeAvailable(_project_options)
include(${_project_options_SOURCE_DIR}/Index.cmake)
include(${_project_options_SOURCE_DIR}/src/DynamicProjectOptions.cmake)
