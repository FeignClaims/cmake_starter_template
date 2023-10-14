#include "my_app/concat.hpp"

#include <boost/ut.hpp>

auto main() -> int {          // NOLINT(bugprone-exception-escape)
  using namespace boost::ut;  // NOLINT(*using-namespace*)

  "concat"_test = []() {
    expect(my_app::concat("h", "ello") == "hello");
  };
}