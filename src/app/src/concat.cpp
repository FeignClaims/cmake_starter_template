#include "app/concat.hpp"

#include <string>

namespace app {
[[nodiscard]] auto concat(std::string const& lhs, std::string const& rhs) noexcept(false) -> std::string {
  return lhs + rhs;
}
}  // namespace app