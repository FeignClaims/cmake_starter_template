#include "my_app/make_args.hpp"
#include "my_app/my_app_main.hpp"

auto main(int argc, char* argv[]) -> int {
  return my_app::my_app_main(my_app::make_args(argc, argv));
}