#include "app/fibonacci.hpp"

#include <boost/ut.hpp>

auto main() -> int {
  using namespace boost::ut;  // NOLINT(*using-namespace*)

  "fibonacci"_test = [] {
    expect(app::fibonacci(1) == 1);
    expect(app::fibonacci(2) == 1);
    expect(app::fibonacci(3) == 2);
  };
}