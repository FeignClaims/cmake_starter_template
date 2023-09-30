#ifndef STARTER_STARTER_APP_CONCAT_HPP
#define STARTER_STARTER_APP_CONCAT_HPP

#include <string>
namespace starter_app {
[[nodiscard]] auto concat(std::string const& lhs, std::string const& rhs) noexcept(false) -> std::string;
}  // namespace starter_app

#endif