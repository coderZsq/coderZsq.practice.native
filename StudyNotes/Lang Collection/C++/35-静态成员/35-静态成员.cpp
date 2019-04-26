// 35-静态成员.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Person {
public:
	static int ms_count;
};

class Student :public Person {

};

int Person::ms_count = 0;

int main() {
	Person::ms_count = 20;
	Student::ms_count = 10;

	cout << sizeof(Student) << endl;
	cout << Person::ms_count << endl;

	getchar();
	return 0;
}

//class Person {
//public:
//	static void test();
//};
//
//void Person::test() {
//
//}
//
//class Car {
//private:
//public:
//	// m member
//	// s static
//	static int ms_count;
//	int m_price;
//
//	void test() {
//		this->m_price = 10;
//	}
//
//	static void test2() {
//
//	}
//
//	/*static virtual void test3() { //wrong
//	
//	}*/
//};

//class Car {
//private:
//	static int m_count;
//public:
//	Car() {
//		m_count++;
//	}
//	~Car() {
//		m_count--;
//	}
//	static int getCount() {
//		return m_count;
//	}
//};
//
//int Car::m_count = 0;
//
//int main() {
//	/*Car car1;
//	Car car2;
//	Car* p = new Car();
//	delete p;*/
//
//	cout << Car::getCount() << endl;
//
//	getchar();
//	return 0;
//}

/*class Car {
public:
	static int m_price;
	static void run() {
		cout << "run()" << endl;
	}
};

// 初始化静态成员变量 数据段 ds : [0119A138h]
int Car::m_price = 0;

int main() {
	Car car;
	car.m_price = 10;
	//mov         dword ptr ds : [0119A138h] , 0Ah

	Car car2;
	car2.m_price = 20;
	//mov         dword ptr ds : [0119A138h] , 14h

	Car::m_price = 30;
	//mov         dword ptr ds : [0119A138h] , 1Eh

	Car* p = new Car();
	p->m_price = 40;
	//mov         dword ptr ds:[00A8A2D0h],28h 

	Car car3;
	cout << car3.m_price << endl;
	//mov         esi, esp
	//push        1191258h
	//mov         edi, esp
	//mov         eax, dword ptr ds : [0119A138h]

	getchar();
	return 0;
}*/

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
