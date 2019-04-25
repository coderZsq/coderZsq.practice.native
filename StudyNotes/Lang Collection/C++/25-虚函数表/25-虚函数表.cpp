// 25-虚函数表.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Animal {
public:
	int m_age;
	virtual void speak() {
		cout << "Animal::speak()" << endl;
	}
	virtual void run() {
		cout << "Animal::run()" << endl;
	}
};

class Cat : public Animal {
public:
	int m_life;
	Cat() :m_life(0) {}
	void speak() {
		cout << "Cat::speak()" << endl;
	}
	void run() {
		cout << "Cat::run()" << endl;
	}
};


int main() {
	cout << sizeof(Animal) << endl;

	// cout << sizeof(Cat) << endl;
	Animal *animal = new Animal();

	Animal *cat1 = new Cat();
	cat1->speak();
	/*
	// 取出cat1指针变量里面存储的地址值
	// eax里面存放的是Cat对象的地址值
	mov         eax,dword ptr [cat1]  
	// 取出cat1对象的前面4个字节给edx
	// edx里面存储的是虚表的地址
	mov         edx,dword ptr [eax]
	// 取出cat1的地址赋值给 ecx, this指针
	mov         ecx,dword ptr [cat1] 
	// 取出虚表中的前面4个字节给eax
	// eax存放的就是Cat::speak的函数地址
	mov         eax,dword ptr [edx]  
	call        eax  
	*/
	cat1->run();
	/*
	mov         eax,dword ptr [cat1]  
	mov         edx,dword ptr [eax]  
	mov         ecx,dword ptr [cat1] 
	// 取出虚表中的后面4个字节给eax
	// eax存放的就是Cat::speak的函数地址 
	mov         eax,dword ptr [edx+4]  
	call        eax
	*/
	Animal *cat2 = new Cat();
	Animal *cat3 = new Cat();
	
	// 只有一张虚表, 且不会销毁

	Animal* animal1 = new Animal(); //找Animal的虚表
	animal1->m_age = 10;
	animal1->run();

	Animal* animal2 = new Cat(); //找Cat的虚表
	animal2->run();


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
