#include "starter_app/concat.hpp"

#include <fmt/core.h>

auto main() -> int {  // NOLINT(bugprone-exception-escape)
  fmt::print("{}\n", starter_app::concat("hello", "world"));
}