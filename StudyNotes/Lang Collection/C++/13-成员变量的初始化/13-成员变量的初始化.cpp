// 13-成员变量的初始化.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

void test() {
//    int *p = new int();
//    memset(p, 1, 4);
//    // 0000 0001 0000 0001 0000 0001 0000 0001
//    cout << *p << endl;
//
//    int *p = (int *) malloc(8);
//    free(p);
    
//    int *p = (int *)malloc(2);
//    *p = 5;
    
    // 0000 0000 0000 0000 0000 0000 0000 0101
}

struct Person
{
	int m_age;

	//Person() { // 如果自定义构造函数, 除了全局区, 需要进行初始化
	//	cout << "Person()" << endl;
	//}
};

// 全局区 (成员变量初始化为0)
Person g_person;
int g_age; // 数据段成员变量默认为0

int main()
{
	// 栈空间 (成员变量没有初始化)
	// Error	C4700	uninitialized local variable 'person' used
	Person person;

	// 堆空间
	Person* p1 = new Person; // 成员变量没有初始化
	Person* p2 = new Person(); // 成员变量有初始化

	cout << "g_person " << g_person.m_age << endl; //0
	//cout << "person " << person.m_age << endl; //wrong
	cout << "p1 " << p1->m_age << endl; //-842150451
	cout << "p2 " << p2->m_age << endl; //0

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
