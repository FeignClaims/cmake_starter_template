#include "lib/sort.hpp"

#include <vector>

#include <boost/ut.hpp>
#include <header_only_lib/to_string.hpp>

auto main() -> int {
  using namespace boost::ut;  // NOLINT(*using-namespace*)

  "sort"_test = [] {
    std::vector<int> vector{1, 3, 0, 4};

    should("sort1") = [=] mutable {
      expect(header_only_lib::to_string(vector) == "1, 3, 0, 4");
      lib::sort(vector);
      expect(header_only_lib::to_string(vector) == "0, 1, 3, 4");
    };

    should("sort2") = [=] mutable {
      expect(header_only_lib::to_string(vector) == "1, 3, 0, 4");
      lib::sort(vector);
      expect(header_only_lib::to_string(vector) == "0, 1, 3, 4");
    };
  };
}