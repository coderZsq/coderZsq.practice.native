// 21-初始化列表和默认参数.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

//void test(int age = 10) {
//
//}

class Person {
	int m_age;
	int m_height;
public:
	/*Person() : Person(0, 0) {
	
	}

	Person(int age) : Person(age, 0) {
	
	}*/

	// 默认参数只能写在函数的声明中
	Person(int age = 0, int height = 0);
};

// 构造函数的初始化列表只能写在实现中
Person::Person(int age, int height) : m_age(age), m_height(height) {

}

int main() {
	Person person;
	Person person2(10);
	Person person3(20, 180);

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
