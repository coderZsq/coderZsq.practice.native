// 20-初始化列表.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

int myAge() {
	cout << "myAge()" << endl;
	return 30;
}

int myHeight() {
	cout << "myHeight()" << endl;
	return 180;
}

//struct Person {
//	int m_age;
//	int m_height;
//
//	Person() {
//		this->m_age = 0;
//		this->m_height = 0;
//	}
//
//	// 初始化列表 : m_age(age), m_height(height)
//	/*Person(int age, int height) : m_height(height), m_age(m_height) {
//		
//	}*/
//	Person(int age, int height) : m_height(myHeight()), m_age(myAge()) {
//
//	}
//
//	//Person(int age, int height) {
//	//	this->m_age = age;
//	//	this->m_height = height;
//	//	/*
//	//	mov         eax, dword ptr[ebp - 8]
//	//	mov         ecx, dword ptr[ebp + 8]
//	//	mov         dword ptr[eax], ecx
//	//	mov         eax, dword ptr[ebp - 8]
//	//	mov         ecx, dword ptr[ebp + 0Ch]
//	//	mov         dword ptr[eax + 4], ecx*/
//	//}
//
//	void display() {
//		cout << "m_age is " << this->m_age << endl;
//		cout << "m_height is " << this->m_height << endl;
//	}
//};

struct Person {
	int m_age;
	int m_height;

	Person() : Person(0, 0) {
		/*
		mov         ecx,dword ptr [this]  
		call        Person::Person (0134137Fh)
		*/
		cout << "Person()" << this << endl; //0137FA90
		this->m_age = 0;
		this->m_height = 0;

		// 直接调用构造函数, 会创建一个临时对象, 传入一个临时的地址值给this指针
		//P erson(0, 0);
		/*Person temp;
		temp.Person(0, 0);*/
		/*
		push        0  
		push        0  
		lea         ecx,[ebp+FFFFFF28h]  
		call        0083137F  
		*/
	}

	Person(int age, int height) : m_age(age), m_height(height) {
		cout << "Person(int age, int height)" <<  this << endl; //0137F8E0
		this->m_age = age;
		this->m_height = height;
	}

	void display() {
		cout << "m_age is " << this->m_age << endl;
		cout << "m_height is " << this->m_height << endl;
	}
};

int main() {
	Person person;
	// person.Person();
	/*
	lea         ecx,[ebp-10h]  
	call        00B1114F 
	*/
	person.display();

	/*Person person2(10, 20);
	person2.display();*/

	/*Person person1;
	person1.display();*/

	//cout << "-------------------" << endl;

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
