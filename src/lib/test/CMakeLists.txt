include(AddTest)

add_library_test(lib sort.pass
  SOURCES
  sort.pass.cpp

  LIBRARIES
  header_only_lib
)