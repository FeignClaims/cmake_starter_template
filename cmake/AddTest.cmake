# - Handy functions to create tests
#
# This module provides handy add_test wrappers and configurations.
# These conifg macros will add common configurations for the wrappers called in the current scope:
#
#   configure_library_test(
#     [SOURCES <arg1...>]
#     [INCLUDES <arg1...>]
#     [SYSTEM_INCLUDES <arg1...>]
#     [DEPENDENCIES_CONFIG <arg1...>]
#     [DEPENDENCIES <arg1...>]
#     [LIBRARIES <arg1...>]
#     [EXECUTE_ARGS <arg1...>]
#   )
#
#   config_executable_test(
#     [EXECUTE_ARGS <arg1...>]
#   )
#
# These add_test wrappers will generate a test target and register it in CTest.
#
#   add_library_test(<library> <test_name>
#     [SOURCES <arg1...>]
#     [INCLUDES <arg1...>]
#     [SYSTEM_INCLUDES <arg1...>]
#     [DEPENDENCIES_CONFIG <arg1...>]
#     [DEPENDENCIES <arg1...>]
#     [LIBRARIES <arg1...>]
#     [EXECUTE_ARGS <arg1...>]
#   )
#
#   add_executable_test(<executable> <test_name>
#     [EXECUTE_ARGS <arg1...>]
#   )

include_guard()

# Add common configurations for add_library_test in the current scope
macro(configure_library_test)
  set(options)
  set(one_value_args)
  set(multi_value_args SOURCES INCLUDES SYSTEM_INCLUDES DEPENDENCIES_CONFIG DEPENDENCIES LIBRARIES EXECUTE_ARGS)
  cmake_parse_arguments(LIBRARY_TEST "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})
endmacro()

# Add common configurations for add_executable_test in the current scope
macro(configure_executable_test)
  set(options)
  set(one_value_args)
  set(multi_value_args EXECUTE_ARGS)
  cmake_parse_arguments(EXECUTABLE_TEST "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})
endmacro()

# Add a library test called ${PROJECT_NAME}.test.${library}.${test_name}
function(add_library_test library test_name)
  set(options)
  set(one_value_args)
  set(multi_value_args SOURCES INCLUDES SYSTEM_INCLUDES DEPENDENCIES_CONFIG DEPENDENCIES LIBRARIES EXECUTE_ARGS)
  cmake_parse_arguments(args "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  set(test_framework_dependency "ut")
  set(test_framework_library "boost-ext-ut::ut")
  set(test_framework_execute_args)

  set(target_name "${PROJECT_NAME}.test.${library}.${test_name}")
  set(current_project_options "${PROJECT_NAME}_project_options")
  set(current_project_warnings "${PROJECT_NAME}_project_warnings")

  list(LENGTH args_SOURCES sources_size)

  if(sources_size LESS 1)
    message(FATAL_ERROR "add_library_test must have at least one source file")
  endif()

  add_executable(${target_name})
  target_sources(${target_name}
    PRIVATE
    ${args_SOURCES}
    ${LIBRARY_TEST_SOURCES}
  )
  target_include_directories(${target_name}
    PRIVATE
    ${args_INCLUDES}
    ${LIBRARY_TEST_INCLUDES}
  )
  target_link_libraries(${target_name}
    PRIVATE
    ${library}
    ${current_project_options}
    ${current_project_warnings}
  )

  target_include_system_directories(${target_name}
    PRIVATE
    ${args_SYSTEM_INCLUDES}
    ${LIBRARY_TEST_SYSTEM_INCLUDES}
  )
  target_find_dependencies(${target_name}
    PRIVATE_CONFIG
    ${test_framework_dependency}
    ${args_DEPENDENCIES_CONFIG}
    ${LIBRARY_TEST_DEPENDENCIES_CONFIG}

    PRIVATE
    ${args_DEPENDENCIES}
    ${LIBRARY_TEST_DEPENDENCIES}
  )
  target_link_system_libraries(${target_name}
    PRIVATE
    ${test_framework_library}
    ${args_LIBRARIES}
    ${LIBRARY_TEST_LIBRARIES}
  )

  add_test(
    NAME ${target_name}
    COMMAND ${target_name} ${test_framework_execute_args} ${args_EXECUTE_ARGS} ${LIBARRY_TEST_EXECUTE_ARGS}
  )
endfunction()

# Add a library test called ${PROJECT_NAME}.test.${executable}.${test_name}
function(add_executable_test executable test_name)
  set(options)
  set(one_value_args)
  set(multi_value_args EXECUTE_ARGS)
  cmake_parse_arguments(args "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  set(target_name "${PROJECT_NAME}.test.${executable}.${test_name}")

  add_test(
    NAME ${target_name}
    COMMAND ${executable} ${args_EXECUTE_ARGS} ${EXECUTABLE_TEST_EXECUTE_ARGS}
  )
endfunction()