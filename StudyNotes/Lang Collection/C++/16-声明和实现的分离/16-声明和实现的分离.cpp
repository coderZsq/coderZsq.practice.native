// 16-声明和实现的分离.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include "Person.h"

using namespace std;

// 声明 .h 头文件
//class Person {
//	int m_age;
//public:
//	Person();
//	~Person();
//	void setAge(int age);
//	int getAge();
//};

// ::域运算符
// 实现 .cpp 源文件
//Person::Person() {
//	cout << "Person() " << endl;
//}
//
//Person::~Person() {
//	cout << "~Person() " << endl;
//}
//
//void Person::setAge(int age) {
//	this->m_age = age;
//}
//
//int Person::getAge() {
//	return this->m_age;
//}

int main(){
	{
		Person person;
		person.setAge(20);
		cout << person.getAge() << endl;
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
