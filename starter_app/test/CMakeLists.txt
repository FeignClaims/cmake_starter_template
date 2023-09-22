include(AddTest)

add_library_test(starter_app_library fibonacci.pass SOURCES fibonacci.pass.cpp)

add_executable_test(starter_app no_arg)