// 19-成员访问权限.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

//struct Person {
//protected:
//	int m_age;
//	void run() {
//		//m_age = 10;
//	}
//};
//
//class Student : private Person {
//	int m_no;
//	void study() {
//		//this->m_age = 30;
//	}
//};
//
//struct GoodStudent : public Student {
//	int m_money;
//	void work() {
//		//m_age = 10;
//	}
//};

class Person {
private:
	int m_age;
public:
	int m_no;
	/*void setAge() {
		this->m_age = 10;
	}*/
};

int main() {
	Person person;

	/*Person person;
	person.m_age = 20;
	person.run();*/

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
