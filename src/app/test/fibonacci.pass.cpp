#include "app/fibonacci.hpp"

#include <gtest/gtest.h>

TEST(App, Fibonacci) {
  EXPECT_EQ(1, app::fibonacci(1));
  EXPECT_EQ(1, app::fibonacci(2));
  EXPECT_EQ(2, app::fibonacci(3));
}