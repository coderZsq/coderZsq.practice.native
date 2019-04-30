// 54-C++新特性.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Person {
public:
	int m_age;
};

void testauto() {
	/*int i = 10;
	const char* name = "jack";
	double d = 9.6;*/

	//auto i = 10;
	//auto name = "jack";
	//auto d = 9.6;
	//auto p = new Person();
	//p->m_age = 10;
}

void testdecltype() {
	//int a = 10;
	//decltype(a) b = 20; // int
}

void func(int p) {
	cout << "func(int) - " << p << endl;
}

void func(int* p) {
	cout << "func(int*) - " << p << endl;
}

void testnullptr() {
	/*int i1 = 0;
	int i2 = NULL;*/

	func(0);
	func(NULL);
	func(nullptr);

	cout << (nullptr == NULL) << endl;
}

void testarray() {
	int array[]{ 10, 20, 30, 40 };
	//int array[] = { 10, 20, 30, 40 };
	/*for (int item : array) {
		cout << item << endl;
	}*/

	/*int length = sizeof(array) / sizeof(int);
	for (int i = 0; i < length; i++) {
		cout << array[i] << endl;
	}*/
}

int sum(int a, int b) { return a + b; }
int minus1(int a, int b) { return a - b; }
int multiple(int a, int b) { return a * b; }
int divide(int a, int b) { return a / b; }

int exec(int a, int b, int (*func)(int, int)) {
	return func(a, b);
}

int main() {
	//int (*p)(int, int) = [](int a, int b) -> int {
	//	return a + b;
	//};
	//// call        <lambda_58bb5c394980ee2094362990abca12d4>::operator int (__cdecl*)(int,int) (02C1F90h)  
	//cout << p(10, 20) << endl;
	
	/*cout << [](int a, int b) -> int {
		return a + b;
	}(10, 20) << endl;*/

	/*cout << [](int a, int b) {
		return a + b;
	}(10, 20) << endl;*/

	/*void(*p)() = [] {
		cout << 1 << endl;
		cout << 2 << endl;
		cout << 3 << endl;
	};
	p();
	p();*/

	/*cout << exec(20, 10, sum) << endl;
	cout << exec(20, 10, minus1) << endl;
	cout << exec(20, 10, multiple) << endl;
	cout << exec(20, 10, divide) << endl;*/

	/*cout << exec(20, 10, [](int a, int b) {return a + b; }) << endl;
	cout << exec(20, 10, [](int a, int b) {return a - b; }) << endl;
	cout << exec(20, 10, [](int a, int b) {return a * b; }) << endl;
	cout << exec(20, 10, [](int a, int b) {return a / b; }) << endl;*/

	int a = 10;
	int b = 20;

	// 默认情况是值捕获
	/*
	auto p = [&a, b] {
		cout << a << endl;
		cout << b << endl;
	};*/
	/*
	auto p = [=, &b] {
		cout << a << endl;
		cout << b << endl;
	};
	auto p = [&, a] {
		cout << a << endl;
		cout << b << endl;
	};*/

	auto p = [a]() mutable {
		a++;
		cout << "lambda - " << a << endl;
	};

	a = 11;
	b = 12;

	p();

	cout << a << endl;

	if (int a = 10; a > 5) {
	
	}
	else if (int b = 20; b > 10) {
	
	}
	else if (2) {
	
	}
	else {
	
	}

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
