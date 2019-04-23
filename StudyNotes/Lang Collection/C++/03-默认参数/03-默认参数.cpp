// 03-默认参数.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

//void func(int a = 10, int b = 60, int c = 20);
//
//void func(int a, int b, int c) {
//	cout << "a is " << a << endl;
//	cout << "b is " << b << endl;
//	cout << "c is " << c << endl;
//}

int age = 70;

//void func(int a = 10, int b = 60, int c = age) {
//	cout << "a is " << a << endl;
//	cout << "b is " << b << endl;
//	cout << "c is " << c << endl;
//}

void test() {
	cout << "test()" << endl;
}

void display(int a, void (*func)() = test) {
	cout << "a is " << a << endl;
	cout << "func is " << func << endl;
	func();
}

void display() {
	cout << "display" << endl;
}

void display(int a = 10, int b = 60) {
	cout << "a is " << a << endl;
	cout << "b is " << b << endl;
}

int main()
{
	//Error	C2668	'display': ambiguous call to overloaded function
	//display();

	//display(50);

	//指向函数的指针
	/*void (*funcPtr)() = test;
	funcPtr();*/

	//func();

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
