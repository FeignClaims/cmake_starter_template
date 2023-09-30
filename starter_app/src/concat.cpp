#include "starter_app/concat.hpp"

#include <string>

namespace starter_app {
[[nodiscard]] auto concat(std::string const& lhs, std::string const& rhs) noexcept(false) -> std::string {
  return lhs + rhs;
}
}  // namespace starter_app