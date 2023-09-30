#include "starter_lib/sort.hpp"

#include <vector>

#include <boost/ut.hpp>
#include <starter_header_only_lib/to_string.hpp>

auto main() -> int {          // NOLINT(bugprone-exception-escape)
  using namespace boost::ut;  // NOLINT(*using-namespace*)

  "sort.pass"_test = [] {
    std::vector<int> vector{1, 3, 0, 4};

    should("sort1") = [=]() mutable {
      expect(starter_header_only_lib::to_string(vector) == "1, 3, 0, 4");
      starter_lib::sort(vector);
      expect(starter_header_only_lib::to_string(vector) == "0, 1, 3, 4");
    };

    should("sort2") = [=]() mutable {
      expect(starter_header_only_lib::to_string(vector) == "1, 3, 0, 4");
      starter_lib::sort(vector);
      expect(starter_header_only_lib::to_string(vector) == "0, 1, 3, 4");
    };
  };
}