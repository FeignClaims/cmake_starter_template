add_test_config(lib
  SYSTEM_LIBRARIES
  header_only_lib
)

add_library_test(lib sort CONFIGS common lib SOURCES sort.cpp)