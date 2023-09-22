#include "starter_header_only_lib/to_string.hpp"

#include <vector>

#include <boost/ut.hpp>

auto main() -> int {
  using namespace boost::ut;  // NOLINT(*using-namespace*)

  "to_string"_test = [] {
    std::vector<int> const vec{1, 2, 3, 4};

    expect(starter_header_only_lib::to_string(vec) == "1, 2, 3, 4");
  };
}