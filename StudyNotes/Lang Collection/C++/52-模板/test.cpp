#include <iostream>
#include "Swap.hpp"
using namespace std;

void test() {
	double a = 10.8;
	double b = 20.4;
	swapValues(a, b);
	cout << "test() a = " << a << ", b = " << b << endl;
}