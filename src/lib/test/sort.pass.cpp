#include "lib/sort.hpp"

#include <vector>

#include <gtest/gtest.h>
#include <header_only_lib/to_string.hpp>

class [[nodiscard]] RangeToBeSorted : public ::testing::Test {
 protected:
  std::vector<int> vec{1, 3, 0, 4};
};

TEST_F(RangeToBeSorted, Sort1) {
  // The TEST_F make a new class that inherit from `RangeToBeSorted`,
  //so the modification inside Sort1 dosen't affect Sort2
  // i.e., class Unknown1 : public RangeTobeSorted { /*...*/ };

  EXPECT_EQ("1, 3, 0, 4", header_only_lib::to_string(vec));  // put the expected value on the left side
  lib::sort(vec);
  EXPECT_EQ("0, 1, 3, 4", header_only_lib::to_string(vec));
}

TEST_F(RangeToBeSorted, Sort2) {
  // The TEST_F make a new class that inherit from `RangeToBeSorted`,
  //so the modification inside Sort2 dosen't affect Sort1
  // i.e., class Unknown2 : public RangeTobeSorted { /*...*/ };

  EXPECT_EQ("1, 3, 0, 4", header_only_lib::to_string(vec));
  lib::sort(vec);
  EXPECT_EQ("0, 1, 3, 4", header_only_lib::to_string(vec));
}