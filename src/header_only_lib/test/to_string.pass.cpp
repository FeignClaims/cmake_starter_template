#include "header_only_lib/to_string.hpp"

#include <vector>

#include <gtest/gtest.h>

TEST(HeaderOnlyLib, ToString) {
  std::vector<int> const vec{1, 2, 3, 4};

  EXPECT_EQ("1, 2, 3, 4", header_only_lib::to_string(vec));  // put the expected value on the left side
}