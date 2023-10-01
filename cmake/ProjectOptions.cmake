# - A macro that fetches project_options
# This module provides a macro that fetches project_options from the specified repository and tag
#
# Projects should include `CustomizedProjectOptions` instead of including this one directly
#
# fetch_project_options(<git_repository>  <git_tag>)
include_guard()

macro(fetch_project_options git_repository git_tag)
  include(FetchContent)
  FetchContent_Declare(_project_options
    GIT_REPOSITORY ${git_repository}
    GIT_TAG ${git_tag}
    GIT_SHALLOW true
  )
  FetchContent_MakeAvailable(_project_options)
  include(${_project_options_SOURCE_DIR}/Index.cmake)
  include(${_project_options_SOURCE_DIR}/src/DynamicProjectOptions.cmake)
endmacro()
