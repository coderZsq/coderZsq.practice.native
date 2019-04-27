// 37-const成员.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Car {
public:
	int m_price;
	// static const int msc_wheelsCount = 4;
	Car() :m_price(0) {
	
	}

	void test4() {
		test1();
	}

	static void test3() {
		
	}

	void test2() const {
		//this->m_price = 20;
	}

	// 不能在这个函数内部修改当前对象的成员变量
	void test1() const {
		// this->m_price = 10; //wrong
		/*Car car;
		car.m_price = 10;*/
		test2();
		test3();

		this->m_price;
		cout << this << endl;
	}

	void test() {
		cout << "test()" << endl;
	}

	void test() const {
		cout << "test() const" << endl;
	}
};

//void Car::test1() const {
//
//}

int main() {
	Car car;
	car.test();

	Car* p = new Car();
	p->test();

	const Car car2;
	car2.test();

	const Car* p2 = new Car();
	p2->test2();

	/*Car car1;
	car1.m_price = 100;

	Car car2;
	car2.m_price = 500;

	cout << sizeof(Car) << endl;*/

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
