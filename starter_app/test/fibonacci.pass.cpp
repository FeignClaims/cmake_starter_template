#include "starter_app/fibonacci.hpp"

#include <boost/ut.hpp>

auto main() -> int {
  using namespace boost::ut;  // NOLINT(*using-namespace*)

  "fibonacci"_test = [] {
    expect(starter_app::fibonacci(1) == 1);
    expect(starter_app::fibonacci(2) == 1);
    expect(starter_app::fibonacci(3) == 2);
  };
}