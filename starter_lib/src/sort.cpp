#include "starter_lib/sort.hpp"

#include <range/v3/all.hpp>

namespace starter_lib {
void sort(std::vector<int>& vector) {
  ranges::sort(vector);
}
}  // namespace starter_lib