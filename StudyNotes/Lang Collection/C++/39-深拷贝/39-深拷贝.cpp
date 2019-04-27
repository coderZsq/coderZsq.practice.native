// 39-深拷贝.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

// 浅拷贝 (shallow copy): 指针类型仅仅是拷贝地址值
// 深拷贝 (deep copy): 拷贝内容到新申请的内存空间

class Car {
	int m_price;
	char* m_name;

public:
	Car(int price = 0, const char* name = NULL) :m_price(price) {
		if (name == NULL) return;

		// 申请堆空间存储字符串内容
		this->m_name = new char[strlen(name) + 1] {};
		// 拷贝字符串内容到堆空间 (string copy)
		strcpy(this->m_name, name);

		cout << "Car(int price, const char*)" << endl;
	}

	Car(const Car& car) :m_price(car.m_price) {
		if (car.m_name == NULL) return;

		// 申请堆空间存储字符串内容
		this->m_name = new char[strlen(car.m_name) + 1]{};
		// 拷贝字符串内容到堆空间 (string copy)
		strcpy(this->m_name, car.m_name);

		cout << "Car(const Car& car)" << endl;
	}

	~Car() {
		if (this->m_name == NULL) return;

		delete[] this->m_name;
		this->m_name = NULL;

		cout << "~Car()" << endl;
	}

	void display() {
		cout << "price is " << this->m_price << ", name is " << this->m_name << endl;
	}
};

int main() {

	{
		Car car1(100, "bmw");

		Car car2 = car1;
	}

	/* 将car1的内存空间 (8个字节) 覆盖car2的内存空间 (8个字节)
	mov         eax,dword ptr [car1]  
	mov         dword ptr [car2],eax
	*/

	/*char name[] = { 'b', 'm', 'w', '\0' };
	Car* car = new Car(100, name);
	car->display();
	delete car;*/

	//Car car(100, "bmw");

	//char name[] = { 'b', 'm', 'w', '\0' };
	//const char* name2 = "bmw";

	//cout << name2 << endl;

	//// string length
	//cout << strlen(name) << endl;

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
