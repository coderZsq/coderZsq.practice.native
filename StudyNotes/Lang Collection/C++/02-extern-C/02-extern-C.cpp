// 02-extern-C.cpp : This file contains the 'main' function. Program execution begins and ends there.
//
//#define __cplusplus
#include <iostream>

//extern "C" {
	#include "sum.h"
//}

using namespace std;

// Error	C2733	'func': second C linkage of overloaded function not allowed	

//extern "C" void func() {
//	cout << "func()" << endl;
//}
//
//extern "C" void func(int a) {
//	cout << "func(int a)" << a << endl;
//}

//extern "C" {
//	void func() {
//		cout << "func()" << endl;
//	}
//
//	void func(int a) {
//		cout << "func(int a)" << a << endl;
//	}
//}

//extern "C" void func();
//extern "C" void func(int a);

//extern "C" {
//	void func();
//	void func(int a);
//}

int main()
{
	//func();
	//func(10);
	
	//Error	LNK2019	unresolved external symbol "int __cdecl sum(int,int)" (? sum@@YAHHH@Z) referenced in function
	cout << sum(10, 20) << endl;

	getchar();
	return 0;
}

//void func() {
//	cout << "func()" << endl;
//}
//
//void func(int a) {
//	cout << "func(int a)" << a << endl;
//}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
