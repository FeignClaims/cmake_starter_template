#include "app/fibonacci.hpp"

namespace app {
[[nodiscard]] auto fibonacci(int index) -> int {
  if (index == 0 || index == 1) {
    return index;
  }
  return fibonacci(index - 1) + fibonacci(index - 2);
}
}  // namespace app