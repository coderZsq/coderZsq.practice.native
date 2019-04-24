// 12-构造函数.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

struct Person
{
	int m_age;

	Person() {
		cout << "Person()" << endl;
		// this->m_age = 0;
		memset(this, 0, sizeof(Person));
	}

	Person(int age) {
		cout << "Person(int age)" << endl;
		this->m_age = age;
	}
};

// 全局区
Person g_person1; // Person()

Person g_person2(); // 这是一个函数声明, 函数名叫g_person2, 无参, 返回值类型是Person

//Person g_person2() {
//
//}
//
//int getAge();
//
//int getAge() {
//
//}

Person g_person3(10); // Person(int age)

int main()
{
	// 栈空间
	Person person1; // Person()
	Person person2(); // 函数声明, 函数名叫person2, 无参, 返回值类型是Person 
	Person person3(20); // Person(int age)

	// 堆空间
	Person* p1 = new Person; // Person()
	Person* p2 = new Person(); // Person()
	Person* p3 = new Person(30); // Person(int age)

	// 4次无参构造函数

	/*Person person;
	person.m_age = 10;*/
	/* 实现构造函数
	lea         ecx,[ebp-0Ch]  
	call        009A1429 // 调用构造函数 
	mov         dword ptr [ebp-0Ch],0Ah
	*/
	/* 未实现构造函数
	mov         dword ptr [ebp-8],0Ah 
	*/

	//Person* p1 = new Person();

	//Person* p2 = (Person*)malloc(sizeof(Person)); 不会调用构造函数

	/*Person person1;
	Person person2(20);*/

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
