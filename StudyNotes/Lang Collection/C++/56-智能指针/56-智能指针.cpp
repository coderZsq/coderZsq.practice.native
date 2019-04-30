// 56-智能指针.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

void test() {
	throw 6;
}

void test1() {
	try {
		int* p = new int();
		test();
		delete p;
	}
	catch (...) {
		cout << "出现异常" << endl;
	}
}

class Person {
public:
	Person() {
		cout << "Person()" << endl;
	}
	~Person() {
		cout << "~Person()" << endl;
	}

	void run() {
		cout << "Person::run()" << endl;
	}
};

void test2() {
	/*Person* p = new Person();
	delete p;*/

	//cout << "1" << endl;
	//{
	//	auto_ptr<Person> p(new Person());
	//	p->run();
	//	/*
	//	call        std::auto_ptr<Person>::__autoclassinit2 (0281244h)
	//	call        std::auto_ptr<Person>::operator-> (010B1410h)  
	//	call        Person::run (010B1401h)
	//	*/
	//}
	//cout << "2" << endl;
	
	/*{
		auto_ptr<Person> p(new Person[5]{});
		p->run();
	}*/
}

template <class T>
class SmartPointer {
	T* m_pointer;
public:
	SmartPointer(T* pointer) :m_pointer(pointer) {}
	~SmartPointer() {
		if (m_pointer == nullptr) return;
		delete m_pointer;
	}
	T* operator->() {
		return m_pointer;
	}
};

int main() {
	cout << "1" << endl;
	{
		SmartPointer<Person> p(new Person());
		p->run();
	}
	cout << "2" << endl;

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
