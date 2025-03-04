#include "funcs.h"
int main(void)
{
	const std::string str = GetMessage();
	std::cout << str << std::endl;

	const int a = 4;
	PrintResult([=]() { return a + str.length(); });
}
