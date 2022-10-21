# https://github.com/microsoft/STL/blob/main/tools/format/CMakeLists.txt
find_program(
  CLANG_FORMAT REQUIRED
  NAMES clang-format
  DOC "The clang-format program to use"
)

set(EXPRESSION
    c
    cc
    C
    cii
    cxx
    c++
    cpp
    h
    hii
    hh
    hxx
    h++
    hpp
)

list(TRANSFORM EXPRESSION PREPEND "*." OUTPUT_VARIABLE REGEX)
file(
  GLOB_RECURSE CLANG_FORMAT_FILES FOLLOW_SYMLINKS
  LIST_DIRECTORIES false
  ${REGEX}
)

set(EXCLUDE_DIRECTORIES build extern .*)
foreach(directory IN LISTS EXCLUDE_DIRECTORIES)
  list (TRANSFORM EXPRESSION PREPEND "${directory}/*." OUTPUT_VARIABLE regex)
  file(
    GLOB_RECURSE exclude_files FOLLOW_SYMLINKS
    LIST_DIRECTORIES false
    ${regex}
  )
  list(APPEND EXCLUDE_FILES ${exclude_files})
endforeach()

list(REMOVE_ITEM CLANG_FORMAT_FILES ${EXCLUDE_FILES})

execute_process(COMMAND "${CLANG_FORMAT}" --verbose -i ${CLANG_FORMAT_FILES})
