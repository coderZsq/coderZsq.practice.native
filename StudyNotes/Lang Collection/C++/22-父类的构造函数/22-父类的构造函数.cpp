// 22-父类的构造函数.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

//class Person {
//	int m_age;
//public:
//	//Person() {
//	//	cout << "Person()" << endl;
//	//	//m_age = 0;
//	//}
//};
//
//class Student : public Person {
//	int m_score;
//public:
//	//Student() {
//	//	cout << "Student()" << endl;
//	//	//m_score = 0;
//	//}
//};
//
//class GoodStudent :public Student {
//	int m_salary;
//public:
//	GoodStudent() {
//		cout << "GoodStudent()" << endl;
//		//m_salary = 0;
//	}
//};

//class Person {
//	int m_age;
//public:
//	Person() {
//		cout << "Person()" << endl;
//	}
//	Person(int age) : m_age(age) {
//		cout << "Person(int age)" << endl;
//	}
//};
//
//class Student :public Person {
//	int m_score;
//public:
//	Student() {
//		cout << "Student()" << endl;
//	}
//	Student(int age, int score) : m_score(score), Person(age) {
//		cout << "Student(int age, int score)" << endl;
//	}
//};

class Person {
	int m_age;
public:
	Person(int age) :m_age(age) {
		cout << "Person(int age)" << endl;
	}
};

class Student :public Person {
	int m_score;
public:
	Student() :Person(0) {
		
	}
};

int main() {
	Student student;
	//Student student1(18, 100);

	//GoodStudent student;
	/*
	lea         ecx,[student]  
	call        GoodStudent::GoodStudent (0A5141Fh)
	->  mov         ecx,dword ptr [this]  
	    call        Student::Student (0A510E1h)
	*/

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
