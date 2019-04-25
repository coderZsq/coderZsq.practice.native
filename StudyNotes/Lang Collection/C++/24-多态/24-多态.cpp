// 24-多态.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Animal {
public:
	virtual void run() {
		cout << "Animal::run()" << endl;
	}
};

class Dog :public Animal {
public:
	void run() {
		cout << "Dog::run()" << endl;
	}
};

class ErHa :public Dog {
public:
	void run() {
		cout << "ErHa::run()" << endl;
	}
};

int main() {
	/*Animal* animal0 = new Animal();
	animal0->run();

	Animal* animal1 = new Dog();
	animal1->run();

	Animal* animal2 = new ErHa();
	animal2->run();*/

	/*Dog* dog0 = new Dog();
	dog0->run();

	Dog* dog1 = new ErHa();
	dog1->run();*/

	getchar();
	return 0;
}

/*
面向对象的3大特性
封装
继承
多态

重写 (override) : 子类重写(覆盖)父类的方法
重载 (overload)
*/

//class Animal {
//public:
//	virtual void run() {
//		cout << "Animal::run()" << endl;
//	};
//};
//
//class Cat :public Animal {
//public:
//	void run() {
//		cout << "Cat::run()" << endl;
//	};
//};
//
//class Dog :public Animal {
//public:
//	void run() {
//		cout << "Dog::run()" << endl;
//	};
//};
//
//class Pig :public Animal {
//public:
//	void run() {
//		cout << "Pig::run()" << endl;
//	};
//};

//void liu(Dog* dog) {
//	dog->run();
//	// ....
//}
//
//void liu(Cat* cat) {
//	cat->run();
//	// ....
//}
//
//void liu(Pig* pig) {
//	pig->run();
//	// ....
//}

//void liu(Animal* animal) {
//	animal->run();
//	// ....
//}

//int main() {
//
//	liu(new Dog());
//	liu(new Cat());
//	liu(new Pig());
//
//	// 静态
//	/*Animal* cat = new Cat();
//	cat->run();*/
//	/*
//	mov         ecx,dword ptr [cat]  
//	call        Animal::run (0F21217h)
//	*/
//
//	/*Dog* dog = new Dog();
//	dog->run();*/
//
//	getchar();
//	return 0;
//}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
