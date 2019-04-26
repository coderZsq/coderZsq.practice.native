// 33-菱形继承.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Person {
public:
	int m_age;
	virtual void test() {
		cout << "virtual void test()" << endl;
	}
};

class Student :virtual public Person {
public:
	int m_score;
};

class Worker :virtual public Person {
public:
	int m_salary;
};

class Undergraduate :public Student, public Worker {
public:
	int m_grade;
};

int main() {
	Undergraduate ug;
	ug.m_grade = 10;
	ug.m_score = 20;
	ug.m_salary = 20;
	ug.test();
	/*ug.Student::m_age = 20;
	ug.Worker::m_age = 20;*/

	cout << sizeof(Undergraduate) << endl;

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
