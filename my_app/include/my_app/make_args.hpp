#ifndef MY_APP_MAKE_ARGS_HPP
#define MY_APP_MAKE_ARGS_HPP

#include <gsl/gsl>
#include <string_view>
#include <vector>

#include <range/v3/all.hpp>

namespace my_app {
// NOLINTNEXTLINE(*c-array*)
[[nodiscard]] inline auto make_args(int argc, gsl::zstring argv[]) -> std::vector<std::string_view> {
  return ranges::views::counted(argv, argc)
         | ranges::views::transform([](gsl::zstring arg) { return std::string_view{arg}; }) | ranges::to<std::vector>();
}
}  // namespace my_app

#endif