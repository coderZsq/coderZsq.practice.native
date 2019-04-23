// 01-函数重载(Overload).cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

/*
C语言不支持函数重载
*/
//int sum(double a, int b) {
//	return a + b;
//}
//
//int sum(int b, double a) {
//	return a + b;
//}

//int sum(int a, int b, int c) {
//	return a + b + c;
//}

// display_void
void display() {
	cout << "display() " << endl;
}

// display_int
void display(int a) {
	cout << "display(int a) " << a << endl;
}

// display_double
void display(double a) {
	cout << "display(double a) " << a << endl;
}

// display_long
void display(long a) {
	cout << "display(long a) " << a << endl;
}

int main()
{
	display();
	display(10);
	display(10l);
	display(10.1);

	/*cout << sum(10, 20) << endl;
	cout << sum(10, 20, 30) << endl;*/

	getchar();
	return 0;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
