// 36-单例模式.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Person {
public:
	static int ms_count;
};

int Person::ms_count = 0;

class Student :public Person {
public:
	static int ms_count;
};

int Student::ms_count = 0;

int main() {
	Person::ms_count = 10;
	Student::ms_count = 20;
	cout << &Person::ms_count << endl;
	cout << &Student::ms_count << endl;
}

/*
单例模式
在程序运行过程中, 可能会希望某些类的实例对象永远只有一个

1. 把构造函数私有化
2. 定义一个私有的静态成员变量指针, 用于指向单例对象
3. 提供一个公共的返回单例对象的静态成员函数
*/

// Person类的实例对象可以有多个
//class Person {
//};
/*
class Rocket {
public:
	// C++: 静态成员函数
	// Java, OC 类方法
	static Rocket* shareRocket() {
		// API p_thread
		// static Rocket* ms_rocket = NULL;
		if (ms_rocket == NULL) {
			ms_rocket = new Rocket();
		}
		return ms_rocket;
	}
	static void deleteRocket() {
		if (ms_rocket == NULL) return;
		delete ms_rocket;
		ms_rocket = NULL;
	}
private:
	static Rocket* ms_rocket;
	Rocket() {
		cout << "Rocket()" << endl;
	}
	~Rocket() {
		cout << "~Rocket()" << endl;
	}
};

Rocket* Rocket::ms_rocket = NULL;

int main() {
	//int* p = new int();
	//*p = 5;
	//delete p;
	//p = NULL;
	//mov         dword ptr[p], 0

	Rocket* p1 = Rocket::shareRocket();
	Rocket* p2 = Rocket::shareRocket();
	Rocket* p3 = Rocket::shareRocket();
	Rocket* p4 = p3->shareRocket();
	cout << p1 << endl;
	cout << p2 << endl;
	cout << p3 << endl;

	Rocket::deleteRocket();

	getchar();
	return 0;
}
*/
// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
