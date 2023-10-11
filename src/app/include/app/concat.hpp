#ifndef STARTER_APP_CONCAT_HPP
#define STARTER_APP_CONCAT_HPP

#include <string>
namespace app {
[[nodiscard]] auto concat(std::string const& lhs, std::string const& rhs) noexcept(false) -> std::string;
}  // namespace app

#endif