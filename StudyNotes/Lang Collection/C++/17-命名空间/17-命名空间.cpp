// 17-命名空间.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include "Car.h"
#include "Person.h"

//using namespace Cas;
using namespace std;

void test() {
	cout << "void test()" << endl;
}

namespace FX {
	int g_no;

	class Person {
	public:
		int m_age;
	};

	void test() {
		cout << "FX::void test()" << endl;
	}
}

//void test1() {
//	FX::g_no = 1;
//	Cas::g_no = 2;
//
//	FX::Person* p1 = new FX::Person();
//	p1->m_age = 10;
//
//	Cas::Person* p2 = new Cas::Person();
//	p2->m_height = 180;
//
//	test();
//	FX::test();
//	Cas::test();
//}

//namespace Cas {
//	int g_no;
//
//	class Person {
//	public:
//		int m_height;
//	};
//
//	void test() {
//		cout << "Cas::void test()" << endl;
//	}
//}

void test2() {
	/*using namespace Cas;
	g_no = 10;
	Person person;
	test();*/

	/*using Cas::g_no;
	using Cas::Person;
	g_no = 10;
	Person person;*/
}

namespace AA {
	namespace BB {
		int g_no;
		class Person {

		};
	}
}

void test3() {
	test();
	// 默认的命名空间, 空命名空间, 没有名字
	::test();

	::AA::BB::g_no = 30;

	AA::BB::g_no = 20;

	using namespace AA;
	BB::g_no = 30;

	using namespace AA::BB;
	g_no = 10;
}

int main() {
	Cas::Car car;
	Cas::Person person;

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
