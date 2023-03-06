#include "app/fibonacci.hpp"

#include <fmt/core.h>

auto main() -> int {
  fmt::print("{}\n", app::fibonacci(3));
}