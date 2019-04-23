// 06-const.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

struct Student {
	int age;
};

int func() {
	return 10;
}

int sum(int* a, int* b) {
	cout << "sum(int* a, int* b)" << endl;
	return *a + *b;
}

int sum(const int* a, const int* b) {
	cout << "sum(const int* a, const int* b)" << endl;
	return *a + *b;
}

int sum(int& a, int& b) {
	cout << "sum(int& a, int& b)" << endl;
	return a + b;
}

int sum(const int& a, const int& b) {
	cout << "sum(const int& a, const int& b)" << endl;
	return a + b;
}

int main()
{
	int age = 10;
	int& rAge = age;
	rAge = 20;
	/*
	00F76062  mov         dword ptr [age],0Ah  
	00F76069  lea         eax,[age]  
	00F7606C  mov         dword ptr [rAge],eax  
	00F7606F  mov         eax,dword ptr [rAge]  
	00F76072  mov         dword ptr [eax],14h
	*/

	/*int v1 = 10;
	int v2 = 20;
	sum(&v1, &v2);

	const int v3 = 10;
	const int v4 = 20;
	sum(&v3, &v4);

	sum(50, 60);*/

	/*int a = 20;
	int b = 30;
	int age = 10; //4 */
	//const double& ref = age; //8
	//const int& rAge = func();
	//const int& rAge = 40;
	//const int& rAge = a + b;

	// 引用的本质就是指针
	//int age = 10;

	// 不能通过引用修改所指向的内容
	//int const& rAge = age;
	//rAge = 30; //wrong

	// rAge的指向不能改
	//int& const rAge = age;
	//rAge = 30; //true

	/*// 不能通过指针修改所指向的内容
	int const* pAge1 = &age;

	// 不能修改指针的指向, 但是可以通过指针修改所指向的内容
	int* const pAge2 = &age;*/

	/*Student stu1 = { 10 };
	Student stu2 = { 20 };

	const Student*  pStu = &stu1;
	*pStu = stu2;
	(*pStu).age = 30;
	pStu->age = 40;
	pStu = &stu2;*/

	// const 修饰的是右边的内容
	/*int height = 20;
	int age = 10;

	// *p0是常量, p0不是常量
	const int* p0 = &age;
	*p0 = 20; //wrong
	p0 = &height;

	// *p1是常量, p1不是常量
	int const* p1 = &age;
	*p1 = 20; //wrong
	p1 = &height;

	// *p2不是常量, p2是常量
	int* const p2 = &age;
	*p2 = 20; 
	p2 = &height; //wrong

	// *p3是常量, p3是常量
	const int* const p3 = &age;
	*p3 = 20; //wrong
	p3 = &height; //wrong

	// *p4是常量, p4是常量
	int const* const p4 = &age;
	*p4 = 20; //wrong
	p4 = &height; //wrong*/

	//Student stu = { 20 };
	//stu.age = 40;

	//const Student* pStu = &stu;
	//pStu->age = 50;//wrong

	//cout << stu.age << endl;

	/*const int age = 10;

	const Student stu = { 20 };
	Student stu2 = { 40 };
	stu = stu2; //wrong
	stu.age = 50; //wrong*/

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
