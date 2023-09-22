include(AddTest)

configure_library_test(
  LIBRARIES
  starter_header_only_lib
)

add_library_test(starter_lib sort.pass SOURCES sort.pass.cpp)