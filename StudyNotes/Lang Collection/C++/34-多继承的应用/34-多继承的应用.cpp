// 34-多继承的应用.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

// 多继承:增加程序的复杂度

// 多继承有一个很好的用途
// 一个类实现多个接口 (Java)
// 一个类遵守多份协议 (OC)
// 一个类继承多个抽象类 (C++)

class JobBaomu {
	virtual void clean() = 0;
	virtual void cook() = 0;
};

class JobTeacher {
	virtual void playBaseball() = 0;
	virtual void playFootball() = 0;
};

class SaleMan :public JobBaomu {
	void clean() {

	}

	void cook() {

	}
};

class Student :public JobBaomu, public JobTeacher {
	void clean() {

	}

	void cook() {
	
	}

	void playBaseball() {
	
	}

	void playFootball() {
	
	}
};

int main() {

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
