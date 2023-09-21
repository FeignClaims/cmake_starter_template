include(AddTest)

add_library_test(app_library fibonacci.pass SOURCES fibonacci.pass.cpp)

add_executable_test(app no_arg)