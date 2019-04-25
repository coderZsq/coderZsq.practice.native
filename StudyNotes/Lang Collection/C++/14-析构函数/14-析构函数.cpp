// 14-析构函数.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Person
{
	int m_age;
public:
	// 对象创建完毕的时候调用
	Person() {
		cout << "Person()" << endl;
		this->m_age = 0;
	}

	Person(int age) {
		cout << "Person(int age)" << endl;
		this->m_age = age;
	}

	// 对象销毁(内存被回收)的时候调用
	~Person() {
		cout << "~Person()" << endl;
	}
};

//void test() {
//	Person person;
//}

int main()
{
	Person person;
	/*{
		Person person;
	}*/

	/*Person* p = new Person();
	
	delete p;*/

	/*Person* p = (Person*)malloc(sizeof(Person));

	free(p);*/

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
