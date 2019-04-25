// 28-纯虚函数.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

// 类似于Java中接口, 抽象类
// 类似于OC中的协议protocol

// Animal是个抽象类
class Animal {
public:
	virtual void speak() = 0;
	virtual void run() = 0;

	/*void test() {
	
	}

	virtual void test2() {
	
	}*/
};

class Cat : public Animal {
public:
	void run() {
		cout << "Cat::run()" << endl;
	}
};

class WhiteCat :public Cat {
public:
	void speak() {
		cout << "Cat::speak()" << endl;
	}
	void run() {
		cout << "Cat::run()" << endl;
	}
};

int main() {
	// Error	C2259	'Cat': cannot instantiate abstract class
	// new Cat();
	Cat* cat = new WhiteCat();

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
