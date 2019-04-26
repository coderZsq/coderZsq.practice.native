// 32-同名成员变量.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Student {
public:
	int m_age;
};

class Worker {
public:
	int m_age;
};

class Undergraduate :public Student, public Worker {
public:
	int m_age;
};

int main() {
	Undergraduate ug;
	ug.m_age = 10;
	ug.Student::m_age = 20;
	ug.Worker::m_age = 30;
	ug.Undergraduate::m_age = 40;

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
