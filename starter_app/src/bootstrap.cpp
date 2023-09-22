#include "starter_app/fibonacci.hpp"

#include <fmt/core.h>

auto main() -> int {
  fmt::print("{}\n", starter_app::fibonacci(3));
}