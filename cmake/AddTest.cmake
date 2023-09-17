include_guard()

function(add_library_test library test_name)
  set(options)
  set(one_value_args TEST_NAME)
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
  )
  target_include_directories(${target_name}
    PRIVATE
    ${args_INCLUDES}
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
  )
  target_find_dependencies(${target_name}
    PRIVATE_CONFIG
    ${test_framework_dependency}
    ${args_DEPENDENCIES_CONFIG}

    PRIVATE
    ${args_DEPENDENCIES}
  )
  target_link_system_libraries(${target_name}
    PRIVATE
    ${test_framework_library}
    ${args_LIBRARIES}
  )

  add_test(
    NAME ${target_name}
    COMMAND ${target_name} ${test_framework_execute_args} ${args_EXECUTE_ARGS}
  )
endfunction()

function(add_executable_test executable test_name)
  set(options)
  set(one_value_args)
  set(multi_value_args EXECUTE_ARGS)
  cmake_parse_arguments(args "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  set(target_name "${PROJECT_NAME}.test.${executable}.${test_name}")

  add_test(
    NAME ${target_name}
    COMMAND ${executable} ${args_EXECUTE_ARGS}
  )
endfunction()