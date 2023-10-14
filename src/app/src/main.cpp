#include "app/concat.hpp"

#include <fmt/core.h>

auto main() -> int {  // NOLINT(bugprone-exception-escape)
  fmt::print("{}\n", app::concat("hello", "world"));
}