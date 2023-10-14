#ifndef MY_APP_MY_APP_MAIN_HPP
#define MY_APP_MY_APP_MAIN_HPP

#include <vector>

namespace my_app {
[[nodiscard]] auto my_app_main([[maybe_unused]] std::vector<std::string_view> const& args) noexcept -> int;
}  // namespace my_app

#endif