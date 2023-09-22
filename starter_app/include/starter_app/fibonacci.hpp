#ifndef STARTER_STARTER_APP_FIBONACCI_HPP
#define STARTER_STARTER_APP_FIBONACCI_HPP

namespace starter_app {
/**
 * Get the fibonacci number of `index` starting with `fibonacci(0) == 0`, `fibonacci(1) == 1`.
 * 
 * @param[in] index
 * @return int The fibonacci number of `index`.
 */
[[nodiscard]] auto fibonacci(int index) -> int;
}  // namespace starter_app

#endif