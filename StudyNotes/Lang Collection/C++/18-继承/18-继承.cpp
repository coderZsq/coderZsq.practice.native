// 18-继承.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

//struct Person {
//	int m_age;
//	void run() {
//		cout << "run()" << endl;
//	}
//};
//
//struct Student: Person {
//	int m_score;	
//	void study() {
//		cout << "study()" << endl;
//	}
//};
//
//struct Worker: Person {
//	int m_salary;
//	void work() {
//		cout << "work()" << endl;
//	}
//};

// Java: 所有的Java对象最终都继承自java.lang.Object这个类
// OC: 所有的OC对象最终都继承自NSObject这个类

void test() {
	/*Student student;
	student.m_age = 18;
	student.m_score = 100;
	student.run();
	student.study();*/
}

class Person {
public:
	int m_age;
};

struct Student: Person{
	int m_no;
};

struct GoodStudent: Student {
	int m_money;
};

int main()
{
	// 12
	GoodStudent gs;
	gs.m_age = 20;
	gs.m_no = 1;
	gs.m_money = 2000;

	cout << &gs << endl; //010FF9D0
	cout << &gs.m_age << endl; //010FF9D0
	cout << &gs.m_no << endl; //010FF9D4
	cout << &gs.m_money << endl; //010FF9D8

	// 4
	Person person;

	// 8
	Student student;

	cout << sizeof(Person) << endl;
	cout << sizeof(Student) << endl;
	cout << sizeof(GoodStudent) << endl;

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
