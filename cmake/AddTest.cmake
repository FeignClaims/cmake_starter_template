# - Handy functions to create tests
# This module provides handy add_test wrappers and configs.
#
# These conifg functions will generate a test config target that can be used by linking it.
#
#   add_test_config(<config_name>  # target will be named as `test_config.${config_name}`
#     [SOURCES <arg1...>]
#     [INCLUDES <arg1...>]
#     [SYSTEM_INCLUDES <arg1...>]
#     [DEPENDENCIES_CONFIG <arg1...>]
#     [DEPENDENCIES <arg1...>]
#     [LIBRARIES <arg1...>]
#     [COMPILE_DEFINITIONS <arg1...>]
#     [COMPILE_OPTIONS <arg1...>]
#     [COMPILE_FEATURES <arg1...>]
#     [EXECUTE_ARGS <arg1...>]
#   )
#
# These add_test wrappers will generate a test target and register it in CTest.
#
#   add_library_test(<library> <test_name>
#     [CONFIGS <arg1...>]  # accepts both `${config_name}` and `test_config.${config_name}`
#     [SOURCES <arg1...>]
#     [INCLUDES <arg1...>]
#     [SYSTEM_INCLUDES <arg1...>]
#     [DEPENDENCIES_CONFIG <arg1...>]
#     [DEPENDENCIES <arg1...>]
#     [LIBRARIES <arg1...>]
#     [COMPILE_DEFINITIONS <arg1...>]
#     [COMPILE_OPTIONS <arg1...>]
#     [COMPILE_FEATURES <arg1...>]
#     [EXECUTE_ARGS <arg1...>]
#   )
#
#   add_executable_test(<executable> <test_name>
#     [CONFIGS <arg1...>]  # accepts both `${config_name}` and `test_config.${config_name}`
#     [EXECUTE_ARGS <arg1...>]
#   )

include_guard()

function(_Set_config_execute_args target_name execute_args)
  set_property(TARGET ${target_name} PROPERTY PROJECT_OPTIONS_EXECUTE_ARGS ${execute_args})
endfunction()

# Add a library test config called test_config.${config_name}
function(add_test_config config_name)
  set(options)
  set(one_value_args)
  set(multi_value_args
    SOURCES
    INCLUDES
    SYSTEM_INCLUDES
    DEPENDENCIES_CONFIG
    DEPENDENCIES
    LIBRARIES
    COMPILE_DEFINITIONS
    COMPILE_OPTIONS
    COMPILE_FEATURES
    EXECUTE_ARGS
  )
  cmake_parse_arguments(args "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  set(target_name "test_config.${config_name}")

  add_library(${target_name} INTERFACE)
  target_sources(${target_name}
    INTERFACE
    ${args_SOURCES}
  )
  target_include_directories(${target_name}
    INTERFACE
    ${args_INCLUDES}
  )
  target_include_system_directories(${target_name}
    INTERFACE
    ${args_SYSTEM_INCLUDES}
  )
  target_find_dependencies(${target_name}
    INTERFACE_CONFIG
    ${args_DEPENDENCIES_CONFIG}

    INTERFACE
    ${args_DEPENDENCIES}
  )
  target_link_system_libraries(${target_name}
    INTERFACE
    ${args_LIBRARIES}
  )
  target_compile_definitions(${target_name}
    PRIVATE
    ${args_COMPILE_DEFINITIONS}
  )
  target_compile_options(${target_name}
    PRIVATE
    ${args_COMPILE_OPTIONS}
  )
  target_compile_features(${target_name}
    PRIVATE
    ${args_COMPILE_FEATURES}
  )

  _Set_config_execute_args(${target_name} "${args_EXECUTE_ARGS}")
endfunction()

function(_Get_configs_execute_args variable_name)
  set(value)
  foreach(config IN LISTS ARGN)
    get_target_property(execute_args ${config} PROJECT_OPTIONS_EXECUTE_ARGS)
    list(APPEND variable_name ${execute_args})
  endforeach()
  set(${variable_name} ${value} PARENT_SCOPE)
endfunction()

function(_Add_configs_prefix variable_name)
  set(value)
  foreach(config IN LISTS ARGN)
    if (${config} MATCHES "test_config\..*")
      list(APPEND value "${config}")
    else()
      list(APPEND value "test_config.${config}")
    endif()
  endforeach()
  set(${variable_name} ${value} PARENT_SCOPE)
endfunction()

# Add a library test called test.${library}.${test_name}
function(add_library_test library test_name)
  set(options)
  set(one_value_args)
  set(multi_value_args
    CONFIGS
    SOURCES
    INCLUDES
    SYSTEM_INCLUDES
    DEPENDENCIES_CONFIG
    DEPENDENCIES
    LIBRARIES
    COMPILE_DEFINITIONS
    COMPILE_OPTIONS
    COMPILE_FEATURES
    EXECUTE_ARGS
  )
  cmake_parse_arguments(args "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  _Add_configs_prefix(prefixed_configs ${args_CONFIGS})

  set(target_name "test.${library}.${test_name}")

  list(LENGTH args_SOURCES sources_size)

  if(sources_size LESS 1)
    message(FATAL_ERROR "add_library_test must have at least one source file")
  endif()

  add_executable(${target_name})
  target_sources(${target_name}
    PRIVATE
    ${args_SOURCES}
  )
  target_include_directories(${target_name}
    PRIVATE
    ${args_INCLUDES}
  )
  target_link_libraries(${target_name}
    PRIVATE
    ${prefixed_configs}
    ${library}
  )

  target_include_system_directories(${target_name}
    PRIVATE
    ${args_SYSTEM_INCLUDES}
  )
  target_find_dependencies(${target_name}
    PRIVATE_CONFIG
    ${args_DEPENDENCIES_CONFIG}

    PRIVATE
    ${args_DEPENDENCIES}
  )
  target_link_system_libraries(${target_name}
    PRIVATE
    ${args_LIBRARIES}
  )
  target_compile_definitions(${target_name}
    PRIVATE
    ${args_COMPILE_DEFINITIONS}
  )
  target_compile_options(${target_name}
    PRIVATE
    ${args_COMPILE_OPTIONS}
  )
  target_compile_features(${target_name}
    PRIVATE
    ${args_COMPILE_FEATURES}
  )

  _Get_configs_execute_args(configs_execute_args ${prefixed_configs})
  add_test(
    NAME ${target_name}
    COMMAND ${target_name} ${configs_execute_args} ${args_EXECUTE_ARGS}
  )
endfunction()

# Add an executable test called test.${executable}.${test_name}
function(add_executable_test executable test_name)
  set(options)
  set(one_value_args)
  set(multi_value_args CONFIGS EXECUTE_ARGS)
  cmake_parse_arguments(args "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  _Add_configs_prefix(prefixed_configs ${args_CONFIGS})

  set(target_name "test.${executable}.${test_name}")

  _Get_configs_execute_args(configs_execute_args ${prefixed_configs})
  add_test(
    NAME ${target_name}
    COMMAND ${executable} ${configs_execute_args} ${args_EXECUTE_ARGS}
  )
endfunction()