#include "Person.h"
#include <iostream>

using namespace std;

// ::域运算符
// 实现 .cpp 源文件
Person::Person() {
	cout << "Person() " << endl;
}

Person::~Person() {
	cout << "~Person() " << endl;
}

void Person::setAge(int age) {
	this->m_age = age;
}

int Person::getAge() {
	return this->m_age;
}