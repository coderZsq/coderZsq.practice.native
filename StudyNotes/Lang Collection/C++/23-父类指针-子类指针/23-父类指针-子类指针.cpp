// 23-父类指针-子类指针.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Person {
public:
	int m_age;
};

class Student :public Person {
public:
	int m_score;
};

//class Animal {
//	int m_age;
//};
//
//class Cat :public Animal {
//	int m_life;
//};

int main() {
	// 父类指针代表寻址能力
	Person* stu = new Student();
	stu->m_age = 10;

	/*Student* p = (Student*) new Person();
	p->m_age = 10;
	p->m_score = 20;*/

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
