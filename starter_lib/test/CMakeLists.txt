add_test_config(starter_lib
  SYSTEM_LIBRARIES
  starter_header_only_lib
)

add_library_test(starter_lib sort CONFIGS common starter_lib SOURCES sort.cpp)