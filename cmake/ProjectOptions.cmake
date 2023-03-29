include_guard()

message(STATUS "Downloading ProjectOptions from https://github.com/FeignClaims/project_options.git\n"
  "Please make sure that you can connect to github"
)
include(FetchContent)
FetchContent_Declare(_project_options
  GIT_REPOSITORY https://github.com/FeignClaims/project_options.git
  GIT_TAG feature/package_project_extension
  GIT_SHALLOW true
)
FetchContent_MakeAvailable(_project_options)
include(${_project_options_SOURCE_DIR}/Index.cmake)
include(${_project_options_SOURCE_DIR}/src/DynamicProjectOptions.cmake)
