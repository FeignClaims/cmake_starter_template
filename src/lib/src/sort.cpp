#include "lib/sort.hpp"

#include <range/v3/all.hpp>

namespace lib {
void sort(std::vector<int>& vector) {
  ranges::sort(vector);
}
}  // namespace lib