#include <string>
#include <iostream>

template <typename F>
void PrintResult(F f) { std::cout << f() << std::endl; }
std::string GetMessage();
