#include "my_lib/sort.hpp"

#include <vector>

#include <boost/ut.hpp>
#include <my_header_only_lib/to_string.hpp>

auto main() -> int {          // NOLINT(bugprone-exception-escape)
  using namespace boost::ut;  // NOLINT(*using-namespace*)

  "sort.pass"_test = [] {
    std::vector<int> vector{1, 3, 0, 4};

    should("sort1") = [=]() mutable {
      expect(my_header_only_lib::to_string(vector) == "1, 3, 0, 4");
      my_lib::sort(vector);
      expect(my_header_only_lib::to_string(vector) == "0, 1, 3, 4");
    };

    should("sort2") = [=]() mutable {
      expect(my_header_only_lib::to_string(vector) == "1, 3, 0, 4");
      my_lib::sort(vector);
      expect(my_header_only_lib::to_string(vector) == "0, 1, 3, 4");
    };
  };
}