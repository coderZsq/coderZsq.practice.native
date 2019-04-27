// 38-拷贝构造函数.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Car {
	int m_price;
	int m_length;

public:
	Car(int price = 0, int length = 0) :m_price(price), m_length(length) {
		cout << "Car(int price = 0, int length = 0)" << endl;
	}

	// 拷贝构造函数 (格式是固定的)
	Car(const Car& car) :m_price(car.m_price), m_length(car.m_length) {
		/*this->m_price = car.m_price;
		this->m_length = car.m_length;*/

		cout << "Car(const Car& car)" << endl;
	}

	void display() {
		cout << "price=" << this->m_price << ", length=" << this->m_length << endl;
	}
};

class Person {
	int m_age;
public:
	Person(int age = 0) :m_age(age) {}
	Person(const Person& person) :m_age(person.m_age) {}
};

class Student :public Person {
	int m_score;
public:
	Student(int age = 0, int score = 0) :Person(age), m_score(score) {}
	Student(const Student& student) :Person(student), m_score(student.m_score) {}
};

int main() {
//	Car car1;
//
//	Car car2(100, 5);
//	
//	// 利用car2对象创建了car3对象, 会调用car3对象的拷贝构造函数进行初始化
//	Car car3(car2);
//	/*
//	mov         eax,dword ptr [car2]  
//	mov         dword ptr [car3],eax	
//	*/
//	/* 如果自己实现了拷贝构造函数会调用
//`	lea         ecx,[car3]  
//	call        Car::Car (03F142Eh)  	
//	*/
//	car3.display();
//
//	cout << "&car2 = " << &car2 << endl;
//	cout << "&car3 = " << &car3 << endl;

	//Car car2(100, 5);
	//Car car3 = car2; // 等价于 Car car3(car2)

	// Car car2(100, 5);
	// Car car3;
	// 这里是赋值操作, 直接将car2的8个字节数据拷贝给car3的8个字节, 但这并不是创建新对象, 所以不会调用拷贝构造函数
	// car3 = car2;
	// car3.m_price = car2.m_price;
	// car3.m_length = car2.m_length;

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
