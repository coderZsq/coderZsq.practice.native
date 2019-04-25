// 15-对象的内存管理.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

struct Car {
	int m_price;
	Car() {
		cout << "Car()" << endl;
	}

	~Car() {
		cout << "~Car()" << endl;
	}
};

struct Person {
	int m_age; // 4
	Car* m_car; // 4

	// 初始化工作
	Person() {
		cout << "Person()" << endl;

		this->m_car = new Car();

		/*Car car;
		this->m_car = &car;*/ // 指向被回收的栈空间, 会导致坏访问
	}

	// 内存回收, 清理工作(回收Person对象内部申请的堆空间)
	~Person() {
		cout << "~Person()" << endl;

		delete this->m_car;
	}
};

void test() {
	Person* p = new Person();

	delete p;
}

int main()
{
	test();

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
