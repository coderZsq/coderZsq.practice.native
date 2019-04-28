// 43-默认构造函数.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

/*
编译器会为每个类生成一个默认的无参的构造函数
*/
//class Car {
//public:
	//int m_price = 0;
	/*
	mov         eax,dword ptr [this]  
	mov         dword ptr [eax],0  
	*/
	//Car() {
		/*
		mov         ecx,dword ptr [this]  
		call        Car::Car (03613BBh) 
		*/
	//}
//};

class Person {
public:
	//Car car;
	//int m_age = 10;
	/*
	mov         eax,dword ptr [this]  
	mov         dword ptr [eax+4],0Ah 
	*/
	//virtual void run() {
		/*
		mov         eax,dword ptr [this]  
		mov         dword ptr [eax],offset Person::`vftable' (01157B34h) 
		*/
	//}
	/*Person() {
		cout << "Person() - " << this << endl;
	}*/
};

//class Student :public Person {
//
//};

//class Student :virtual public Person {
	/*
	mov         eax,dword ptr [this]  
	mov         dword ptr [eax],offset Student::`vbtable' (0D77B30h)
	*/
//};

int main() {
	//Person person;

	//Student student;

	//Person person;
	/*
	lea         ecx,[person]  
	call        Person::Person (0115111Dh)
	*/

	/*Person person;
	person.m_age = 10;*/

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
