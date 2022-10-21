#include <gtest/gtest.h>

#include <fibonacci.hpp>

TEST(App, Fibonacci) {
  EXPECT_EQ(1, app::fibonacci(1));
  EXPECT_EQ(1, app::fibonacci(2));
  EXPECT_EQ(2, app::fibonacci(3));
}