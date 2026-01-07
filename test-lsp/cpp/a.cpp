#include <iostream>
#include <vector>

// template<int i>
// void a() {
//   a<i+1>();
// }
//
// void foo() {
//   a<0>();
// }

int main(int argc, char *argv[]) {
  std::cout << "hello world" << std::endl; char a[10];
  // a[10] = 0;
  a[1] = 0;
  std::vector<int> dp(10, 0);

  for (int i = 0; i < dp.size(); i++) {
    dp.at(i) = i + 100;
  }
  return 0;
}
