include_guard()

# TODO: remove the auxiliary target `graphviz_dot` and `graphviz_png`
# cmake-lint: disable=E1126,C0113
function(graphviz)
  set(options
    ENABLE_EXECUTABLES
    ENABLE_STATIC_LIBS
    ENABLE_SHARED_LIBS
    ENABLE_MODULE_LIBS
    ENABLE_INTERFACE_LIBS
    ENABLE_OBJECT_LIBS
    ENABLE_UNKNOWN_LIBS
    ENABLE_EXTERNAL_LIBS
    ENABLE_CUSTOM_TARGETS
    ENABLE_GENERATE_PER_TARGET
    ENABLE_GENERATE_DEPENDERS
  )
  set(one_value_args GRAPH_NAME GRAPH_HEADER NODE_PREFIX OUTPUT_DIRECTORY)
  set(multi_value_args IGNORE_TARGETS)
  cmake_parse_arguments(args "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  # _Set_default_value(<argument> <default_value>)
  #
  # if `argument` is not set, set it to the `default_value`
  macro(_Set_default_value argument default_value)
    if(NOT ${argument})
      set(${argument} ${default_value})
    endif()
  endmacro()

  _Set_default_value(args_GRAPH_NAME ${CMAKE_PROJECT_NAME})
  _Set_default_value(args_GRAPH_HEADER [=[node [ fontsize = "12" ];]=])
  _Set_default_value(args_NODE_PREFIX "node")
  _Set_default_value(args_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/graphviz")
  _Set_default_value(args_IGNORE_TARGETS "")

  set(dot_output_directory "${args_OUTPUT_DIRECTORY}/dot")
  set(png_output_directory "${args_OUTPUT_DIRECTORY}/png")

  file(
    CONFIGURE
    OUTPUT
    CMakeGraphVizOptions.cmake
    @ONLY
    CONTENT
    [[
set(GRAPHVIZ_GRAPH_NAME [=[@args_GRAPH_NAME@]=])
set(GRAPHVIZ_GRAPH_HEADER [=[@args_GRAPH_HEADER@]=])
set(GRAPHVIZ_NODE_PREFIX [=[@args_NODE_PREFIX@]=])
set(GRAPHVIZ_EXECUTABLES [=[@args_ENABLE_EXECUTABLES@]=])
set(GRAPHVIZ_STATIC_LIBS [=[@args_ENABLE_STATIC_LIBS@]=])
set(GRAPHVIZ_MODULE_LIBS [=[@args_ENABLE_MODULE_LIBS@]=])
set(GRAPHVIZ_INTERFACE_LIBS [=[@args_ENABLE_INTERFACE_LIBS@]=])
set(GRAPHVIZ_OBJECT_LIBS [=[@args_ENABLE_OBJECT_LIBS@]=])
set(GRAPHVIZ_UNKNOWN_LIBS [=[@args_ENABLE_UNKNOWN_LIBS@]=])
set(GRAPHVIZ_EXTERNAL_LIBS [=[@args_ENABLE_EXTERNAL_LIBS@]=])
set(GRAPHVIZ_IGNORE_TARGETS [=[@args_IGNORE_TARGETS@]=])
set(GRAPHVIZ_CUSTOM_TARGETS [=[@args_ENABLE_CUSTOM_TARGETS@]=])
set(GRAPHVIZ_GENERATE_PER_TARGET [=[@args_ENABLE_GENERATE_PER_TARGET@]=])
set(GRAPHVIZ_GENERATE_DEPENDERS [=[@args_ENABLE_GENERATE_DEPENDERS@]=])
]]
  )

  add_custom_target(
    graphviz_dot
    VERBATIM
    COMMAND ${CMAKE_COMMAND} -E make_directory ${dot_output_directory} ${png_output_directory}
    COMMAND ${CMAKE_COMMAND} --graphviz=${dot_output_directory}/main.dot .
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
  )

  add_custom_target(graphviz_png)

  file(
    GLOB dot_files
    LIST_DIRECTORIES FALSE
    CONFIGURE_DEPENDS "${dot_output_directory}/*dot*"
  )

  foreach(dot_file IN LISTS dot_files)
    cmake_path(GET dot_file FILENAME dot_file_filename)
    string(REGEX REPLACE [[main.dot.]] [[]] dot_file_filename ${dot_file_filename})
    string(REGEX REPLACE [[.dot]] [[]] dot_file_filename ${dot_file_filename})

    add_custom_command(
      TARGET graphviz_png
      PRE_BUILD
      COMMAND dot -Tpng ${dot_file} -o ${png_output_directory}/${dot_file_filename}.png
    )
  endforeach()

  add_custom_target(
    graphviz
    COMMAND ${CMAKE_COMMAND} --build . --target graphviz_dot
    COMMAND ${CMAKE_COMMAND} --build . --target graphviz_png
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
  )
endfunction()

# cmake-lint: disable=C0103
function(graphviz)
  include(CMakePrintHelpers)
  set(options
    "ENABLE_EXECUTABLES\;ON\;Include executables from the generated graphs"
    "ENABLE_STATIC_LIBS\;ON\;Include static libraries from the generated graphs"
    "ENABLE_SHARED_LIBS\;ON\;Include shared libraries from the generated graphs"
    "ENABLE_MODULE_LIBS\;ON\;Include module libraries from the generated graphs"
    "ENABLE_INTERFACE_LIBS\;ON\;Include interface libraries from the generated graphs"
    "ENABLE_OBJECT_LIBS\;ON\;Include object libraries from the generated graphs"
    "ENABLE_UNKNOWN_LIBS\;ON\;Include unknown libraries from the generated graphs"
    "ENABLE_EXTERNAL_LIBS\;ON\;Include external libraries from the generated graphs"
    "ENABLE_CUSTOM_TARGETS\;OFF\;Include custom targets from the generated graphs"
    "ENABLE_GENERATE_PER_TARGET\;ON\;generate per-target graphs `foo.dot.<target>`"
    "ENABLE_GENERATE_DEPENDERS\;ON\;generate depender graphs `foo.dot.<target>.dependers`"
  )

  foreach(option ${options})
    list(GET option 0 option_name)
    list(GET option 1 option_default)
    list(GET option 2 option_description)

    if(DEFINED GRAPHVIZ_${option_name})
      set(option_default ${GRAPHVIZ_${option_name}})
    endif()

    if(${option_default})
      set(${option_name}_value ${option_name})
    else()
      unset(${option_name}_value)
    endif()
  endforeach()

  _graphviz(
    ${ENABLE_EXECUTABLES_value}
    ${ENABLE_STATIC_LIBS_value}
    ${ENABLE_SHARED_LIBS_value}
    ${ENABLE_MODULE_LIBS_value}
    ${ENABLE_INTERFACE_LIBS_value}
    ${ENABLE_OBJECT_LIBS_value}
    ${ENABLE_UNKNOWN_LIBS_value}
    ${ENABLE_EXTERNAL_LIBS_value}
    ${ENABLE_CUSTOM_TARGETS_value}
    ${ENABLE_GENERATE_PER_TARGET_value}
    ${ENABLE_GENERATE_DEPENDERS_value}
    ${ARGN}
  )
endfunction()
